#Ref: https://stackoverflow.com/questions/32852388/jquery-datatables-no-data-available-in-table
#Sometimes data not rendering with no data available in table error - have invcluded JS in bhf_dsc_desgin.js to attempt a fix

dataDictionaryUI <- function(id){
  ns <- NS(id)
  tagList(
    
    
    
    
    #possible solution to the no data available - refresh
    # div(
    #     use_hover(),
    #     hover_action_button(
    #       inputId = "refresh_dd",
    #       label = "",
    #       icon = icon("refresh"),
    #       width='40px',
    #       icon_animation = "spin"
    #     )),
    
    fluidRow(column(12,
                    
    reactableOutput(ns("tbl")),
    uiOutput(ns("summary_dd_plot_render")),
    
    dropdown(
      
      
      id = "download_dd",
      inputId = "download_dd",
      
      
      fluidRow(align="center", style="margin-top: -11%;
      padding-top: -11%;
      padding-left: -11.3%;
      margin-left: -11.3%;
      padding-right: -10.9%;
      margin-right:-10.9%;
      padding-bottom:3%;",
               h6("Download Data", 
                  style="color:white;background-color:#A0003C;
                   font-size:100%;
                   padding-top: 3%;
                   padding-bottom:3.5%;
                   border-top-left-radius: 10px !important;
                   border-top-right-radius: 10px !important;")),
      
      wellPanel(style = "background:white;border:white;margin-left:-3%;margin-right:-3%;
                                                           padding-top:5px;padding-bottom:5px;padding-left:0px;padding-right:0px;
                                                           border-top:5px;border-bottom:5px;border-left:0px;border-right:0px;",
                # radioButtons(inputId="dict_download_type",
                #              choiceNames = list(
                #                tags$span(style = "font-size:100%;", "Selected input only"),
                #                tags$span(style = "font-size:100%;", "Full dataset")
                #              ),
                #              choiceValues = list("selected","full"),
                #              label = NULL,
                #              selected="selected"
                # )
      ),
      
      fluidRow(align="center",h6("Save as:", style="color:#3D3C3C;margin-bottom:4%;")),
      wellPanel(style = "background:white;border:white;margin-top:-0%;padding:0px;border:0px;",
                fluidRow(downloadButton(outputId=ns("download_dd_csv"),"CSV (.csv)",icon=NULL)),
                fluidRow(downloadButton(outputId=ns("download_dd_xlsx"),"Excel (.xlsx)",icon=NULL)),
                fluidRow(downloadButton(outputId=ns("download_dd_txt"),"Text (.txt)",icon=NULL))
      ),

      size = "xs",
      status = "myClass",
      label = "Download Data",
      icon = icon("file-lines"),
      up = TRUE
    ),
    
    
    #simulate a click on the dropdown button when input$rnd changes (see server)
    #see server side too
    tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_csv', function(x){
                                                                     $('html').click();});")
    ),
    
    tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_xlsx', function(x){
                                                                     $('html').click();});")
    ),
    
    tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_txt', function(x){
                                                                     $('html').click();});")
    ),
    ))
    
  )
}

dataDictionaryServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
      
      dataset_desc_filter = reactive({
        datasets_available %>%
          filter(.data$Nation == nation_summary()) %>% 
          filter(.data$Dataset == dataset_summary())
      })
      
      grouped_datasets = datasets_available %>% filter(Dataset != dataset_dataset) %>%
        distinct(Dataset) %>%
        pull(Dataset)
      
      ##########################################################################
      
      
      dd_render = reactive({datasets_available %>%
          filter(.data$Dataset == dataset_summary()) %>%
          select(.data$dictionary,.data$dictionary_reason)
      })
      
      output$dd_render_binary = renderUI({dd_render() %>% pull(dictionary)})
      output$summary_dd_plot_render = renderUI({dd_render() %>% pull(dictionary_reason)})
      outputOptions(output, "dd_render_binary", suspendWhenHidden = FALSE)

      observe({
        toggle(id = "summary_dd_plot_render", condition = isTRUE(dataset_summary() %in% dd_render_messages))
      })
      observe({
        toggle(id = "tbl", condition = isFALSE(dataset_summary() %in% dd_render_messages))
      })
  
      ##########################################################################
      dataset_names = reactive({(
        t.dataset_dashboard %>%
          filter(dataset_dataset == dataset_summary()) %>%
          select(dataset="dataset_dataset","Dataset"=title_dataset))
      })
      
     ## England and Scotland reactive  - designed for table format
      data_dict = reactive({
        
        
        validate(need(dataset_summary() ,
                      message = FALSE))
        
        if(nation_summary() == "Scotland"){
          t.data_dictionaryScot  %>% 
            left_join(select(datasets_available, c("table","dataset_dataset")), by=c("table")) %>%
            filter(dataset_dataset == dataset_summary())  %>%
            mutate(Dataset = table) %>%
            mutate(dataset=dataset_dataset) %>%
            select(-dataset_dataset,-table)  %>% 
            select_if(~!(all(is.na(.)) | all(. == "")))
        }
        
        else if(nation_summary() == "Wales" ){
          t.data_dictionaryWales %>% 
            left_join(select(datasets_available, c("table","Dataset")), by=c("table"))  %>% 
            filter(Dataset == dataset_summary()) %>%
            select(-table) 
          
        }

        
        else if(nation_summary() == "England" ){
          t.data_dictionaryEng %>%
            select("table") %>%
            left_join(select(datasets_available, c("table","Dataset","Title","title_dataset","dataset_dataset")),
                      by=c("table")) %>%
            filter(Dataset == dataset_summary()) %>%
            select(-Dataset) %>%
            mutate(Dataset = title_dataset) %>%
            distinct() %>%
            #select(-Title,-title_dataset) %>%
            left_join(t.data_dictionaryEng, by = "table") %>%
            select(-table,-database,-dataset_dataset,-path) #-x
        }
        
      })
      
      
      ##########################################################################
      bar_chart <- function(label, width = "100%", height = "1rem", fill = "#00bfc4", background = NULL) {
        bar <- div(style = list(background = fill, width = width, height = height))
        chart <- div(style = list(flexGrow = 1, marginLeft = "0.8rem", background = background), bar)
        div(style = list(display = "flex", alignItems = "center"), div(label, id="dd_completeness"), chart)
      }
      
      
      render.reactable.cell.with.tippy <- function(text, tooltip){
        div(

          style = "
                cursor: info;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;",
          tippy(text = text, tooltip = div(tooltip,id = "tippy_dd"), placement = "top") #see app.R
        )
      }

      
      
      ##########################################################################
      completeness_data = reactive({
        
        if(nation_summary() == "England" ){
          t.dataset_completeness = t.dataset_completeness_eng
        }
        else if (nation_summary() == "Wales" ){
          t.dataset_completeness = t.dataset_completeness_wales
        }
        else if (nation_summary() == "Scotland" ){
          t.dataset_completeness = t.dataset_completeness_scotland
        }
        
        t.dataset_completeness %>%
          filter(dataset == dataset_summary()) %>%
          mutate(column_name = trimws(column_name)) %>%
          mutate(completeness = round(completeness*100,2)) %>%
          arrange(desc(completeness),column_name)
          #left_join(dataset_names())
        
      })
      
      
      ##########################################################################
      
      #colour gradient
      colorCompleteness = colorRampPalette(compare_colours)
      
      color_data = reactive({completeness_data() %>%
          distinct(completeness) %>% bind_cols(
            tibble(colours = colorCompleteness(nrow(completeness_data() %>% distinct(completeness))))) %>%
          left_join(select(completeness_data(),c(completeness,column_name,dataset)),by = "completeness") %>%
          left_join(dataset_names())
        })
      
      
      ##########################################################################
        
          
          my_data = reactive({ if(dataset_summary() %in% grouped_datasets){
            data_dict() %>%
              group_by(Dataset) %>%
              rename_with(str_to_title) %>%
              mutate(Position = row_number()) %>%
              ungroup() %>%
              relocate(Position)# %>%
            #             rename(Label=`Field Name`,Description=`Field Description`,Type=`Field Type`,Format=`Variable_type`)
          } else {
            
            if(nation_summary() == "Scotland" ){
              data_dict() %>%
                select(-Dataset) %>%
                rename_with(str_to_title) %>%
                mutate(Position = row_number()) %>%
                relocate(Position) %>%
                left_join((color_data()),
                          by=c("Dataset"="dataset","Field"="column_name")) %>%
                select(-Dataset) %>%
                #mutate(Dataset = ifelse(Title==Title_dataset, NA, Title_dataset)) %>%
                #select(where(not_all_na)) %>%
                select(-Dataset.y) %>%
                rename(Description = "Field Description", Label="Field Name",Type="Field Type",Notes=Comments)
              
            } else if (nation_summary() == "England" ){
              
              data_dict() %>%
                rename_with(str_to_title) %>%
                mutate(Position = row_number()) %>%
                relocate(Position) %>%
                left_join(color_data(), by=c("Dataset"="Dataset","Field"="column_name")) %>%
                select(-Dataset) %>%
                #mutate(Dataset = ifelse(Title==Title_dataset, NA, Title_dataset)) %>%
                #select(where(not_all_na)) %>%
                select(-Title,-Title_dataset,-dataset) %>%
                rename(Description="Field Description",Format="Variable_type",Label="Field Name",Type="Field Type")
              
            } else if (nation_summary() == "Wales" ){
              
              data_dict() %>%
                rename_with(str_to_title) %>%
                mutate(Position = row_number()) %>%
                relocate(Position) %>%
                rename(Field=Variable) %>%
                left_join((color_data()%>%select(-Dataset)%>%rename(Dataset=dataset)), by=c("Dataset"="Dataset","Field"="column_name")) %>%
                select(-Dataset) %>%
                rename(Format=`Data Type`)
                #mutate(Dataset = ifelse(Title==Title_dataset, NA, Title_dataset)) %>%
                #select(where(not_all_na)) %>%
                #select(-dataset)

              
            }
            

          }})
      
      
          
          
          ##########################################################################
        
          # observe({print(data_dict() %>%head(1))})
          # observe({print(completeness_data() %>%head(1))})
          # observe({print(color_data() %>%head(1))})
          # observe({print(my_data() %>%head(1))})
          
          
          
          ##########################################################################
      
      data_dict_react = reactive({
        
        #needed to prevent error when changing nation
        if (nrow(dataset_desc_filter())==0){
          tibble()
        } else {
      
        reactable(
          data = my_data()%>%mutate(completeness=(sprintf("%5.1f", completeness)))
          
          ,
          
          groupBy = if(dataset_summary() %in% grouped_datasets){"Dataset"} else {NULL},
          paginateSubRows = TRUE,
          
          class = "my-tbl",
          columns = list(
            Position = colDef(style = list(whiteSpace = "nowrap", textOverflow = "unset"),maxWidth = 100,sticky = "left"),
            #Dataset = colDef(minWidth = 400),
            Field = colDef(minWidth = 200,sticky = "left"),   # 50% width, 200px minimum
            `Label` = colDef(minWidth = 200),   # 25% width, 100px minimum
            `Description` = colDef(
              minWidth = 400,
              html = TRUE,
              cell =  function(value, index, name) {
                render.reactable.cell.with.tippy(text = value, tooltip = value)}
            ),
            `Values` = colDef(
              minWidth = 200,
              html = TRUE,
              cell =  function(value, index, name) {
                render.reactable.cell.with.tippy(text = value, tooltip = value)}
            ),
            completeness = colDef(name = "Completeness (%)",
                                  sticky = "right",
                          align = "left",
                          minWidth = 200,
                          cell = function(value,index) {
                            width = paste0(value,"%")
              bar_chart(value, width = width, #(sprintf("%5.1f", value))
                        fill = my_data()$colours[index],
                        background = "#e1e1e1") #see css dd_completness for how padded the completeness values
            }),
            `colours` = colDef(show = FALSE)
          ),
 

      
          showSortable = TRUE,
          defaultColDef = colDef(
            align = "left",
            minWidth = 100,
            headerStyle = list(background = '#8D0033', height = 40, color="white", overflow = "visible") #"#413C45"

          ),
          
          theme = reactableTheme(
            # color = "hsl(233, 9%, 87%)",
            # backgroundColor = "hsl(233, 9%, 19%)",
            # borderColor = "hsl(233, 9%, 22%)",
            # stripedColor = "hsl(233, 12%, 22%)",
            # highlightColor = "hsl(233, 12%, 24%)",
            # inputStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
            # selectStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
            # pageButtonHoverStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
            # pageButtonActiveStyle = list(backgroundColor = "hsl(233, 9%, 28%)"),
            #searchInputStyle = list(width = "100%")
          ),
          
    

          #striped = TRUE,
          wrap = FALSE,
          resizable = TRUE,
          searchable = TRUE,
          
          highlight = TRUE,
          
          minRows = 5,
          showPageSizeOptions = TRUE,
          defaultPageSize = 5,
          pageSizeOptions = c(5, 10, 20, nrow(data_dict())),
          #paginationType = "jump",
          onClick = "expand"
        )

      }})
    
      
      
      

      output$tbl = renderReactable(

        {data_dict_react()}
        
        )



      output$download_dd_csv = downloadHandler(
        filename = function() {paste0("data_dictionary_",str_remove_all(Sys.Date(),"-"),".csv")},
        content = function(file) {write_csv(
          (data_dict() %>%
             rename_with(str_to_title) %>%
             mutate(dataset = dataset_summary()) %>%
             mutate(export_date = Sys.Date())),
          path=file)}
      )
      
      observe({
        if(is.null(input$rnd_csv)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_csv', click)
            var compare_csv = document.getElementById('summary_module-data_dictionary_module-download_dd_csv')
            compare_csv.onclick = function() {click += 1; Shiny.onInputChange('rnd_csv', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_csv, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_csv", ""))
      })
      
      
      output$download_dd_xlsx = downloadHandler(
        filename = function() {paste0("data_dictionary_",str_remove_all(Sys.Date(),"-"),".xlsx")},
        content = function(file) {writexl::write_xlsx(
          (data_dict() %>%
             rename_with(str_to_title) %>%
             mutate(dataset = dataset_summary()) %>%
             mutate(export_date = Sys.Date())),
          format_headers = FALSE,
          path=file)}
      )
      
      observe({
        if(is.null(input$rnd_excel)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_excel', click)
            var compare_xlsx = document.getElementById('summary_module-data_dictionary_module-download_dd_xlsx')
            compare_xlsx.onclick = function() {click += 1; Shiny.onInputChange('rnd_excel', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_excel, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_xlsx", ""))
      })
      
      
      output$download_dd_txt = downloadHandler(
        filename = function() {paste0("data_dictionary_",str_remove_all(Sys.Date(),"-"),".txt")},
        content = function(file) {write_tsv(
          (data_dict() %>%
             rename_with(str_to_title) %>%
             mutate(dataset = dataset_summary()) %>%
             mutate(export_date = Sys.Date())),
          path=file)}
      )
      
      observe({
        if(is.null(input$rnd_txt)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_txt', click)
            var compare_csv = document.getElementById('summary_module-data_dictionary_module-download_dd_txt')
            compare_txt.onclick = function() {click += 1; Shiny.onInputChange('rnd_txt', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_txt, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_txt", ""))
      })
      
      
      
    }
  )
}
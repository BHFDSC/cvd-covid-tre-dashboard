
# UI ----------------------------------------------------------------------



dataCompletenessUI <- function(id){
  ns <- NS(id)
  tagList(
   
    fluidRow(

      # Inputs -----------------------------------------------------------------
      column(3,
             
             # div(id="complete_checkbox",class="complete_checkbox",
             # prettyRadioButtons(
             #   inputId = ns("order_complete"),
             #   shape = "curve",
             #   label = "Order:",
             #   selected = "value",
             #   choices = c("Alphabetically"="alpha", "Value"="value"))),
             HTML("<br>"),
             radioButtons(
               inputId = ns("order_complete"),
               label = "Order:",
               selected = "value",
               choices = c("Alphabetically"="alpha", "Position"="position" ,"Value"="value")),
             
             fluidRow(column(12,
                             dropdown(
                               id = "completeness_dropdown_image_plot",
                               inputId = "completeness_dropdown_image_plot",
                               
                               fluidRow(align="center", style="margin-top: -11%;
            padding-top: -11%;
            padding-left: -11.3%;
            margin-left: -11.3%;
            padding-right: -10.9%;
            margin-right:-10.9%;
            padding-bottom:3%;",
            h6("Download Plot", 
               style="color:white;background-color:#A0003C;
                     font-size:100%;
                     padding-top: 3%;
                     padding-bottom:3.5%;
                     border-top-left-radius: 10px !important;
                    border-top-right-radius: 10px !important;")),
            
            fluidRow(align="center",h6("Save as:", style="color:#3D3C3C;margin-top:-3%;margin-bottom:4%;")),
            fluidRow(downloadButton(outputId=ns("download_summary_completeness_plot_jpeg"),"JPEG (.jpeg)",icon=NULL)),
            fluidRow(downloadButton(outputId=ns("download_summary_completeness_plot_pdf"),"PDF (.pdf)",icon=NULL)),
            fluidRow(downloadButton(outputId=ns("download_summary_completeness_plot_png"),"PNG (.png)",icon=NULL)),
            
            size = "xs",
            status = "myClass",
            label = "Download Plot",
            icon = icon("file-image"),
            up = TRUE
                             ),        
            
            # simulate a click on the dropdown button when input$rnd changes (see server)
            # see server side too
            tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_jpeg', function(x){
                                                                     $('html').click();});")
            ),
            
            tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_pdf', function(x){
                                                                     $('html').click();});")
            ),
            
            tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_png', function(x){
                                                                     $('html').click();});")
            ))),
             
             fluidRow(column(12,
                             dropdown(
                               
                               
                               id = "download_completeness_data",
                               inputId = "download_completeness_data",
                               
                               
                               fluidRow(align="center", style="margin-top: -11%;
                                                                            padding-top: -9%;
                                                                            padding-left: -11.1%;
                                                                            margin-left: -11.1%;
                                                                            padding-right: -11.1%;
                                                                            margin-right:-11.1%;
                                                                            padding-bottom:3%;",
                                        h6("Download Data", 
                                           style="color:white;background-color:#A0003C;
                                                                            font-size:100%;
                                                                            padding-top: 3%;
                                                                            padding-bottom:3.5%;
                                                                            border-top-left-radius: 10px !important;
                                                                            border-top-right-radius: 10px !important;")),

                     
                     fluidRow(align="center",h6("Save as:", style="color:#3D3C3C;margin-bottom:4%;")),
                     wellPanel(style = "background:white;border:white;margin-top:-0%;padding:0px;border:0px;margin-left:7%;margin-right:2%",
                               fluidRow(downloadButton(outputId=ns("download_completeness_data_csv"),"CSV (.csv)",icon=NULL)),
                               fluidRow(downloadButton(outputId=ns("download_completeness_data_xlsx"),"Excel (.xlsx)",icon=NULL)),
                               fluidRow(downloadButton(outputId=ns("download_completeness_data_txt"),"Text (.txt)",icon=NULL))
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
                     
                     tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_excel', function(x){
                                                                     $('html').click();});")
                     ),
                     
                     tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_txt', function(x){
                                                                     $('html').click();});")
                     ),))
             ),
      # Outputs ----------------------------------------------------------------
      column(9,
             girafeOutput(ns("completeness_plot_girafe"), height='100%'))
             ))

}


# Server ------------------------------------------------------------------


# Pulling completeness data -----------------------------------------------


   
dataCompletenessServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {
      
      completeness_title_download = reactive({paste("Data Completeness - ", pull(filter(t.dataset_dashboard,Dataset==dataset_summary()),Title))})

      # pull the variable names from a chosen dataset to use as test data
      completeness_test_data = reactive({
        
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
        mutate(completeness_tooltip = paste0(column_name, ": ",format(.data$completeness, nsmall=0, big.mark=",", trim=TRUE),"%")) %>%
        arrange(desc(completeness),column_name) %>%
        mutate(value_name_order = row_number()) %>%
        #for alpha order ensure numeric columns ordered correctly too
        mutate(column_name_rev = stringi::stri_reverse(column_name)) %>%
        separate(column_name_rev, into="num", remove=FALSE) %>%
        mutate(num = as.numeric(stringi::stri_reverse(num))) %>%
        mutate(column_name_order = ifelse(is.na(num),column_name,
                                          stringi::stri_reverse(split_occurrence(column_name_rev,sep="_",n=1,keep="rhs")))) %>%
        arrange(column_name_order,num) %>%
        mutate(column_alpha_order = row_number()) %>%
        #reset order for colour palette
        arrange(desc(completeness),column_name)

      })


# Colour selections -------------------------------------------------------

            
      #colour gradient
      colorCompleteness = colorRampPalette(compare_colours)
      
      colour_palette = reactive({completeness_test_data() %>% 
        distinct(completeness) %>% bind_cols(
          tibble(colours = colorCompleteness(nrow(completeness_test_data() %>% distinct(completeness))))) %>%
        left_join(select(completeness_test_data(),c(completeness,column_name)),by = "completeness")})
      
      colour_values = reactive({
        setNames(
          pull(select(colour_palette(),colours)),
          pull(select(colour_palette(),column_name))
        )
      })

# Joins with data dictionary ----------------------------------------------


            
      plot_data = reactive({
        
        if(nation_summary() == "England"){
        completeness_test_data() %>%
          left_join(datasets_available,by=c("dataset"="Dataset")) %>%
          left_join((
            t.data_dictionaryEng %>%
              mutate(position = row_number())
          ), by=c("column_name"="field","table"="table"))}
        
        
        else if(nation_summary() == "Scotland"){
          completeness_test_data() %>%
            left_join(datasets_available,by=c("dataset"="Dataset")) %>%
            left_join((
              t.data_dictionaryScot %>%
                mutate(position = row_number())
            ), by=c("column_name"="Variable Name Provided","table"="table"))} #need to update what the field name is
        
        else if(nation_summary() == "Wales"){
            completeness_test_data() %>%
            left_join(datasets_available,by=c("dataset"="Dataset")) %>%
            left_join((
              t.data_dictionaryWales %>%
                mutate(position = row_number())
            ), by=c("column_name"="Variable","table"="table"))} # Have updated the 'field' name to 'Variable'

          })
      
      completeness_plot = reactive({ ggplot(data=(plot_data()),
                                                     aes(
                                                       if(input$order_complete=="alpha"){
                                                         #x=forcats::fct_rev(reorder(column_name,column_name))
                                                         x=forcats::fct_rev(reorder(column_name,column_alpha_order))
                                                       } else if (input$order_complete=="position"){
                                                         x=forcats::fct_rev(reorder(column_name,position)) 
                                                         } 
                                                       else {x=reorder(column_name, desc(value_name_order))}, 
                                                     y=completeness,
                                                     fill = column_name,
                                                     tooltip = completeness_tooltip,
                                                     data_id = column_name)) +
          geom_bar_interactive(stat="identity"
                               , size = 0.35
                               , width=0.9
                               ) +
          coord_flip(clip = 'off')  +
          labs(x=""
               ,y=""
               ) +
          scale_fill_manual(values = alpha(colour_values(),0.9)) +
          scale_y_continuous(
                             labels = function(i) {return(paste0(i,"%"))}) +
        
          theme(
            text=element_text(family=family_lato),
            plot.subtitle = element_markdown(size = 11, lineheight = 1.2),
            legend.position = "none",
            plot.title.position = 'plot', #align to outer margin; applies to subtitle too
            #panel.grid.minor = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            plot.background = element_rect(fill='white',color='white'),
            panel.background = element_rect(fill='white',color='white'),
            axis.ticks.y = element_blank(),
            axis.text.x = element_text(size = 6, face = "bold"),
            axis.text.y = element_text(size = if(nrow(completeness_test_data())>=20){3.5}else{4.5}, hjust = 1,face = "bold"),
            axis.ticks.x = element_blank(),
            plot.margin = margin(0,0,0,0)
          ) 
      })
      
  
      
      output$completeness_plot_girafe = renderGirafe({
        ggiraph::girafe(ggobj = completeness_plot(),
                        
                        options = list(opts_hover(css = ""), #want shape to inherit the underlying aes on hover whilst other shapes go inv
                                       opts_hover_inv(css = "opacity:0.3;"),
                                       opts_sizing(rescale = TRUE, width = 1),
                                       opts_tooltip(
                                         opacity = .95,
                                         css = "background-color:#FF0030;
            color:white;font-size:10pt;font-style:italic;
            padding:5px;border-radius:10px 10px 10px 10px;"
                                       ),
            opts_toolbar(saveaspng = FALSE),
            opts_selection(type="none")),
            
            height_svg = (
              if (nrow(completeness_test_data()) >= 150) {
                10
              }
              else if (nrow(completeness_test_data()) < 150 & nrow(completeness_test_data()) >= 120) {
                8
              }
              else if (nrow(completeness_test_data()) < 120 & nrow(completeness_test_data()) >= 100) {
                6
              }
              else if (nrow(completeness_test_data()) < 100 & nrow(completeness_test_data()) >= 80) {
                5
              }
              else if (nrow(completeness_test_data()) < 80 & nrow(completeness_test_data()) >= 20) {
                4
              }
              else if (nrow(completeness_test_data()) < 20 & nrow(completeness_test_data()) >= 15) {
                3.5
              }
              else if (nrow(completeness_test_data()) < 15 & nrow(completeness_test_data()) >= 10) {
                3
              }
              else if (nrow(completeness_test_data()) < 10 & nrow(completeness_test_data()) >= 5) {
                2
              }
              else if (nrow(completeness_test_data()) < 5 & nrow(completeness_test_data()) >= 3) {
                1.5
              }
              else {
                1.2
              }
            )
            #width_svg  = 9
            
            )
      })
      
      
      output$download_summary_completeness_plot_jpeg = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".jpeg")},
        content = function(file) {ggsave(file, 
                                         plot = (completeness_plot() +
                                                   ggtitle(completeness_title_download()) +
                                                   geom_text(aes(label = paste(.data$completeness,"%")),
                                                             vjust = 0.6, hjust = -0.3, size = if(nrow(completeness_test_data())>=20){4}else{5}, color="#4D4C4C") +
                                                   theme(plot.margin = margin(20,50,20,50),
                                                         axis.text.x = element_text(size = 18, face = "bold"),
                                                         axis.text.y = element_text(size = if(nrow(completeness_test_data())>=20){12}else{18}, face = "bold"),
                                                         axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0),
                                                                                     face = "bold", size=18, color="#4D4C4C"),
                                                         plot.title.position = "plot", #left align title
                                                         plot.title = element_text(color="#4D4C4C", size=28,
                                                                                   face = "bold", margin = margin(t = 6, r = 0, b = 16, l = 0)
                                                         )
                                                   )),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         #width = 9, 
                                         units = "in",
                                         bg = "transparent",
                                         height = (
                                           if (nrow(completeness_test_data()) >= 150) {
                                             10
                                           }
                                           else if (nrow(completeness_test_data()) < 150 & nrow(completeness_test_data()) >= 120) {
                                             8
                                           }
                                           else if (nrow(completeness_test_data()) < 120 & nrow(completeness_test_data()) >= 100) {
                                             6
                                           }
                                           else if (nrow(completeness_test_data()) < 100 & nrow(completeness_test_data()) >= 80) {
                                             5
                                           }
                                           else if (nrow(completeness_test_data()) < 80 & nrow(completeness_test_data()) >= 20) {
                                             4
                                           }
                                           else if (nrow(completeness_test_data()) < 20 & nrow(completeness_test_data()) >= 15) {
                                             3.5
                                           }
                                           else if (nrow(completeness_test_data()) < 15 & nrow(completeness_test_data()) >= 10) {
                                             3
                                           }
                                           else if (nrow(completeness_test_data()) < 10 & nrow(completeness_test_data()) >= 5) {
                                             2
                                           }
                                           else if (nrow(completeness_test_data()) < 5 & nrow(completeness_test_data()) >= 3) {
                                             1.5
                                           }
                                           else {
                                             1.2
                                           }
                                         ),
                                         dpi = 300, device = "jpeg")}
      )
     
      
      output$download_summary_completeness_plot_pdf = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".pdf")},
        content = function(file) {ggsave(file, 
                                         plot = (completeness_plot() +
                                                   ggtitle(completeness_title_download()) +
                                                   geom_text(aes(label = paste(.data$completeness,"%")),
                                                             vjust = 0.6, hjust = -0.3, size = if(nrow(completeness_test_data())>=20){1}else{3}, color="#4D4C4C") +
                                                   theme(plot.margin = margin(20,50,20,50),
                                                         axis.text.x = element_text(size = 8, face = "bold"),
                                                         axis.text.y = element_text(size = if(nrow(completeness_test_data())>=20){3}else{8}, face = "bold"),
                                                         axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0),
                                                                                     face = "bold", size=8, color="#4D4C4C"),
                                                         plot.title.position = "plot", #left align title
                                                         plot.title = element_text(color="#4D4C4C", size=10,
                                                                                   face = "bold", margin = margin(t = 6, r = 0, b = 16, l = 0)
                                                         )
                                                   )),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         #width = 9, 
                                         units = "in",
                                         bg = "transparent",
                                         height = (
                                           if (nrow(completeness_test_data()) >= 150) {
                                             10
                                           }
                                           else if (nrow(completeness_test_data()) < 150 & nrow(completeness_test_data()) >= 120) {
                                             8
                                           }
                                           else if (nrow(completeness_test_data()) < 120 & nrow(completeness_test_data()) >= 100) {
                                             6
                                           }
                                           else if (nrow(completeness_test_data()) < 100 & nrow(completeness_test_data()) >= 80) {
                                             5
                                           }
                                           else if (nrow(completeness_test_data()) < 80 & nrow(completeness_test_data()) >= 20) {
                                             4
                                           }
                                           else if (nrow(completeness_test_data()) < 20 & nrow(completeness_test_data()) >= 15) {
                                             3.5
                                           }
                                           else if (nrow(completeness_test_data()) < 15 & nrow(completeness_test_data()) >= 10) {
                                             3
                                           }
                                           else if (nrow(completeness_test_data()) < 10 & nrow(completeness_test_data()) >= 5) {
                                             2
                                           }
                                           else if (nrow(completeness_test_data()) < 5 & nrow(completeness_test_data()) >= 3) {
                                             1.5
                                           }
                                           else {
                                             1.2
                                           }
                                         ),
                                         dpi = 300, device = "pdf")}
      ) 
  
      
      output$download_summary_completeness_plot_png = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".png")},
        content = function(file) {ggsave(file, 
                                         plot = (completeness_plot() +
                                           ggtitle(completeness_title_download()) +
                                            geom_text(aes(label = paste(.data$completeness,"%")),
                                                      vjust = 0.6, hjust = -0.3, size = if(nrow(completeness_test_data())>=20){4}else{5}, color="#4D4C4C") +
                                           theme(plot.margin = margin(20,50,20,50),
                                                 axis.text.x = element_text(size = 18, face = "bold"),
                                                 axis.text.y = element_text(size = if(nrow(completeness_test_data())>=20){12}else{18}, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0),
                                                                             face = "bold", size=18, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 plot.title = element_text(color="#4D4C4C", size=28,
                                                                           face = "bold", margin = margin(t = 6, r = 0, b = 16, l = 0)
                                                                           )
                                                 )),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         #width = 9, 
                                         units = "in",
                                         bg = "transparent",
                                         height = (
                                           if (nrow(completeness_test_data()) >= 150) {
                                             10
                                           }
                                           else if (nrow(completeness_test_data()) < 150 & nrow(completeness_test_data()) >= 120) {
                                             8
                                           }
                                           else if (nrow(completeness_test_data()) < 120 & nrow(completeness_test_data()) >= 100) {
                                             6
                                           }
                                           else if (nrow(completeness_test_data()) < 100 & nrow(completeness_test_data()) >= 80) {
                                             5
                                           }
                                           else if (nrow(completeness_test_data()) < 80 & nrow(completeness_test_data()) >= 20) {
                                             4
                                           }
                                           else if (nrow(completeness_test_data()) < 20 & nrow(completeness_test_data()) >= 15) {
                                             3.5
                                           }
                                           else if (nrow(completeness_test_data()) < 15 & nrow(completeness_test_data()) >= 10) {
                                             3
                                           }
                                           else if (nrow(completeness_test_data()) < 10 & nrow(completeness_test_data()) >= 5) {
                                             2
                                           }
                                           else if (nrow(completeness_test_data()) < 5 & nrow(completeness_test_data()) >= 3) {
                                             1.5
                                           }
                                           else {
                                             1.2
                                           }
                                         ),
                                         dpi = 300, device = "png")}
      )
      
      
      
      
      observe({
        if(is.null(input$rnd_jpeg)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_jpeg', click)
            var compare_jpeg = document.getElementById('summary_module-data_completeness_module-download_summary_completeness_plot_jpeg')
            compare_jpeg.onclick = function() {click += 1; Shiny.onInputChange('rnd_jpeg', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_jpeg, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_jpeg", ""))
      })
      
      
      observe({
        if(is.null(input$rnd_pdf)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_pdf', click)
            var compare_pdf = document.getElementById('summary_module-data_completeness_module-download_summary_completeness_plot_pdf')
            compare_pdf.onclick = function() {click += 1; Shiny.onInputChange('rnd_pdf', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_pdf, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_pdf", ""))
      })
      
      
      observe({
        if(is.null(input$rnd_png)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_png', click)
            var compare_png = document.getElementById('summary_module-data_completeness_module-download_summary_completeness_plot_png')
            compare_png.onclick = function() {click += 1; Shiny.onInputChange('rnd_png', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_png, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_png", ""))
      })
      
      

      
      
      
      output$download_completeness_data_xlsx = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".xlsx")},
        content = function(file) {writexl::write_xlsx(
          (completeness_test_data() %>%
            arrange(column_name) %>%
            left_join(t.dataset_dashboard %>% select(dataset=Dataset,title=Title)) %>%
            select(dataset,title,column_name,completeness) %>%
             mutate(export_date = Sys.Date())),
          
          format_headers = FALSE,
          path=file)}
      )
      

      output$download_completeness_data_csv = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".csv")},
        content = function(file) {write_csv(
          (completeness_test_data() %>%
             arrange(column_name) %>%
             left_join(t.dataset_dashboard %>% select(dataset=Dataset,title=Title)) %>%
             select(dataset,title,column_name,completeness) %>%
             mutate(export_date = Sys.Date())),

          path=file)}
      )
      
      
      output$download_completeness_data_txt = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".txt")},
        content = function(file) {write_csv(
          (completeness_test_data() %>%
             arrange(column_name) %>%
             left_join(t.dataset_dashboard %>% select(dataset=Dataset,title=Title)) %>%
             select(dataset,title,column_name,completeness) %>%
             mutate(export_date = Sys.Date())),
          
          path=file)}
      )
      
      
      observe({
        if(is.null(input$rnd_csv)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_csv', click)
            var compare_csv = document.getElementById('summary_module-data_completeness_module-download_completeness_data_csv')
            compare_csv.onclick = function() {click += 1; Shiny.onInputChange('rnd_csv', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_csv, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_csv", ""))
      })
      
      
      observe({
        if(is.null(input$rnd_excel)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_excel', click)
            var compare_xlsx = document.getElementById('summary_module-data_completeness_module-download_completeness_data_xlsx')
            compare_xlsx.onclick = function() {click += 1; Shiny.onInputChange('rnd_excel', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_excel, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_excel", ""))
      })
      
      observe({
        if(is.null(input$rnd_txt)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_txt', click)
            var compare_txt = document.getElementById('summary_module-data_completeness_module-download_completeness_data_txt')
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






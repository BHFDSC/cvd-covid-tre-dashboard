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
    
    fluidRow(DTOutput(ns('tbl'))),
    
    downloadButton(ns("download_dd"),
                                   label="Export Data",
                                   icon = icon("file-excel"))
    
  )
}

dataDictionaryServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
## England and Scotland reactive  - designed for table format
      data_dict = reactive({
        
        
        if(nation_summary() == "Scotland"){
          t.data_dictionaryScot %>% 
            left_join(select(datasets_available, c("table","Dataset")), by=c("table")) %>%
            filter(Dataset == dataset_summary())  %>%
            select(-Dataset, -table)  %>% 
            select_if(~!(all(is.na(.)) | all(. == "")))
        }
        
        else if(nation_summary() == "Wales" ){
          t.data_dictionaryWales %>% 
            left_join(select(datasets_available, c("table","Dataset")), by=c("table"))  %>% 
            filter(Dataset == dataset_summary()) %>%
            select(-Dataset, -table) 
          
        }
        
        
        else if(nation_summary() == "England" ){
          t.data_dictionaryEng %>%
            left_join(select(datasets_available, c("table","Dataset")), by=c("table")) %>%
            filter(Dataset == dataset_summary()) %>%
            select(-Dataset,-table,-database) 
          
        }
        
      })
      
      

      output$tbl = renderDataTable(
        
        data_dict() %>%
          rename_with(str_to_title),
        
        selection = "none",
        rownames = FALSE,
        
        #extensions = 'Buttons',

        
        options = list(
          #buttons = c('copy', 'csv', 'excel'),
          escape = FALSE,
          scrollX = TRUE,
          searching = TRUE,
          
          #lengthChange = FALSE,
          pageLength = 5,
          lengthMenu = list(c(5, 10, 20, -1), c('5', '10', '20', 'All')),
          paging = T,
          dom = '<"top"Bfi>rt<"bottom"pl><"clear">', 
          
          columnDefs = list(list(
            targets = "_all",
            render = JS(
              "function(data, type, row, meta) {",
              "return type === 'display' && data != null && data.length > 30 ?",
              "'<span title=\"' + data + '\">' + data.substr(0, 30) + '...</span>' : data;",
              "}"
            )
            
            # rowCallback = JS(
            #   "function(row, data) {",
            #   "var full_text = 'This rows values are :' + data[0] + ',' + data[1] + '...'",
            #   "$('td', row).attr('title', full_text);",
            #   "}")
          ))
        )
      )
      
      
      output$download_dd = downloadHandler(
        filename = function() {paste0("data_dictionary_",str_remove_all(Sys.Date(),"-"),".xlsx")},
        content = function(file) {writexl::write_xlsx(
          (data_dict() %>%
             rename_with(str_to_title) %>%
             mutate(dataset = dataset_summary()) %>%
             mutate(export_date = Sys.Date())),
          
          format_headers = FALSE,
          path=file)}
      )
      
    }
  )
}
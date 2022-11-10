dataDictionaryUI <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(DTOutput(ns('tbl')))
  )
}

dataDictionaryServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
      
      data_dict = reactive({
        data_dictionary %>%
          left_join(select(datasets_available, c("table","Dataset")), by=c("table")) %>%
          filter(Dataset == dataset_summary()) %>%
          select(-Dataset,-table,-database)
      })
      
      output$tbl = renderDataTable(
        
        data_dict(),
        
        selection = "none",
        rownames = FALSE,
        
        options = list(
          scrollX = TRUE,
          searching = TRUE,
          
          lengthChange = FALSE,
          pageLength = 5,
          
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
    }
  )
}
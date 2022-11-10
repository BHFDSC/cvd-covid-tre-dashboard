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
      output$tbl = renderDT(
        data_dictionary %>%
          left_join(datasets_available, by=c("table")) %>%
          filter(Dataset == dataset_summary())
        , options = list(lengthChange = FALSE, pageLength = 5), selection = "none"
      )
    }
  )
}




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
        data_dictionary, options = list(lengthChange = FALSE, pageLength = 5)
      )
    }
  )
}


#######################################
##### Dataset description module ######
#######################################


# module
dataDescriptionUI <- function(id){
  ns <- NS(id)
  tagList(
    
    selectInput(inputId = ns("dataset"),
                label = "Dataset",
                choices = dataset_desc$Dataset),
    textOutput(ns("description"))
  )
}

dataDescriptionServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
      output$description <- renderText({
        paste(dataset_desc$Description[dataset_desc$Dataset == input$dataset])})
    }
  )
}




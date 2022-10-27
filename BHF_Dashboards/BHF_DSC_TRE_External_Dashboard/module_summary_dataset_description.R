#######################################
##### Dataset description module ######
#######################################

#library(shiny)

# test file including dataset descriptions
#dataset_desc <- read.csv("Anna_module/TRE_dataset_descriptions_test.csv")

# real file - not populated yet
# dataset_desc <- read.csv("Anna_module/TRE_dataset_descriptions.csv")

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
      dataset_desc <- read.csv("TRE_dataset_descriptions_test.csv")
      output$description <- renderText({
        paste(dataset_desc$Description[dataset_desc$Dataset == input$dataset])})
    }
  )
}




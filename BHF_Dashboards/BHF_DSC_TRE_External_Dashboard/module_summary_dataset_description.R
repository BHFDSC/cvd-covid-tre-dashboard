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
    
    # selectInput(inputId = ns("dataset"),
    #             label = "Dataset",
    #             choices = dataset_desc$Dataset),
    textOutput(ns("description"))
  )
}

dataDescriptionServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
      

      dataset_desc_filter = reactive({
        dataset_desc %>%
        filter(.data$Dataset == dataset_summary())
      })

         
      observeEvent(dataset_summary(),
      output$description <- renderPrint({
        #to prevent all descriptions rendering print blank until df filtered
        if (nrow(dataset_desc_filter())>1){
          return(cat(""))
        }
        #paste(dataset_desc_filter()$Description[dataset_desc_filter()$Dataset == input$dataset])
        cat(dataset_desc_filter() %>%
          select(Description) %>%
            pull())
        })
      )
    }
  )
}


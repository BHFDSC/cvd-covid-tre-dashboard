library(shiny)

# test file including dataset descriptions
#dataset_desc <- read.csv("TRE_dataset_descriptions_test.csv")

# real file - not populated yet
# dataset_desc <- read.csv("Anna_module/TRE_dataset_descriptions.csv")


ui <- fluidPage(
  selectInput(inputId = "dataset",
              label = "Dataset",
              choices = dataset_desc$Dataset),
  textOutput("description")
)

server <- function(input, output, session) {
  output$description <- renderText({
    paste(dataset_desc$Description[dataset_desc$Dataset == input$dataset])
    }
  )
}


shinyApp(ui, server)


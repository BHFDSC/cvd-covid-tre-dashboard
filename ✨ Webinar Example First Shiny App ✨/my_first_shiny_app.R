library(shiny)
library(tidyverse)

# Sample datasets
data = data.frame(
  Dataset = c(rep("dataset1",3),rep("dataset2",3)),
  Category = c("A", "B", "C", "X", "Y", "Z"),
  Value = c(30, 50, 20,10, 60, 30)
  )


# Define the UI
ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Select a Dataset:", 
                  choices = c("Dataset 1" = "dataset1", "Dataset 2" = "dataset2"))
    ),
    
    mainPanel(
      plotOutput("barplot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  selected_dataset <- reactive({
    data %>% filter(Dataset==input$dataset)
  })
  
  output$barplot <- renderPlot({
    ggplot(selected_dataset(), aes(x = Value, y = Category)) +
      geom_bar(stat = "identity", fill="#7346CB") +
      labs(x = "Value",y = "Category")
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
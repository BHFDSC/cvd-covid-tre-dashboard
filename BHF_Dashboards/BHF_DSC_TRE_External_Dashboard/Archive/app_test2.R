library(shiny)


compareDatasetChoiceUI <- function(id, number) {
  ns <- NS(id)
  tagList(
    selectizeInput("nation_compare", paste("Nation", number), choices = c("England","Scotland","Wales")),
    numericInput("dataset_compare",
                 label = paste0("Dataset ", number),
                 value = 0, min = 0)
  )
}




ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      
      
      compareDatasetChoiceUI("compare",number=1),
      actionButton(inputId = "remove", label = "-"),
      actionButton(inputId = "add", label = "+"),
    ),
    mainPanel(
      
    )
  )
)


server <- function(input, output) {
  input_counter <- reactiveVal(0)
  

  
  observeEvent(input$add, {
    input_counter(input_counter() + 1)
    insertUI(
      selector = "#remove", where = "beforeBegin",
      ui = div(id = paste0("selectize_div",
                           input_counter()),
               selectizeInput(paste0("nation_compare",
                                     input_counter()),
                              label = paste("Nation",input_counter()+1),
                              choices = c("England","Scotland","Wales")),
               numericInput(paste0("dataset_compare",
                                     input_counter()),
                              label = paste("Dataset",input_counter()+1),
                            value = 0, min = 0)
               
               
               )
    )
  })
  observeEvent(input$remove, {
    removeUI(
      selector = paste0("#selectize_div", input_counter())
    )
    input_counter(input_counter() - 1)
  })
  
  
  observe({
    print(input$nation_compare)
    print(input$nation_compare1)
    print(input$nation_compare2)
    print(input$nation_compare3)
    print(names(input))
    print(input$dataset_compare)
    print(input$dataset_compare1)
    print(input$dataset_compare2)
    print(input$dataset_compare3)
  })
  

}



shinyApp(ui, server)
library(shiny)

ui <- fluidPage(
  shinyjs::useShinyjs(),
  numericInput("num", "Enter a number", 7),
  actionButton("submit", "Square that number!"),
  actionButton("reset", "Reset"),
  shinyjs::hidden(
    div(
      id = "results",
      h3("The square is"),
      textOutput("square")
    )
  )
)

server <- function(input, output, session) {
  output$square <- renderText({
    input$submit
    isolate(input$num * input$num)
  })
  
  observeEvent(input$reset, {
    shinyjs::reset("num")
    shinyjs::hide("results")
  })
  
  observeEvent(input$submit, {
    shinyjs::show("results")
  })
}

shinyApp(ui = ui, server = server)
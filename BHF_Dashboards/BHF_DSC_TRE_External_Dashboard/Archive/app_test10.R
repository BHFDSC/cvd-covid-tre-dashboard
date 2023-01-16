library(shiny)
library(shinyjs)


ui <- fluidPage(
  useShinyjs(),
  div(
    id = "loading_page",
    h1("Loading..."),
    actionButton("testid","Click here")
  ),
  hidden(
    div(
      id = "main_content",
      "Data loaded, content goes here"
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$testid,{
    hide("loading_page")
    show("main_content")
  })
}

shinyApp(ui = ui, server = server)
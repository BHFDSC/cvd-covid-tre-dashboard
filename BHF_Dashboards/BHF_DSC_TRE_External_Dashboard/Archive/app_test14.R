library(shiny)
library(shinyjs)

writeLines(".tab1 {
  background-color: black;
  color: white; /* text color */
}", con = "www/dark_mode.css")

writeLines(".tab2 {
  background-color: white;
  color: black; /* text color */
}", con = "www/light_mode.css")

ui <- navbarPage(
  "My App",
  id = "nav",

  tabPanel(inputId='t1', "Tab 1", "This is tab 1"),
  tabPanel(inputId='t2', "Tab 2", "This is tab 2"),
  
  useShinyjs(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "dark_mode.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "light_mode.css")
  ),

  )

server <- function(input, output, session) {
  
  observeEvent(input$nav, {
    if(input$nav == "Tab 1"){
      addCssClass(class = "tab1", selector = ".navbar")
      removeCssClass(class = "tab2", selector = ".navbar")
    } else {
      addCssClass(class = "tab2", selector = ".navbar")
      removeCssClass(class = "tab1", selector = ".navbar")
    }
  })
  
  
}



shinyApp(ui, server)



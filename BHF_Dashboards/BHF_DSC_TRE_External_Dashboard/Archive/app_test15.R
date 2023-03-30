library(shiny)

ui <- navbarPage(
  "My App",
  tabPanel("Tab 1"),
  tabPanel("Tab 2")
)

server <- function(input, output, session) {
  
  selected_tab <- reactive({
    input$tabs
  })
  
  observe({
    if(selected_tab() == "Tab 1") {
      updateNavbarPage(session, "My App", theme = "inverse", 
                       options = list(style = "background-color: pink;"))
    } else if (selected_tab() == "Tab 2") {
      updateNavbarPage(session, "My App", theme = "inverse", 
                       options = list(style = "background-color: blue;"))
    }
  })
  
}

shinyApp(ui, server)
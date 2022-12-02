library(shiny)
library(shinyjs)

## Modify the CSS style of a given selector
modifyStyle <- function(selector, ...) {
  
  values <- as.list(substitute(list(...)))[-1L]
  parameters <- names(values)
  
  args <- Map(function(p, v) paste0("'", p,"': '", v,"'"), parameters, values)
  jsc <- paste0("$('",selector,"').css({", paste(args, collapse = ", "),"});")
  
  shinyjs::runjs(code = jsc)
  
}

# UI for the app
user <- shinyUI(
  navbarPage(title = "", id = "navtab",
             header = div(useShinyjs()),
             tabPanel("Home Page",
                      div(HTML("<h1><b><center>Home Page</center></b></h1>")),
                      "More text."
             ),
             
             tabPanel("Glossary",
                      div(HTML("<h1><b><center>Glossary</center></b></h1>")),
                      "More text."
             )
  )
)

# Server for the app
serv <- shinyServer(function(input, output, session) {
  
  observeEvent(input$navtab, {
    currentTab <- input$navtab # Name of the current tab
    
    if (currentTab == "Home Page") {
      modifyStyle("body", background = "blue", color = "white", 'font-family' = "Arial")
    }
    if (currentTab == "Glossary")  {
      modifyStyle("body", background = "red", color = "white", 'font-family' = "Arial")
    }
  })
  
})

shinyApp(user, serv)
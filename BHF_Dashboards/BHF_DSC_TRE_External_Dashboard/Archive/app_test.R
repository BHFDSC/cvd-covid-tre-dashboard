library(shiny)

row_ui <- function(id) {
  ns <- NS(id)
  fluidRow(
    column(3, 
           selectInput(ns("type_chooser"), 
                       label = "Choose Type:", 
                       choices = c("text", "numeric"))
    ),
    column(9,
           uiOutput(ns("ui_placeholder"))
    )
  )
} 

row_server <- function(input, output, session) {
  return_value <- reactive({input$inner_element})
  ns <- session$ns
  output$ui_placeholder <- renderUI({
    type <- req(input$type_chooser)
    if(type == "text") {
      textInput(ns("inner_element"), "Text:")
    } else if (type == "numeric") {
      numericInput(ns("inner_element"), "Value:", 0)
    }
  })
  
  ## if we later want to do some more sophisticated logic
  ## we can add reactives to this list
  list(return_value = return_value) 
}



ui <- fluidPage(  
  div(id="placeholder"),
  actionButton("addLine", "Add Line"),
  verbatimTextOutput("out")
)

server <- function(input, output, session) {
  handler <- reactiveVal(list())
  
  observeEvent(input$addLine, {
    new_id <- paste("row", input$addLine, sep = "_")
    insertUI(
      selector = "#placeholder",
      where = "beforeBegin",
      ui = row_ui(new_id)
    )
    handler_list <- isolate(handler())
    new_handler <- callModule(row_server, new_id)
    handler_list <- c(handler_list, new_handler)
    names(handler_list)[length(handler_list)] <- new_id
    handler(handler_list)
  })
  
  output$out <- renderPrint({
    lapply(handler(), function(handle) {
      handle()
    })
  })
}

shinyApp(ui, server)
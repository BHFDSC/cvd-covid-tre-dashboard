datasetUI <- function(id) {
  ns <- NS(id)
  fluidRow(
    id = id,
    h6("Choose Dataset"),
    column(width = 10, style = "margin-top:1%; margin-left:0%; margin-right:0%;",
           selectInput(ns("nation"), 
                       "Nation:", 
                       nations_options, 
                       ""),
           selectInput(ns("dataset_compare"),
                       label = "Dataset:",
                       width = '100%',
                       choices = NULL)),
    
    column(width = 1, style = "margin-top:10%; margin-left:0%; margin-right:0%;",
           div(id = "insertui_css",actionButton(ns("delete"), icon("trash"))))
  )
}




datasetServer <- function(input, output, session, event, no) {
  killMe <- reactiveVal(FALSE)
  observe({
    req(input$nation)
    req(event())
    #updateNumericInput(session)
    #updateNumericInput(session)
  })
  
  datasets_available_list = reactive({
    req(input$nation)
    dataset_dashboard_list(nation=input$nation)
  })
  
  observeEvent(datasets_available_list(), {
    updateSelectInput(
      inputId = "dataset_compare",
      choices = c("Choose" = "",datasets_available_list()))
  })
  
  get_data <- reactive({
    req(!is.null(input$nation))
    data.frame(nation  = input$nation,
               dataset = input$dataset_compare,
               number=no)
  })
  
  observeEvent(input$delete,
               killMe(TRUE))
  
  
  
  return(list(delete   = killMe,
              get_data = get_data))
}
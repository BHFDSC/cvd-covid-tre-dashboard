library(shiny)
library(dplyr)


datasetUI <- function(id) {
  ns <- NS(id)
  fluidRow(
    id = id,
    h3("Dataset"),
    column(width = 10, style = "margin-top:1%; margin-left:0%; margin-right:0%;",
           selectInput(ns("year"), 
                       "Year", 
                       c(1990,1991), 
                       "")),

    column(width = 1, style = "margin-top:8.1%; margin-left:0%; margin-right:0%;",
           actionButton(ns("delete"), icon("trash")))
  )
}




datasetServer <- function(input, output, session, event) {
  killMe <- reactiveVal(FALSE)
  observe({
    req(input$year)
    req(event())
    #updateNumericInput(session)
    #updateNumericInput(session)
  })
  
  get_data <- reactive({
    req(!is.null(input$year))
    data.frame(year  = input$year)
  })
  
  observeEvent(input$delete,
               killMe(TRUE))
  
  
  
  return(list(delete   = killMe,
              get_data = get_data))
}

##############################MainApp##############################

moduleTestui <- function(id){

  
  ns <- NS(id)
  tagList(
  
  fluidPage(

    column(3,

      tags$div(id = "Panels"),
      actionButton(ns("add"),
                   "+")
    ),
    column(9,
      tableOutput(ns("table")),
      tableOutput(ns("test"))
    
  )
  )
)
}


moduleTestserver <- function(id) {
  
    moduleServer(
      id,
      function(input, output, session){
        
  
  input_counter <- reactiveVal(1) 
  
  handlers <- reactiveVal(list()) #holds all reactives of the module
  observers <- list() #create (and delete) observers for the kill switch
  
  n <- 1
  
  get_event <- reactive({
    input$events
  })
  
  observeEvent(input$add, {
    id <- paste0("row_", n)
    n <<- n + 1
    input_counter(input_counter() + 1)
    insertUI("#Panels",
             "beforeEnd",
             datasetUI(id=id)
    )
    new_handler <- setNames(list(callModule(datasetServer,
                                            id,
                                            get_event)),
                            id)
    handler_list <- c(handlers(), new_handler)
    handlers(handler_list)
  })
  
  
  observe({
    hds <- handlers()
    req(length(hds) > 0)
    new <- setdiff(names(hds),
                   names(observers))
    
    obs <- setNames(lapply(new, function(n) {
      observeEvent(hds[[n]]$delete(), { #remove the handler from the lists and remove the corresponding html
        removeUI(paste0("#", n))
        hds <- handlers()
        hds[n] <- NULL
        handlers(hds)
        observers[n] <<- NULL
      }, ignoreInit = TRUE)
    }), new)
    
    observers <<- c(observers, obs)
  })
  
  table1 <- reactive({
    hds <- req(handlers())
    req(length(hds) > 0)
    tbl_list <- lapply(hds, function(h) {
      h$get_data()
    })
    do.call(rbind, tbl_list)
  })
  
  output$table = renderTable(table1())
  
  output$test = renderPrint(table1() %>% pull(year))
  

  
      }
)
}


ui = fluidPage(
  
  tabPanel("Summary", moduleTestui(id = "summary_module")))

server = function(input, output, session) {
  
  
  ### Summary Tab ============================================================
  moduleTestserver(id = "summary_module")
  
}

shinyApp(ui, server)
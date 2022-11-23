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





compareUI <- function(id){
ns <- NS(id)

tagList(
    
  
column(3,
           
#tabset panel styling
tags$head(
tags$style('
               
ul.nav-pills{
 background-color: transparent !important;
}
.nav-pills .nav-link.active {
color: #FF001F !important;
background-color:#F3F2F4 !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link.active:hover {
color: #FF001F !important;
background-color:#F3F2F4 !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link {
color: #FF001F;
background-color:white;
border: 1px solid white!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link:hover {
color: #A0003C !important;
background-color:white !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}'
))
),
    

## Data Coverage ===========================================================
fluidRow(titlePanel(h3(id = 'section_heading',"Data Coverage")),
         
         #UI INPUT
         column(3,
                
                tabsetPanel(id = "tab_selected_data_input", type="pills",
                            
                            #DATA INPUT
                            tabPanel(title = "Data", 
                                     value = "data_input",
                                     wellPanel(style = bhf_tab_panel_style,
                                               
                                               # prettySwitch(inputId = ns("multi_nation"), 
                                               # label = "Multi nation comparison", 
                                               # fill=TRUE),
                                               
                                               #conditionalPanel(condition = "input.multi_nation",
                                               
                                               #NATION 1
                                               # selectizeInput(ns("nation_compare_initial"), paste("Nation 1:"),
                                               #                choices = c("Choose" = "",nations_options)),
                                               # 
                                               # #DATAWSET 1
                                               # selectInput(ns("dataset_compare_initial"),
                                               #             label = paste0("Dataset 1:"),
                                               #             width = '100%',
                                               #             choices = NULL),
                                               # 
                                               # #NATION 2
                                               # selectizeInput(ns("nation_compare_initial2"), paste("Nation 2:"),
                                               #                choices = c("Choose" = "",nations_options)),
                                               # 
                                               # #DATASET 2
                                               # selectInput(ns("dataset_compare_initial2"),
                                               #             label = paste0("Dataset 2:"),
                                               #             width = '100%',
                                               #             choices = NULL),
                                               # 
                                               # #ADD/REMOVE ADDITIONAL INPUT
                                               # actionButton(inputId = ns("remove"), label = "-"),
                                               # actionButton(inputId = ns("add"), label = "+")
                                               
                                               tags$div(id = "Panels"),
                                               actionButton("add",
                                                            "+")
                                               
                                               )
                                     ),
                  
                            #PLOT INPUT
                            tabPanel(title = "Plot", 
                                     value = "plot_input", 
                                     wellPanel(style = bhf_tab_panel_style,
                                               
                                               #DATE RANGE SLIDER
                                               sliderInput(inputId = ns("date_range_coverage2"),
                                                 label = "Date Range:",
                                                 #initialise values
                                                 min = 2018, max = 2021, 
                                                 value = c(2018,2021), 
                                                 step=1, sep = ""),
                                     
                                               #EXTREME VALUES
                                               prettySwitch(inputId = ns("all_records"),
                                                            label = "Show extreme dates", fill = TRUE),
                                               
                                               #TYPE INPUT
                                               radioButtons(
                                                 inputId = ns("type_compare"),
                                                 label = "Order:",
                                                 selected = count_options_selected,
                                                 choices = count_options)
                                               
                                               )
                                     )
                            )
                ),
         
         #UI OUTPUT
         column(9,

                tableOutput("table"),
                tableOutput("test")

                ),
         
        # column(9,textOutput(ns("test")))
         
         ))
}


compareServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      #Dynamic Dataset options depending on Nation selected
      
      # #DATASET 1
      # datasets_available_list_initial = reactive({
      #   req(input$nation_compare_initial)
      #   dataset_dashboard_list(nation=input$nation_compare_initial)
      # })
      # 
      # observeEvent(datasets_available_list_initial(), {
      #   updateSelectInput(
      #     inputId = "dataset_compare_initial",
      #     choices = c("Choose" = "",datasets_available_list_initial()))
      # })
      # 
      # #DATASET 2
      # datasets_available_list_initial2 = reactive({
      #   req(input$nation_compare_initial2)
      #   dataset_dashboard_list(nation=input$nation_compare_initial2)
      # })
      # 
      # observeEvent(datasets_available_list_initial2(), {
      #   updateSelectInput(
      #     inputId = "dataset_compare_initial2",
      #     choices = c("Choose" = "",datasets_available_list_initial2()))
      # })
      
      
        
        
        
        
        
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
                 datasetUI("testing",id=id)
        )
        new_handler <- setNames(list(callModule(datasetServer,
                                                "testing",
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
      
      
      

      #output$download_compare_coverage_plot = downloadHandler()

      
      # observe({
      # 
      #   print(names(input))
      # 
      #   print(input$"nation_compare_initial") #1
      #   print(input$"dataset_compare_initial")
      #   print(input$"nation_compare_initial2") #2
      #   print(input$"dataset_compare_initial2")
      # 
      #   print(input$"nation_compare2") #3
      #   print(input$"dataset_compare2")
      #   print(input$"nation_compare3") #4
      #   print(input$"dataset_compare3")
      #   print(input$"nation_compare4") #5
      #   print(input$"dataset_compare4")
      # })

    }
  )
}
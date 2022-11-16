#https://stackoverflow.com/questions/38083286/r-shiny-how-to-dynamically-append-arbitrary-number-of-input-widgets
#https://stackoverflow.com/questions/70583847/shiny-app-adding-unlimited-number-of-input-bars
#https://stackoverflow.com/questions/55461532/r-shiny-dynamic-ui-in-insertui
#https://stackoverflow.com/questions/56407118/r-shiny-inserting-dynamic-ui-inside-a-shiny-module

#Module UI
compareDatasetChoiceUI <- function(id, number) {
  ns <- NS(id)
  tagList(
    
    selectizeInput(ns("nation_compare"), paste("Nation", number,":"), choices = nations_options),
    selectInput(ns("dataset_compare"),
                 label = paste0("Dataset ", number, ":"),
                width = '100%',
                choices = NULL),

  )
}

#Moduler Server
compareDatasetChoiceServer <- function(id) {
  moduleServer(id,
               function(input, output, session) {
                 ns <- session$ns
                 
                 datasets_available_list = reactive({
                   req(input$nation_compare)
                   dataset_dashboard_list(nation = input$nation_compare)
                 })
                 
                 observeEvent(datasets_available_list(), {
                   updateSelectInput(
                     inputId = "dataset_compare",
                     choices = c("Choose" = "", datasets_available_list())
                   )
                 })
                 
               })
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
             
             column(3,
                    
                    tabsetPanel(id = "tab_selected_data_input", type="pills",
                                  tabPanel(title = "Data", 
                                           value = "data_input",
                                           
                                           wellPanel(style = bhf_tab_panel_style,
                                                     
                                                     prettySwitch(inputId = ns("multi_nation"), 
                                                                  label = "Multi nation comparison", 
                                                                  fill=TRUE),
                                                     
                                                     #conditionalPanel(condition = "input.multi_nation",
                                                     selectizeInput(ns("nation_compare_initial"), paste("Nation 1:"), choices = nations_options),
                                                     
                                                     selectInput(ns("dataset_compare_initial"),
                                                                 label = paste0("Dataset 1:"),
                                                                 width = '100%',
                                                                 choices = NULL),
                                                     
                                                     
                                                     compareDatasetChoiceUI(ns("compare"),number=2),
                                                     actionButton(inputId = ns("remove"), label = "-"),
                                                     actionButton(inputId = ns("add"), label = "+")
                                                     
                                           #)
                                                     )
                                           ),
                  
                  tabPanel(title = "Plot", 
                           value = "plot_input", 
                           
                           wellPanel(style = bhf_tab_panel_style,
                                     
                                     sliderInput(inputId = ns("date_range_coverage"),
                                                 label = "Date Range:",
                                                 #initialise values
                                                 min = 2020, max = 2021, 
                                                 value = c(2020,2021), 
                                                 step=1, sep = ""
                                     ),
                                     
                                     prettySwitch(inputId = ns("all_records"), label = "Show extreme dates", fill = TRUE)  %>% 
                                       add_prompt(
                                         message = "Select records recorded outwith data collection start date and current date",
                                         position = "right", type = "error", 
                                         size = "small", rounded = TRUE
                                       )
                            
                            )
                           )
                  )
                  ),
                
                column(6,  tags$div(girafeOutput(ns("compare_coverage_plot_girafe"),
                                                 width = '100%', height = '85%')))
              
    ))
    
  
}


compareServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      #Dynamic Dataset options depending on Nation selected
      datasets_available_list_initial = reactive({
        req(input$nation_compare_initial)
        dataset_dashboard_list(nation=input$nation_compare_initial)
      })
      
      observeEvent(datasets_available_list_initial(), {
        updateSelectInput(
          inputId = "dataset_compare_initial",
          choices = c("Choose" = "",datasets_available_list_initial()))
      })
      

      input_counter <- reactiveVal(1) #start counter at 1 instead of 0 as want 2 initial datasets
      
      observeEvent(input$add, {
        input_counter(input_counter() + 1)
        insertUI(
          selector = paste0("#", ns("remove")), where = "beforeBegin",
          ui = div(id = "selectize_div_all", #adding an extra top level div to control style of all that are added
                   
               div(id = paste0("selectize_div"
                               ,input_counter()
                               ),
                   
                   selectizeInput(ns(paste0("nation_compare",
                                         input_counter())),
                                  label = paste("Nation",input_counter()+1,":"),
                                  choices = c("England","Scotland","Wales")),
  
                   selectInput(ns(paste0("dataset_compare",
                                         input_counter())),
                           label = paste("Dataset",input_counter()+1,":"),
                           width = '100%',
                           choices = NULL)
                   ),
               )
          )
      })
      
      
      datasets_available_list = reactive({
        req(input[[paste0("nation_compare",input_counter())]])
        dataset_dashboard_list(nation=input[[paste0("nation_compare",input_counter())]])
      })
      
      observeEvent(datasets_available_list(), {
        updateSelectInput(
          inputId = paste0("dataset_compare",
                           input_counter()),
          choices = c("Choose" = "",datasets_available_list()))
      })
      

      
      observeEvent(input$remove, {
        removeUI(
          selector = paste0("#selectize_div", input_counter())
        )
        input_counter(input_counter() - 1)
      })

      observe({

        print(names(input))

        print(input$"nation_compare_initial") #1
        print(input$"dataset_compare_initial")
        print(input$"compare-nation_compare") #2
        print(input$"compare-dataset_compare")
        print(input$"nation_compare2") #3
        print(input$"dataset_compare2")
        print(input$"nation_compare3") #4
        print(input$"dataset_compare3")
      })

      compareDatasetChoiceServer("compare")
    }
  )
}
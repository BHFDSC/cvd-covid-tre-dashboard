#https://stackoverflow.com/questions/38083286/r-shiny-how-to-dynamically-append-arbitrary-number-of-input-widgets
#https://stackoverflow.com/questions/70583847/shiny-app-adding-unlimited-number-of-input-bars

compareDatasetChoiceUI <- function(id, number) {
  ns <- NS(id)
  tagList(
    
    selectizeInput(ns("nation_compare"), paste("Nation", number), choices = nations_options),
    numericInput(ns("dataset_compare"),
                 label = paste0("Dataset ", number),
                 value = 0, min = 0)
  )
}



compareUI <- function(id){
  ns <- NS(id)
  tagList(
    
    
    column(3,
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
}


'))
),
    

    ## Data Coverage ===========================================================
    fluidRow(titlePanel(h3(id = 'section_heading',"Data Coverage")),
             
             column(3,tabsetPanel(id = "tab_selected_data_input", type="pills",
                                  tabPanel(title = "Data", 
                                           value = "data_input",
                                           wellPanel(style = bhf_tab_panel_style,
                                                     
                                                     prettySwitch(inputId = ns("multi_nation"), 
                                                                  label = "Multi nation comparison", 
                                                                  fill=TRUE),
                                                     
                                                     selectizeInput(ns("nation_compare_initial"), paste("Nation 1"), choices = nations_options),
                                                     numericInput(ns("dataset_compare_initial"),
                                                                  label = paste0("Dataset 1"),
                                                                  value = 0, min = 0),
                                                     
                                                     
                                                     compareDatasetChoiceUI(ns("compare"),number=2),
                                                     actionButton(inputId = ns("remove"), label = "-"),
                                                     actionButton(inputId = ns("add"), label = "+")

                               
                           
                           # div(id = "nation2_css",
                           #     class = "nation2_css",
                           #     selectInput(inputId = ns("nation_summary2"),
                           #                 label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                           #                 selected = NULL,
                           #                 choices = nations_options)),     
                           # 
                           # div(id = "dataset2_css",
                           #     class = "dataset2_css",
                           #     selectInput(inputId = ns("dataset_summary2"),
                           #                 label = shiny::HTML("<p></p><span style='color: white'>Dataset:</span>"),
                           #                 width = '100%',
                           #                 choices = NULL))
                           )
                           ) %>% 
                             tagAppendAttributes(class = 'tabtest'),
                  
                  tabPanel(title = "Plot", 
                           value = "plot_input", 
                           
                           wellPanel(style = bhf_tab_panel_style,
                                     
                            prettySwitch(inputId = ns("multi_nation_2"), label = "Multi nation comparison", fill = TRUE)
                            
                            )
                           )
                  )
                  ),
                
                column(6,  tableOutput("test2"),
                       verbatimTextOutput("test1"))
              
    ))
    
  
}


compareServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      # Global Input ===========================================================
      #Define global input from main module that can be passed to nested modules
      # global_dataset_summary <- reactive(input$dataset_summary2)
      # global_nation_summary <- reactive(input$nation_summary2)
      # 
      # #Dynamic Dataset options depending on Nation selected
      # datasets_available_list = reactive({
      #   req(input$nation_summary2)
      #   dataset_dashboard_list(nation=input$nation_summary2)
      # })
      # observeEvent(datasets_available_list(), {
      #   updateSelectInput(
      #     inputId = "dataset_summary2",
      #     choices = datasets_available_list())
      # })
      

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
                                  label = paste("Nation",input_counter()+1),
                                  choices = c("England","Scotland","Wales")),
                   numericInput(ns(paste0("dataset_compare",
                                       input_counter())),
                                label = paste("Dataset",input_counter()+1),
                                value = 0, min = 0))
                   
                   
          )
          
          
        )
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

      
    }
  )
}
compareUI <- function(id){
  ns <- NS(id)
  tagList(
    
    # Global Input =============================================================
    
    ## Data Coverage ===========================================================
    
              fluidRow(
                
                titlePanel(h3(id = 'section_heading',"Data Coverage")),
                
                column(3,tabsetPanel(id = "tab_selected_data_input",
                  
                                    
                  tabPanel(title = "Data", 
                           value = "data_input",
                           
                           wellPanel(style = bhf_tab_panel_style,
                                     
                               prettySwitch(inputId = ns("multi_nation"), label = "Multi nation comparison", fill=TRUE),
                           
                           div(id = "nation2_css",
                               class = "nation2_css",
                               selectInput(inputId = ns("nation_summary2"),
                                           label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                                           selected = NULL,
                                           choices = nations_options)),     
                           
                           div(id = "dataset2_css",
                               class = "dataset2_css",
                               selectInput(inputId = ns("dataset_summary2"),
                                           label = shiny::HTML("<p></p><span style='color: white'>Dataset:</span>"),
                                           width = '100%',
                                           choices = NULL))
                           )
                           ),
                  
                  tabPanel(title = "Plot", 
                           value = "plot_input", 
                           
                           wellPanel(style = bhf_tab_panel_style,
                                     
                            prettySwitch(inputId = ns("multi_nation_2"), label = "Multi nation comparison", fill = TRUE)
                            
                            )
                           )
                  )
                  ),
              
    ))
    
  
}


compareServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Global Input ===========================================================
      #Define global input from main module that can be passed to nested modules
      global_dataset_summary <- reactive(input$dataset_summary2)
      global_nation_summary <- reactive(input$nation_summary2)
      
      #Dynamic Dataset options depending on Nation selected
      datasets_available_list = reactive({
        req(input$nation_summary2)
        dataset_dashboard_list(nation=input$nation_summary2)
      })
      observeEvent(datasets_available_list(), {
        updateSelectInput(
          inputId = "dataset_summary2",
          choices = datasets_available_list())
      })
      
      ## Data Coverage =========================================================

      
    }
  )
}
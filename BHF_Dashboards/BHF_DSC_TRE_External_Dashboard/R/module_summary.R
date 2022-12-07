summaryUI <- function(id){
  ns <- NS(id)
  tagList(
    
    # Global Input =============================================================
    wellPanel(style = wellpanel_style,
              fluidRow(style = bhf_global_options_style,
                       
                       column(3,div(id = "nation_css",
                                  class = "nation_css",
                                  selectInput(inputId = ns("nation_summary"),
                                              label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                                              choices = nations_options))),     
                       
                       
                       column(6,div(id = "dataset_css",
                                  class = "dataset_css",
                                  selectInput(inputId = ns("dataset_summary"),
                                              label = shiny::HTML("<p></p><span style='color: white'>Dataset:</span>"),
                                              width = '100%',
                                              choices = NULL))),
                       
                       column(3)
                       
                       ),
              
              ## Data Overview =================================================
              titlePanel(h3(id = 'section_heading',"Dataset Overview")),
              
              dataDescriptionUI(id = ns("data_description")),
              dataOverviewUI(id = ns("data_overview")),

              ## Data Dictionary ===============================================
              hr(),
              titlePanel(h3(id = 'section_heading_hyper',
                            shinyLink(to = "dd_meth", label = "Data Dictionary") %>% add_prompt(
                              message = "Go to methodology",
                              position = "right", type = "info",
                              arrow=FALSE,
                              size = "s", rounded = TRUE,
                              bounce=FALSE,animate=FALSE)
                            )),

              dataDictionaryUI(id = ns("data_dictionary_module")),


              ## Data Coverage =================================================
              hr(),
              titlePanel(h3(id = 'section_heading_hyper',
                            shinyLink(to = "dcov_meth", label = "Data Coverage") %>% add_prompt(
                              message = "Go to methodology",
                              position = "right", type = "info",
                              arrow=FALSE,
                              size = "s", rounded = TRUE,
                              bounce=FALSE,animate=FALSE)
                            )),

              dataCoverageUI(id = ns("data_coverage_module")),

              ## Data Completeness =============================================
              hr(),
              titlePanel(h3(id='section_heading_hyper',
                            shinyLink(to = "dcom_meth", label = "Data Completeness") %>% add_prompt(
                              message = "Go to methodology",
                              position = "right", type = "info",
                              arrow=FALSE,
                              size = "s", rounded = TRUE,
                              bounce=FALSE,animate=FALSE)
                            #tags$a("Data Completeness",href="https://shiny.rstudio.com/articles/basics.html",target="_blank")
                            )),

              dataCompletenessUI(id = ns("data_completeness_module")),

              
              ## Data Validity =================================================
              #hr(),
              #titlePanel(h3(id='section_heading',"Data Validity")),

              #fluidRow()
              
              )
    
    )
}


summaryServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Global Input ===========================================================
      #Define global input from main module that can be passed to nested modules
      global_dataset_summary <- reactive(input$dataset_summary)
      global_nation_summary <- reactive(input$nation_summary)
      
      #Dynamic Dataset options depending on Nation selected
      datasets_available_list = reactive({
        req(input$nation_summary)
        dataset_dashboard_list(nation=input$nation_summary)
      })
      
      observeEvent(datasets_available_list(), {
        updateSelectInput(
          inputId = "dataset_summary",
          choices = datasets_available_list())
      })

      
      ## Data Overview =========================================================
      dataDescriptionServer(id = "data_description", 
                            dataset_summary=global_dataset_summary, 
                            nation_summary=global_nation_summary) 
      dataOverviewServer(id = "data_overview",
                         dataset_summary=global_dataset_summary,
                         nation_summary=global_nation_summary)


      ## Data Dictionary =======================================================
      dataDictionaryServer(id = "data_dictionary_module",
                           dataset_summary=global_dataset_summary,
                           nation_summary=global_nation_summary)


      ## Dataset Coverage ======================================================
      dataCoverageServer(id = "data_coverage_module",
                         dataset_summary=global_dataset_summary,
                         nation_summary=global_nation_summary)


      ## Dataset Completeness ==================================================

      dataCompletenessServer(id = "data_completeness_module",
                             dataset_summary=global_dataset_summary,
                             nation_summary=global_nation_summary)

      ## Dataset Validity ======================================================
  
    }
  )
}
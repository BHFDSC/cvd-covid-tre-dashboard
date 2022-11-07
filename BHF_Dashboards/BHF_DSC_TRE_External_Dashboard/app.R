# Setup ########################################################################
Version = "1.1.0"

#Libraries
library(shiny)
library(bslib)
library(tidyverse)
library(shinydashboard)
library(shinyWidgets)
library(shinyBS)
library(shinyjs)
library(hover)
library(DT)
library(scales)
library(ggiraph)
library(patchwork)
library(fontawesome)
library(ggtext)
library(prompter)
library(readxl)

library("htmltools")
library("bsplus")

#External Sources
source('bhf_dsc_hds_designkit.R')
source('data.R')
source('inputs.R')
source('common_functions.R')

#Modules
#source('module_data.R')
source('module_summary_dataset_coverage.R')
source('module_summary_dataset_completeness.R')
source('module_summary_global.R')
source('module_appendix.R')
source('module_summary_dataset_overview.R')
source('module_summary_data_dictionary.R')
source('module_summary_dataset_description.R')
source('module_summary_dataset_overview.R')

# Main App Global Input Choices ################################################



# User Interface ---------------------------------------------------------------

ui = fluidPage(

  useShinyjs(),
  #App Theme
  theme = bhf_dsc_hds_bootstrap_theme,
  # Load the dependencies for promter
  use_prompt(),
  #CSS Theme Overrides
  tags$head(tags$style(HTML(bhf_dsc_hds_css))),
  
  ## Navigation Bar ############################################################
  navbarPage(
    bhf_navbar_line,
    #BHF HDS Logo
    title = div(img(src = "bhf_dsc_logo.png",
                    style = "margin-top:17% !important;
                        justify-content: center !important;
                        align-items: center !important;",
                    height = 70)),

    
    ## Dataset Summary Tab =====================================================
    tabPanel("Summary",

             ### Global Input ==================================================

             wellPanel(style = wellpanel_style,
fluidRow(style = bhf_global_options_style,
             column(3,
                    div(id = "nation_css",
                        class = "nation_css",
                        selectInput(inputId = "nation_summary",
                                    label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                                    choices = nations_options))
                    
             ),     

             
             column(6,
                    div(id = "dataset_css",
                        class = "dataset_css",
                        selectInput(inputId = "dataset_summary",
                                    label = shiny::HTML("<p></p><span style='color: white'>Dataset:</span>"),
                                    width = '100%',
                                    choices = NULL))
             ),
             
             
             column(3,
             )
    ),

             ### Dataset Overview ==============================================
             titlePanel(h3(id = 'section_heading',"Dataset Overview")),
             
             dataDescriptionUI(id = "data_description"),
             datasetOverviewUI(id = "data_overview"),
             
             ### Data Dictionary ===============================================
             hr(),
             titlePanel(h3(id = 'section_heading',"Data Dictionary")),
             
             dataDictionaryUI(id = "data_dictionary"),
             
             
             ### Data Coverage =================================================            
             hr(),
             titlePanel(h3(id = 'section_heading',"Data Coverage")),
             
             datasetCoverageUI(id = "data_coverage_module"),
             
             ### Data Completeness =============================================
             hr(),
             titlePanel(h3(id='section_heading',"Data Completeness")),
             
             datasetCompletenessUI(id = "data_completeness_module"),
             
             ### Data Validity =================================================
             hr(),
             titlePanel(h3(id='section_heading',"Data Validity")),
             
             fluidRow(),
             
             
             )),
    
  
    
    ## Compare Tab =======================================================================================
    tabPanel("Compare"),
    
    ## Insight Tab =======================================================================================
    tabPanel("Insight"),
    
    ## Appendix Tab =======================================================================================
    tabPanel("Appendix",
             fluidRow(
               appendixOutput(id = "appendix")
             )
    ),
    
    
    ## Footer ==================================================================
    hr(),
    print(div(id="version_css",paste("Version",Version)))
    
    
    
  )
)


# Server -----------------------------------------------------------------------

server = function(input, output, session) {
  
  ## Dataset Summary Tab =======================================================
  
  ### Global Input =============================================================
  #Define global input from main app that can be passed to modules
  global_dataset_summary <- reactive(input$dataset_summary)
  global_nation_summary <- reactive(input$nation_summary)

  #Dynamic Dataset options depending on Nation selected
  datasets_available = reactive({
    req(input$nation_summary)
    dataset_dashboard_list(nation=input$nation_summary)
  })
  observeEvent(datasets_available(), {
    updateSelectInput(
      inputId = "dataset_summary",
      choices = datasets_available())
  })


  ### Source Data ==============================================================

  ### Dataset Overview =========================================================
  dataDescriptionServer(id = "data_description", 
                        dataset_summary=global_dataset_summary, 
                        nation_summary=global_nation_summary) 
  datasetOverviewServer(id = "data_overview", 
                        dataset_summary=global_dataset_summary, 
                        nation_summary=global_nation_summary) 
  

  ### Data Dictionary ==========================================================
  dataDictionaryServer(id = "data_dictionary", 
                       dataset_summary=global_dataset_summary, 
                       nation_summary=global_nation_summary)
  
  
  ### Dataset Coverage =========================================================
  datasetCoverageServer(id = "data_coverage_module",
                dataset_summary=global_dataset_summary,
                nation_summary=global_nation_summary)
  
  
  ### Dataset Completeness =====================================================
  
  datasetCompletenessServer(id = "data_completeness_module",
                        dataset_summary=global_dataset_summary,
                        nation_summary=global_nation_summary)
  
  ### Dataset Validity =========================================================
  
  
  
  
}





# Run the application ----------------------------------------------------------------------------------------
shinyApp(ui = ui, server = server)
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))

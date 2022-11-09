# Setup ########################################################################
Version = "1.1.0"

#Modules scripts are sourced from the R folder

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
library(ggrepel)
library(htmltools)
library(bsplus)

#External Sources
source('external_common_functions.R')
source('external_bhf_dsc_hds_designkit.R')
source('external_data.R')
source('external_inputs.R')


# User Interface ---------------------------------------------------------------

ui = fluidPage(

  ## UI Setup and Design #######################################################
  useShinyjs(),
  #App Theme
  theme = bhf_dsc_hds_bootstrap_theme,
  # Load the dependencies for promter
  use_prompt(),
  #CSS Theme Overrides
  tags$head(tags$style(HTML(bhf_dsc_hds_css))),
  #JS Script https://shiny.rstudio.com/articles/packaging-javascript.html
  tags$head(tags$script(src="bhf_dsc_design.js")),
  

  ## Navigation Bar ############################################################
  navbarPage(
    bhf_navbar_line,
    #BHF HDS Logo
    title = tags$a(img(src = "bhf_dsc_logo.png",
                    style = "margin-top:7% !important;
                        justify-content: center !important;
                        align-items: center !important;",
                    height = 70), 
                   href="https://www.hdruk.ac.uk/helping-with-health-data/bhf-data-science-centre/"),

    
    ### Summary Tab ============================================================
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
             
    ),
    #tabPanel("Summary", summaryUI(id = "summary_module")),
    
    ### Compare Tab ============================================================
    #tabPanel("Compare", compareUI(id = "compare_module")),
    
    ### Insight Tab ============================================================
    #tabPanel("Insight"),
    
    ### Appendix Tab ===========================================================
    #tabPanel("Appendix",appendixOutput(id = "appendix"))
    
    ),
    
    ## Footer ==================================================================
    hr(),
    tags$footer(htmltools::tags$span("Footer Test", icon("square")))
  
)

# Server -----------------------------------------------------------------------

server = function(input, output, session) {
  
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
  
  ### Summary Tab ============================================================
  #summaryServer(id = "summary_module")
  
  ### Compare Tab ============================================================
  #compareServer(id = "compare_module")
  
  ### Insight Tab ============================================================
  
  ### Appendix Tab ===========================================================

 
}




# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))

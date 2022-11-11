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
library(showtext)

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

    tabPanel("Summary", summaryUI(id = "summary_module")),
    
    ### Compare Tab ============================================================
    tabPanel("Compare", compareUI(id = "compare_module")),
    
    ### Insight Tab ============================================================
    tabPanel("Insight"),
    
    ### Appendix Tab ===========================================================
    tabPanel("Appendix",appendixOutput(id = "appendix"))
    
    ),
    
    ## Footer ==================================================================
    hr(),
    tags$footer(htmltools::tags$span("Footer Test", icon("square")))
  
)

# Server -----------------------------------------------------------------------

server = function(input, output, session) {

  ### Summary Tab ============================================================
  summaryServer(id = "summary_module")
  
  ### Compare Tab ============================================================
  compareServer(id = "compare_module")
  
  ### Insight Tab ============================================================
  
  ### Appendix Tab ===========================================================

 
}


# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))

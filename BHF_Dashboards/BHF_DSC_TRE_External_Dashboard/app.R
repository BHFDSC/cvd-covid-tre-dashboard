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
library(spsComps)
library(shinyalert)

#External Sources
source('external_common_functions.R')
source('external_bhf_dsc_hds_designkit.R')
source('external_data.R')
source('external_inputs.R')


# User Interface ---------------------------------------------------------------

ui = fluidPage(
  

  ## UI Setup and Design #######################################################
  shinyjs::useShinyjs(),
  #App Theme
  theme = bhf_dsc_hds_bootstrap_theme,
  # Load the dependencies for promter
  use_prompt(),
  #CSS Theme Overrides
  tags$head(tags$style(HTML(bhf_dsc_hds_css))),
  #JS Script https://shiny.rstudio.com/articles/packaging-javascript.html
  tags$head(tags$script(src="bhf_dsc_design.js")),

  bsplus::use_bs_tooltip(),
  bsplus::use_bs_popover(),
  

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
    tabPanel("Compare",
             #compareUI(id = "compare_module")
             source("source_compareUI.R",local = TRUE)$value
             ),
    
    ### Insight Tab ============================================================
    #tabPanel("Insight"),
    
    ### Appendix Tab ===========================================================
    tabPanel("Appendix",appendixOutput(id = "appendix")) ,
    
    ### Feedback Button ===========================================================
    
    tabPanel(actionBttn(inputId='ab1', label="Provide Feedback", color = "success", 
                        position = "right",
                        # icon = icon("th"), 
                        # size = lg ,
                        style = "unite"  , 
                        onclick ="window.open('https://forms.office.com/Pages/ResponsePage.aspx?id=saxMhCdwY0Kdihj6pb8IOe1OSlBUSpBCq1NpVakPfMJURTY0TTZCRFlHOUEyMTM3QUJWTkxFR1AwUC4u',)"))
    

    ),
    
    ## Footer ==================================================================
    hr(),
    tags$footer(div(
      class = "footer",
      includeHTML("footer.html")
    ))
  
)

# Server -----------------------------------------------------------------------

server = function(input, output, session) {


  ### Summary Tab ============================================================
  summaryServer(id = "summary_module")
  
  ### Compare Tab ============================================================
  #compareServer(id = "compare_module")
  source("source_compareServer.R",local = TRUE)$value
  
  ### Insight Tab ============================================================
  
  ### Appendix Tab ===========================================================


  
}


# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))

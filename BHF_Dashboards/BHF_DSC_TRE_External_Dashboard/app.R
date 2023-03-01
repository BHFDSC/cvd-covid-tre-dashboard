# Setup ########################################################################
Version = "1.1.0"

#Modules scripts are sourced from the R folder

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
library(reactable)
library(waiter)
library(shinycssloaders)

#External Sources
source('external_common_functions.R')
source('external_bhf_dsc_hds_designkit.R')
source('external_data.R')
source('external_inputs.R')

## change path to a non temp diretory to keep that even after reboot
# shinyOptions(cache = cachem::cache_disk(file.path(dirname(tempdir()), 
#                                                   "myapp-cache")))

shinyOptions(cache = cachem::cache_disk("./bind-cache"))
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
  #tags$head(tags$script(src="bhf_dsc_design.js")),
  tags$head(tags$script(src="shinyLink.js")),
  useWaitress(),
  


  bsplus::use_bs_tooltip(),
  bsplus::use_bs_popover(),
  
  div(
    id = "loading_page",
    
    fixedRow(column(12,
                    style = "text-align:center;margin:0px;padding:0px;border:0px;background:linear-gradient(to right, #e30020, #ed1f54);",
                    fixedRow(img(src = "background_test4.png",
                                 style="margin:0px !important;padding:0px!important;border:0px!important;max-width: 100%; width: 100%;")),
                    fixedRow(column(12,actionButton("testid","Explore the dashboard"),align = "center",style="margin:0px;padding-bottom:30px;border:0px;"))
    )),
    
    
    fluidRow(column(6,img(src = "ai-heart_splash.jpeg",
                          style="align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin:0px !important;padding:0px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;"),
                    style="align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin:0px !important;padding:0px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;"),
             column(6,
                    style="align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin-right:3px;padding-right:3px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;",
                    #fluidRow(column(12,"What is the purpose of this dashboard?",align = "left",style="color:#A0003C;margin:0px;padding-top:20px;border:0px;height:350px;")),
                    fluidRow(column(12,HTML(paste0('<span style="color:#A0003C;margin-right:120px;">What is the purpose of this dashboard?</span><br><br>
<span style="margin-right:120px;display: block;">The dashboard describes the datasets currently available in the BHF Data Science Centre TREs for England, Scotland and Wales. Use the dashboard to explore the data dictionaries, data coverage and data completeness of each of these datasets.</span>'
                                    )))),
                    style="margin:0px;padding-top:20px;border:0px;height:350px;background-color:white;text-align: left;")),

    fluidRow(column(6,
                    style="align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin-left:0px;padding-left:13px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;",
                    #fluidRow(column(12,"What is the purpose of this dashboard?",align = "left",style="color:#A0003C;margin:0px;padding-top:20px;border:0px;height:350px;")),
                    fluidRow(column(12,HTML(paste0('<span style="color:#A0003C;margin-left:120px;display: block;">Who is this dashboard for?</span><br>
                                    <span style="margin-left:120px;display: block;">The dashboard can be used by anyone interested in finding out more about the dataset available within the BHF Data Science Centre TREs. Users additionally have the option of comparing datasets both within and between nations.</span>'
                                    )))),
                    style="margin:0px;padding-top:0px;border:0px;height:350px;background-color:#F3F2F4;text-align: left;"),
             column(6,img(src = "covid_splash.png",
                          style=";background-color:#F3F2F4;align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin:13px !important;padding:13px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;"),
                    style=";background-color:#F3F2F4;align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin:0px !important;padding:0px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;"),
    ),
    
    fluidRow(column(6,img(src = "structured_splash.png",
                          style="align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin:0px !important;padding:0px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;"),
                    style="align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin:0px !important;padding:0px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;"),
             column(6,
                    style="align:centre;display: flex;align-items: center;text-align: center;justify-content: center;
                          margin-right:3px;padding-right:3px!important;border:0px!important;vertical-align: middle;
                          max-width: 50%; width: 50%;",
                    #fluidRow(column(12,"What is the purpose of this dashboard?",align = "left",style="color:#A0003C;margin:0px;padding-top:20px;border:0px;height:350px;")),
                    fluidRow(column(12,HTML(paste0('<span style="color:#A0003C;margin-right:120px;">Using the Dashboard</span><br><br>
                                    <span style="margin-right:120px;display: block;">The dashboard describes the datasets currently available in the BHF Data Science Centre TREs for England, Scotland and Wales. This collection spans a substantial number of sets and proportion of the population considering a researnote some sets are not yet accessible to us, so this will not be as comprehensive as the collections presented by each nation on their websites/dashboards.</span>'
                    )))),
                    style="margin:0px;padding-top:20px;border:0px;height:350px;background-color:white;text-align: left;")),
  ),
  
  
  
  
  hidden(
  div(
  id = "main_content",
  ## Navigation Bar ############################################################
  navbarPage(
    bhf_navbar_line,
    #BHF HDS Logo
    
    
    
    title = tags$a(img(src = "bhf_dsc_logo.png",
                    style = "margin-top:7% !important;
                        justify-content: center !important;
                        align-items: center !important;",
                    height = 70),
                   target = "_blank", #open in new tab
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
    
    ### Methodology Tab ===========================================================
    tabPanel("Methodology",methodologyOutput(id = "methodology")) ,
    
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
      #includeHTML('footer.html') #now archived
      HTML(footer_template(export_date = paste(export_date_england,export_date_scotland,export_date_wales),
                           email_link = "mailto:bhfdsc@hdruk.ac.uk",
                           twitter_link = "https://twitter.com/BHFDataScience?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor",
                           youtube_link = "https://www.youtube.com/channel/UCvpInOwkV-Di0Kt6HwizbDw"
                           ))
))
  
)
)
)

# Server -----------------------------------------------------------------------

server = function(input, output, session) {
  
  observeEvent(input$testid,{
    hide("loading_page", anim = TRUE, animType = "fade", time = 0.4)
    delay(ms = 600, show("main_content", anim = TRUE, animType = "fade", time = 3))
  })
  
  #observe(print(outputOptions(output)))
  #was attempting to load data in background whilst on load page
  #outputOptions(output, "summary_module-data_overview-registrations", suspendWhenHidden = FALSE)
  
  # # call the waitress
  # waitress <- Waitress$
  #   new(theme = "overlay-percent")$
  #   start() # start
  # 
  # for(i in 1:10){
  #   waitress$inc(10) # increase by 10%
  #   Sys.sleep(.3)
  # }
  # 
  # # hide when it's done
  # waitress$close() 
  
  # observeEvent(input$myButton, {
  #   runjs(paste0('$("#ab1").css("animation","")'))
  # })


  ### Summary Tab ============================================================
  summaryServer(id = "summary_module")
  
  ### Compare Tab ============================================================
  #compareServer(id = "compare_module")
  source("source_compareServer.R",local = TRUE)$value
  
  ### Insight Tab ============================================================
  
  ### Methodology Tab ===========================================================


  
}


# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))

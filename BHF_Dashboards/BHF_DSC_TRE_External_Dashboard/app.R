# Setup ########################################################################
Version = "1.1.0"

options(shiny.sanitize.errors = TRUE)


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
library(toOrdinal)
library(sass)

#External Sources
source('external_common_functions.R')
source('external_bhf_dsc_hds_designkit.R')
source('external_data.R')
source('external_inputs.R')

## change path to a non temp directory to keep that even after reboot
# shinyOptions(cache = cachem::cache_disk(file.path(dirname(tempdir()), 
#                                                   "myapp-cache")))

#shinyOptions(cache = cachem::cache_disk("./bind-cache"))
# User Interface ---------------------------------------------------------------


ui = fluidPage(
  

  ## UI Setup and Design #######################################################
  shinyjs::useShinyjs(),

  #App Theme
  theme = bhf_dsc_hds_bootstrap_theme,
  # Load the dependencies for prompter
  use_prompt(),
  #CSS Theme Overrides
  tags$head(tags$style(HTML(bhf_dsc_hds_css))),
  #JS Script https://shiny.rstudio.com/articles/packaging-javascript.html
  tags$head(tags$script(src="bhf_dsc_design.js")),
  tags$head(tags$script(src="shinyLink.js")),

  useWaitress(),
  


  #SCSS code converted to css using sass (message silenced)
  capture.output(
    (sass::sass(
    input = list(
      sass::sass_file("www/bhf_dsc_design.scss")
    ),
    output = "www/bhf_dsc_design_sass.css",
    options = sass::sass_options(output_style = "compressed")
  )),file='NUL'),
  #Then read in from www
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "bhf_dsc_design_sass.css")
  ),

  


  bsplus::use_bs_tooltip(),
  bsplus::use_bs_popover(),
  
  


  div(
  id = "main_content",
  ## Navigation Bar ############################################################
  navbarPage(id="navmain",
    position = "fixed-top",
    #bhf_navbar_line,
    #BHF HDS Logo
    
    
    
    title = tags$a(img(src = "bhf_dsc_logo.png",
                    style = "margin-top:2% !important;
                        justify-content: center !important;
                        align-items: center !important;",
                    height = 70),
                   target = "_blank", #open in new tab
                   href="https://www.hdruk.ac.uk/helping-with-health-data/bhf-data-science-centre/"),
    
    
    ### About Tab ===========================================================
    tabPanel("About",aboutUI(id = "about_module")),

    ### Summary Tab ============================================================
  
    tabPanel(HTML('<span style=""><center>Dataset Summary</center></span>'), value = "summary", summaryUI(id = "summary_module")),
    
    ### Compare Tab ============================================================
    tabPanel(HTML('<span style=""><center>Dataset Comparison</center></span>'),
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
    

    )
  ),
    
    ## Footer ==================================================================

    #hr(),
    tags$footer(div(
      class = "footer",
      #includeHTML('footer.html') #now archived
      HTML(footer_template(export_date = paste(export_date_england,export_date_scotland,export_date_wales),
                           email_link = "mailto:bhfdsc@hdruk.ac.uk",
                           twitter_link = "https://twitter.com/BHFDataScience?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor",
                           youtube_link = "https://www.youtube.com/playlist?list=PLBI5k9SgYrItGXrJo3wO2LtsxwfyvimZ5"
                           ))
))
  


)

# Server -----------------------------------------------------------------------

server = function(input, output, session) {

  # observeEvent(input$navmain, {
  #   if(input$navmain == "About"){
  #     addCssClass(class = "abouttab", selector = ".navbar")
  #     removeCssClass(class = "normaltab", selector = ".navbar")
  #     #addCssClass(class = "abouttab", selector = ".container-fluid")
  #    # removeCssClass(class = "normaltab", selector = ".container-fluid")
  #   } else {
  #     addCssClass(class = "normaltab", selector = ".navbar")
  #     removeCssClass(class = "abouttab", selector = ".navbar")
  #     #addCssClass(class = "normaltab", selector = ".container-fluid")
  #     #removeCssClass(class = "abouttab", selector = ".container-fluid")
  #   }
  # })
  
  observe({
    if(input$navmain == "About"){
      addCssClass(class = "abouttab", selector = ".navbar")
      removeCssClass(class = "normaltab", selector = ".navbar")
      #addCssClass(class = "abouttab", selector = ".container-fluid")
      # removeCssClass(class = "normaltab", selector = ".container-fluid")
    } else {
      addCssClass(class = "normaltab", selector = ".navbar")
      removeCssClass(class = "abouttab", selector = ".navbar")
      #addCssClass(class = "normaltab", selector = ".container-fluid")
      #removeCssClass(class = "abouttab", selector = ".container-fluid")
    }
  })
  
  
  # observeEvent(input$testid,{
  #   hide("loading_page", anim = TRUE, animType = "fade", time = 0.4)
  #   delay(ms = 600, show("main_content", anim = TRUE, animType = "fade", time = 3))
  # })
  
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


  aboutServer(id = "about_module")
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

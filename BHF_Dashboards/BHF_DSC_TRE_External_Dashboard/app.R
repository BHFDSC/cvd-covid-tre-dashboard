# Setup ########################################################################
Version = "1.1.0"

#Libraries
library(shiny)
library(bslib)
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
devtools::install_github("gadenbuie/shinyThings")

#External Sources
source('bhf_dsc_hds_designkit.R')
source('data.R')
source('inputs.R')
source('common_functions.R')

#Modules
source('module_summary_dataset_coverage.R')
source('module_summary_global.R')

# Global Input Choices #########################################################



# User Interface ---------------------------------------------------------------

ui = fluidPage(

  useShinyjs(),
  #App Theme
  theme = bhf_dsc_hds_bootstrap_theme,
  #CSS Theme Overrides
  tags$head(tags$style(HTML(bhf_dsc_hds_css))),

  
  ## Navigation Bar ############################################################
  navbarPage(
    bhf_navbar_line,
    #BHF HDS Logo
    title = div(img(src = "bhf_dsc_logo.png",
                    style = "margin-top:38px !important;
                        justify-content: center !important;
                        align-items: center !important;
                               padding-right:10px;
                               padding-bottom:0px;",
                    height = 70)),

    
    ## Dataset Summary Tab =====================================================
    tabPanel("Summary",
             
             ### Global Input ==================================================
             fluidRow(module_global_ui("test")),
    
             ### Dataset Overview ==============================================
             titlePanel(h3(id = 'section_heading',"Dataset Overview")),
             
             #### Value Boxes ==================================================
             fluidRow(class = "dashboard_css",
                      valueBoxOutput("registrations", width = 4),
                      valueBoxOutput("batch_summary", width = 4)
                      ),
             
             ### Data Dictionary ===============================================
             hr(),
             titlePanel(h3(id = 'section_heading',"Data Dictionary")),
             
             fluidRow(),
             
             
             ### Data Coverage =================================================            
             hr(),
             titlePanel(h3(id = 'section_heading',"Data Coverage")),
             
             module_ui(id = "data_coverage_module"),
             
             ### Data Completeness =============================================
             hr(),
             titlePanel(h3(id='section_heading',"Data Completeness")),
             
             fluidRow(),
             
             ### Data Validity =================================================
             hr(),
             titlePanel(h3(id='section_heading',"Data Validity")),
             
             fluidRow(),
             
             
             ),
    
  
    
    ## Compare Tab =======================================================================================
    tabPanel("Compare"),
    
    ## Insight Tab =======================================================================================
    tabPanel("Insight"),
    
    ## Appendix Tab =======================================================================================
    tabPanel("Appendix",
             fluidRow(
               #Outputs
               column(12,style=appendix_css,
                      
                      h4("Holding Text"),
                      h5("Sub Title",style="padding-bottom:4px;"),
                      p(span("Some text: ", style = "font-weight: bold;"),
                        "as an example",
                        style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
                      p(span("blah blah", style = "font-weight: bold;"),
                        "and blah",
                        style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
                      
               ),
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
  
  #### Value Boxes =============================================================
  output$registrations = renderValueBox({
    customValueBox(
      title = "Registrations",
      icon = icon("user"),
      subtitle = "",
      value = HTML(paste(paste0(names(count_options),":"),collapse = '<br/>')),
      color = colour_bhf_darkred,
      background = customValueBox_global_colour,
      border = customValueBox_border_colour,
      href = NULL
    )
  })
  
  output$batch_summary = renderValueBox({
    customValueBox(
      title = "Batch Summary",
      icon = icon("file"),
      subtitle = "",
      value = HTML(paste("Batch ID:", "Production Date:", "&nbsp", sep="<br/>")),
      color = colour_bhf_darkred,
      background = customValueBox_global_colour,
      border = customValueBox_border_colour,
      href = NULL
    )
  })
  
  
  ### Dataset Coverage =========================================================
  module_server(id = "data_coverage_module") 
  
  
}



# Run the application ----------------------------------------------------------------------------------------
shinyApp(ui = ui, server = server)
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))

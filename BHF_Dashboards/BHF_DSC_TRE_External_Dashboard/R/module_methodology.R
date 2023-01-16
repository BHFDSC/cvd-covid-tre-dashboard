#Outputs
methodologyOutput <- function(id){
  ns <- NS(id)
  
  tagList(
    
      # fluidRow(
      # column(12,style=appendix_css,
      #  
      #  h4("Holding Text"),
      #  h5("Sub Title",style="padding-bottom:4px;"),
      #  p(span("Some text: ", style = "font-weight: bold;"),
      #    "as an example",
      #    style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
      #  p(span("blah blah", style = "font-weight: bold;"),
      #    "and blah",
      #    style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
      # ),
      # )
    
    
    tabsetPanel(
      tabPanel(
        title = "Data Dictionary",
        value = "dd_meth",
        id = "dd_css",
        wellPanel(style = bhf_tab_panel_style,
        tags$h4("Header 1", style="margin-top:-0.1%;"),
        tags$p(
          htmlOutput("text2")
        ),
        tags$h4("Header 2"),
        tags$p(
          "Some more information.",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        ),
      )),
      tabPanel(
        title = "Data Coverage",
        value = "dcov_meth",
        wellPanel(style = bhf_tab_panel_style,
        tags$h4("Header 1", style="margin-top:-0.1%;"),
        tags$p(
          "Some holding text about the data coverage."
        ),
        tags$h4("Start Dates"),
        tags$p(
          "Some more information about start dates.",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        ),
        tags$h4("De-ID"),
        tags$p(
          "‘De-identification’ protects people’s data and enables safe linkage across data sources. This enriches analysis by providing a more complete picture of health and care data.",
          "For more information please visit",
        tags$a(
          "NHS Digital",
          target = "_blank",
          href = "https://digital.nhs.uk/services/de-id"
        ),
        "."
        ),
        tags$h4("Suppression"),
        tags$p(
          "Some more information."
        ),
      )),
      tabPanel(
        title = "Data Completeness",
        value = "dcom_meth",
        wellPanel(style = bhf_tab_panel_style,
        tags$h4("Header 1", style="margin-top:-0.1%;"),
        tags$p(
        "Some holding text about the data completeness."
        ),
        tags$h4("Non-null"),
        tags$p(
        "Some holding text.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        )
        )),
    )
      
      
  )
}


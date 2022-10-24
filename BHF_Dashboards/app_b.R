# Setup ########################################################################
Version = "1.1.0"

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

source('bhf_dsc_hds_designkit.R')
source('data.R')
source('inputs.R')
source('common_functions.R')


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
             fluidRow(
               
               column(3,style = bhf_global_options_column_style_left,
                      div(id = "nation_css",
                          class = "nation_css",
                          selectInput(inputId = "nation_summary",
                                      label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                                      choices = nations_options))
               ),                            
               
               column(6,style = bhf_global_options_column_style_middle,
                      div(id = "dataset_css",
                          class = "dataset_css",
                          selectInput(inputId = "dataset_summary",
                                      label = shiny::HTML("<p></p><span style='color: white'>Dataset:</span>"),
                                      width = '100%',
                                      choices = NULL))
               ),
               
               
               column(3,style = bhf_global_options_column_style_right
               )
               
             ),
             
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
             
             fluidRow(
               #Inputs
               column(3,
                      
                      selectInput(inputId = "frequency_coverage",
                                  label = "Frequency:",
                                  choices = frequency_options
                      ),
                      
                      tags$style(type = "text/css", 
                                 ".irs-grid-pol.small {height: 0px;}.js-irs-0 
                         .irs-single, 
                         .js-irs-0 
                         .irs-bar-edge, 
                         .js-irs-0 .irs-bar {background: #FF001F;
                                             border-top: 1px solid #FF001F ;
                                             border-bottom: 1px solid #FF001F;}
                           .irs-from, .irs-to, .irs-single { background: #8C0032 !important }"),
                      
                      sliderInput(inputId = "date_range_coverage",
                                  label = "Date Range:",
                                  min = 2018, max = 2022, 
                                  value = c(2018,2022), 
                                  step=1, sep = ""
                      ),
                      
                      checkboxGroupInput(inputId = "count_coverage",
                                         label = "Count:",
                                         choices = count_options,
                                         selected = count_options_selected
                      ),
                      
                      conditionalPanel(condition = "input.tab_selected_summary_coverage == 'summary_coverage_plot'",
                                       downloadButton(outputId = "download_summary_coverage_plot", 
                                                      label = "Download PNG",
                                                      icon = icon("file-image"))
                      )
               ),
               
               #Outputs
               column(9,style=(style='padding-right:80px;padding-left:80px;padding-top:20px;
                                     margin-top:-4.0%;'),
                      tabsetPanel(
                        id = "tab_selected_summary_coverage",
                        tabPanel(title = "Plot", 
                                 value = "summary_coverage_plot",
                                 class = "one",
                                 tags$div(girafeOutput("summary_coverage_plot_girafe",
                                                       width = '100%', height = '85%')),
                        ),
                        tabPanel(title = "Summary", 
                                 value = "coverage_summary", 
                                 class = "one")
                      )),
             ),
             
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
  test_dataset = reactive({test_dataset_static %>%
      filter(table_name==input$dataset_summary) %>%
      filter(date_y==2021) %>%
      filter(freq==input$frequency_coverage) %>%
      filter(Type %in% input$count_coverage)
  })
  
  summary_coverage_plot = reactive({
    ggplot(
      data = test_dataset(), 
      aes(x = .data$date,
          y = .data$N,
          color = .data$Type,
          #data_id = .data$DateType,
          group = .data$Type
      )
    ) +
      geom_line_interactive(size = 3,
                            alpha = 0.4) +
      geom_point_interactive(
        aes(tooltip = .data$N),
        fill = "white",
        size = 3,
        stroke = 1.5,
        shape = 20) +
      # geom_text_interactive(
      #   data = (
      #     portal_timeseries_data()%>%filter(DateType %in% input$volunteer_portal_type) %>%
      #       filter(.data$Date_iso == max(.data$Date_iso))
      #   ),
      #   aes(x = .data$Date_iso + 4,
      #       y = (.data$trend_selected +
      #              #nudge text up prop to max y axis
      #              (portal_timeseries_data()%>%filter(DateType %in% input$volunteer_portal_type) %>%
      #                 #filter excld NA for rolling av
      #                 filter(.data$trend_selected==max(.data$trend_selected,na.rm=TRUE)) %>%
    #                 distinct(.data$trend_selected) %>%
    #                 pull(.data$trend_selected)
    #              ) * 0.033
    #       ),
    #       color = .data$Type,
    #       label = .data$Type
    #   ),
    #   size=6,
    #   check_overlap = T) +
    labs(x = NULL, y = NULL) +
      theme_minimal() +
      theme(
        panel.grid = element_blank(),
        plot.margin = margin(0,50,0,0),
        plot.background = element_rect(color=NA),
        panel.background = element_rect(color = NA),
        axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size = 14, face = "bold"),
        legend.position = "none"
      ) + 
      coord_cartesian(clip = "off") + 
      # scale_x_date(date_breaks = "1 month", 
      #              date_labels = "%B",
      #              #expand on rhs to fit in text
      #              expand = expansion(mult = c(0, 0.1))) +
      scale_colour_manual(values = c(
        "N_row"="#F8AEB3",
        "N_valid_id"="#F88350",
        "N_distinct_id"="#b388eb"))
  })
  
  output$summary_coverage_plot_girafe = renderGirafe({
    girafe(ggobj = summary_coverage_plot(), 
           width_svg = 16, 
           height_svg = 9,
           options = list(
             opts_tooltip(
               opacity = 0.95, #opacity of the background box 
               css = "background-color:#EC2154;
            color:white;font-size:10pt;font-style:italic;
            padding:5px;border-radius:10px 10px 10px 10px;"
             ),
            #to work - need data_id on
            opts_hover_inv(
              css = "stroke-width:3; opacity:0.6;"
            ),
            opts_hover(
              css = "stroke-width: 4; opacity: 1;"
            ),
            #turn off save as png as will put this as a shiny command to match excel download
            opts_toolbar(saveaspng = FALSE)
           )
    )
  })
  
  
  output$download_summary_coverage_plot = downloadHandler(
    filename = function() {paste(Sys.Date(), "coverage.png")},
    content = function(file) {ggsave(file, plot = (summary_coverage_plot()) + theme(plot.margin = margin(20,50,20,50)),
                                     #ensure width and height are same as ggiraph
                                     #width_svg and height_svg to ensure png not cut off
                                     width = 16, height = 9, units = "in",
                                     bg = "transparent",
                                     dpi = 300, device = "png")}
  )  
  
  
}



# Run the application ----------------------------------------------------------------------------------------
shinyApp(ui = ui, server = server)
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))
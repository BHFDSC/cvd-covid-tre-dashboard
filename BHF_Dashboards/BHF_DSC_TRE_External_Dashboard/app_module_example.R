#Example: Data Coverage app that is then turned into the module
#module_summary_dataset_coverage


#Note that in the module you would not need to source the following scripts &
#libraries - they need only be sourced in the main app.
current_dir_example = dirname(rstudioapi::getSourceEditorContext()$path)

source(paste0((current_dir_example),'/data.R'))
source(paste0((current_dir_example),'/inputs.R'))
source(paste0((current_dir_example),'/common_functions.R'))

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



ui = fluidPage(
    fluidRow(
      
      # Inputs
      column(3,
             
             selectInput(inputId = "frequency_coverage",
                         label = "Frequency:",
                         choices = frequency_options
             ),
             
             tags$style(type = ""),
             
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
      
      # Outputs
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
    )
  )




server = 
    function(input, output, session) {
      
      test_dataset = reactive({test_dataset_static %>%
          #filter(table_name==input$dataset_summary) %>% #this is s global var
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
          # geom_text_interactive() +
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



shinyApp(ui = ui, server = server)


# Module UI
datasetCoverageUI <- function(id){
  ns <- NS(id)
  tagList(

    fluidRow(
      
      #Inputs
      column(3,

             selectInput(inputId = ns("frequency_coverage"),
                         label = "Frequency:",
                         choices = frequency_options
             ),
            
             
             sliderInput(inputId = ns("date_range_coverage"),
                         label = "Date Range:",
                         #initialise values
                         min = 2020, max = 2021, 
                         value = c(2020,2021), 
                         step=1, sep = ""
             ),
             
             checkboxGroupInput(inputId = ns("count_coverage"),
                                label = "Count:",
                                choices = count_options,
                                selected = count_options_selected
             ),
             
             conditionalPanel(condition = "input.tab_selected_summary_coverage == 'summary_coverage_plot'",
                              downloadButton(outputId = ns("download_summary_coverage_plot"), 
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
                        tags$div(girafeOutput(ns("summary_coverage_plot_girafe"),
                                              width = '100%', height = '85%')),
               ),
               tabPanel(title = "Summary", 
                        value = "coverage_summary", 
                        class = "one")
             )),
    )
  )
}


# Module Server    
datasetCoverageServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {
      
      test_dataset_old = reactive({test_dataset_static %>%
          filter(table_name==dataset_summary()) %>%
          filter(freq==input$frequency_coverage) %>%
          mutate(N_tooltip = format(.data$N, nsmall=1, big.mark=",")) %>%
          mutate(N_tooltip_date = paste0(date_name,N_tooltip))
                 
      })
      
      #observe min and max years available for slider input
      date_range_coverage_extremum = reactive({
        test_dataset_old() %>%
        summarise(min = min(.data$date_y),
                  max = max(.data$date_y)) %>%
          pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
      })
      
      date_range_coverage_min = reactive({date_range_coverage_extremum() %>% filter(.data$extremum=="min") %>% pull(year)})
      date_range_coverage_max = reactive({date_range_coverage_extremum() %>% filter(.data$extremum=="max") %>% pull(year)})
      
      observe({
        updateSliderInput(session, "date_range_coverage",
                          min = date_range_coverage_min(),
                          max = date_range_coverage_max(),
                          value = c(
                            date_range_coverage_min(),
                            date_range_coverage_max()
                          ),
                          step=1
                          )
        })

      
      test_dataset = reactive({
        test_dataset_old() %>%
          filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
          filter(Type %in% input$count_coverage)
      })

    
      summary_coverage_plot = reactive({
        ggplot(
          data = test_dataset(), 
          aes(x = .data$date_format + 10,
              y = .data$N,
              color = .data$Type,
              #data_id = .data$DateType,
              group = .data$Type
          )
        ) +
          geom_line_interactive(size = 3,
                                alpha = 0.4) +
          geom_point_interactive(
            aes(tooltip = .data$N_tooltip_date),
            fill = "white",
            size = 3,
            stroke = 1.5,
            shape = 20) +
          geom_text_interactive(
            data = (
              test_dataset() %>% filter(date_format == max(date_format)) %>%
                left_join(as.data.frame(count_options) %>% rename(Type=count_options) %>% rownames_to_column("count_options"),
                          by="Type")
            ),
            aes(x = .data$date_format,
                y = .data$N + (
                  #nudge up a 30th of difference between max and min
                  (((test_dataset() %>% filter(N == max(N)) %>% pull(N)) - (test_dataset() %>% filter(N == min(N)) %>% pull(N))) /30) 
                  ),
                color = .data$Type,
                label = .data$count_options
            ),
            size=6,
            check_overlap = T) +
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
  )
}
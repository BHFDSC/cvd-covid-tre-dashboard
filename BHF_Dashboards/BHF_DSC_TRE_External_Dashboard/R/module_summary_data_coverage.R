dataCoverageUI <- function(id){
  ns <- NS(id)
  tagList(

    fluidRow(
      
      # Inputs -----------------------------------------------------------------
      column(3,

             sliderInput(inputId = ns("date_range_coverage"),
                         label = "Date Range:",
                         #initialise values
                         min = 2020, max = 2021, 
                         value = c(2020,2021), 
                         step=1, sep = ""
             ),

             prettySwitch(inputId = ns("all_records"), label = "Show extreme dates", fill = TRUE)  %>% 
               add_prompt(
                 message = "Select records recorded outwith data collection start date and current date",
                 position = "right", type = "error", 
                 size = "small", rounded = TRUE
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
      
      # Outputs ----------------------------------------------------------------
      
      column(9,style=(style='padding-right:80px;padding-left:80px;padding-top:20px;
                                     margin-top:-4.0%;'),
             tabsetPanel(
               id = "tab_selected_summary_coverage",
               tabPanel(title = "Trend", 
                        value = "summary_coverage_plot",
                        class = "one",
                        tags$div(girafeOutput(ns("summary_coverage_plot_girafe"),
                                              width = '100%', height = '85%')),
               ),
               tabPanel(title = "Seasonality", 
                        value = "compare_plot", 
                        class = "one")
             )),
      
    )
  )
}


dataCoverageServer <- function(id, dataset_summary, nation_summary, coverage_data) {
  moduleServer(
    id,
    function(input, output, session) {
      
      coverage_data_all_records =  reactive({
        t.data_coverage %>%
          left_join(datasets_available,by = c("dataset"="Dataset")) %>%
          filter(.data$dataset==dataset_summary()) %>%
          #tooltips for plot
          mutate(N_tooltip = format(.data$N, nsmall=0, big.mark=",", trim=TRUE)) %>%
          mutate(N_tooltip_date = paste0(date_name,N_tooltip))
        
      })

        coverage_data_start_date =
            reactive({
              coverage_data_all_records() %>%
                #filter date range
                mutate(start_date = as.Date(paste(start_date, 1, sep="-"), "%Y-%m-%d")) %>%
                filter(!start_date >= date_format) %>%
                #using current month but this should be updated to use production ym in future
                mutate(current_date = as.Date(paste(format(Sys.Date(), "%Y-%m"), 1, sep="-"), "%Y-%m-%d")) %>%
                filter(date_format <= current_date)
              })

      coverage_data = reactive({
        if(input$all_records) {
          (coverage_data_all_records())
        } else {
          (coverage_data_start_date())
        }
      })

      #observe min and max years available for slider input
      date_range_coverage_extremum = reactive({
        coverage_data() %>%
        summarise(min = min(.data$date_y),
                  max = max(.data$date_y)) %>%
          pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
      })

      date_range_coverage_min = reactive({date_range_coverage_extremum() %>% filter(.data$extremum=="min") %>% pull(year)})
      date_range_coverage_max = reactive({date_range_coverage_extremum() %>% filter(.data$extremum=="max") %>% pull(year)})
      
      date_range_coverage_extremum_start_date = reactive({
        coverage_data_start_date() %>%
          summarise(min = min(.data$date_y),
                    max = max(.data$date_y)) %>%
          pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
      })
      
      date_range_coverage_min_start_date = reactive({date_range_coverage_extremum_start_date() %>% filter(.data$extremum=="min") %>% pull(year)})
      date_range_coverage_max_start_date = reactive({date_range_coverage_extremum_start_date() %>% filter(.data$extremum=="max") %>% pull(year)})

      observe({
        updateSliderInput(session, "date_range_coverage",
                          min = date_range_coverage_min(),
                          max = date_range_coverage_max(),
                          value = c(
                            date_range_coverage_min_start_date(),
                            date_range_coverage_max_start_date()
                          ),
                          step=1
                          )
        })


      coverage_data_filtered = reactive({
        coverage_data() %>%
          filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
          filter(Type %in% input$count_coverage)
      })


      summary_coverage_plot = reactive({
        ggplot(
          data = coverage_data_filtered(),
          aes(x = .data$date_format,
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
          geom_text_repel_interactive(
            
            data = (
              coverage_data_filtered() %>% filter(date_format == max(date_format)) %>%
                left_join(as.data.frame(count_options) %>% rename(Type=count_options) %>% rownames_to_column("count_options"),
                          by="Type")
            ),
            
            aes(
              x = .data$date_format + (
              as.numeric(
              (coverage_data_filtered() %>% filter(date_format == max(date_format)) %>% distinct(date_format) %>% pull(date_format)) -
                (coverage_data_filtered() %>% filter(date_format == min(date_format)) %>% distinct(date_format) %>% pull(date_format))
              )/10),
                y = .data$N + (
                  #nudge up a 30th of difference between max and min
                  (
                    (
                      (
                        coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                          coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                      ) /30)
                  ),
                color = .data$Type,
                label = .data$count_options
            ),
            size=6,
            direction = "y",
            family=family_lato,
            segment.color = 'transparent') +
        labs(x = NULL, y = NULL) +
          # scale_x_date(limits=c(
          #   (coverage_data_filtered() %>% filter(.data$date_format == min(date_format)) %>% distinct(date_format) %>% pull(date_format)),
          #   (coverage_data_filtered() %>% filter(.data$date_format == max(date_format)) %>% distinct(date_format) %>% pull(date_format))
          #   )) +
          theme_minimal() +
          theme(
            text=element_text(family=family_lato),
            panel.grid = element_blank(),
            plot.margin = margin(0,50,0,0),
            plot.background = element_rect(color=NA),
            panel.background = element_rect(color = NA),
            axis.ticks = element_blank(),
            axis.text.x = element_text(size = 14, face = "bold"),
            axis.text.y = element_text(size = 14, face = "bold"),
            legend.position = "none"
          ) +
          coord_cartesian(clip = "off") +
          # scale_x_date(date_breaks = "1 month",
          #              date_labels = "%B",
          #              #expand on rhs to fit in text
          #              expand = expansion(mult = c(0, 0.1))) +
          scale_colour_manual(values = c(
            "n"="#F8AEB3",
            "n_id"="#F88350",
            "n_id_distinct"="#b388eb")) + 
          scale_y_continuous(labels = scales::label_number_si())
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
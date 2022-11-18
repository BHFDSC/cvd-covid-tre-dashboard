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
             

             
             

             
             
             conditionalPanel(condition = "input.tab_selected_summary_coverage == 'summary_coverage_plot'",
                              
                              checkboxGroupInput(inputId = ns("count_coverage"),
                                                 label = "Count:",
                                                 choices = count_options,
                                                 selected = count_options_selected
                              ),
                              
                              downloadButton(outputId = ns("download_summary_coverage_plot"), 
                                             label = "Download PNG",
                                             icon = icon("file-image"))
             ),
             
             conditionalPanel(condition = "input.tab_selected_summary_coverage == 'compare_plot'",


                              radioButtons(inputId = ns("count_coverage_season"),
                                           label = "Count:",
                                           choices = count_options,
                                           selected = count_options_selected
                              ),
                              
                              downloadButton(outputId = ns("download_summary_coverage_season_plot"), 
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
                        class = "one",
                        tags$div(girafeOutput(ns("summary_coverage_season_plot_girafe"),
                                              width = '100%', height = '85%')))
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
          mutate(N_tooltip_date = paste0(date_name,N_tooltip)) %>%
          mutate(N_tooltip_date_season = paste0(date_name_season,N_tooltip))
        
      })
      
      season_colour_palette = reactive({setNames(
        rep(rev(colour_stepped_palette), length.out=nrow(distinct(coverage_data_all_records(),date_y))),
        rev(pull(distinct(coverage_data_all_records(),date_y),date_y))
      )})

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
      
    
      #date filtered dataset
      coverage_data_filtered = reactive({
        coverage_data() %>%
          filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
          filter(Type %in% input$count_coverage)
      })
      
      coverage_data_filtered_season = reactive({
        coverage_data() %>%
          filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
          filter(Type %in% input$count_coverage_season)
      })

      
      ## Trend Plot ============================================================

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
          geom_line(size = 3,
                                alpha = 0.4) +
          geom_point_interactive(
            aes(tooltip = .data$N_tooltip_date),
            fill = "white",
            size = 3,
            stroke = 1.5,
            shape = 20) +

        labs(x = NULL, y = NULL) +
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
          scale_colour_manual(values = c(
            "n"="#F5484A",
            "n_id"="#F88350",
            "n_id_distinct"="#b388eb")) + 
          scale_y_continuous(labels = scales::label_number_si())
      })
      

      output$summary_coverage_plot_girafe = renderGirafe({
        girafe(ggobj = summary_coverage_plot() +
                 
                 (geom_text_repel_interactive(
                   size = 6,
                   data = (
                     coverage_data_filtered() %>% 
                       filter(date_format == max(date_format)) %>%
                       left_join(as.data.frame(count_options) %>% 
                                   rename(Type=count_options) %>% 
                                   rownames_to_column("count_options"),by="Type")
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

                   direction = "y",
                   family=family_lato,
                   segment.color = 'transparent'))
               
               ,
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
        filename = function() {paste(Sys.Date(), "coverage_trend.png")},
        content = function(file) {ggsave(file, plot = (summary_coverage_plot()) +
                                           (geom_text_repel_interactive(
                                             size = 12,
                                             data = (
                                               coverage_data_filtered() %>% 
                                                 filter(date_format == max(date_format)) %>%
                                                 left_join(as.data.frame(count_options) %>% 
                                                             rename(Type=count_options) %>% 
                                                             rownames_to_column("count_options"),by="Type")
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
                                             
                                             direction = "y",
                                             family=family_lato,
                                             segment.color = 'transparent')) +
                                           #new theme for download
                                           theme(plot.margin = margin(20,50,20,50),
                                                 axis.text.x = element_text(size = 34, face = "bold"),
                                                 axis.text.y = element_text(size = 34, face = "bold")),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "png")}
      )
      
      
      
      ## Season Plot ===========================================================
      
      summary_coverage_season_plot = reactive({
        ggplot(
          data = coverage_data_filtered_season() %>% mutate(date_y=as.character(date_y)),
          aes(x = .data$date_m,
              y = .data$N,
              color = .data$date_y,
              #data_id = .data$date_m,
              group = .data$date_y
          )
        ) +
          geom_line(size = 3,
                                alpha = 0.4) +
          geom_point_interactive(
            aes(tooltip = .data$N_tooltip_date_season),
            fill = "white",
            size = 3,
            stroke = 1.5,
            shape = 20) +
          
          labs(x = NULL, y = NULL) +

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

          
          scale_colour_manual(values = c(

          season_colour_palette()
            
            )) +
          
          scale_y_continuous(labels = scales::label_number_si()) +
          scale_x_continuous(breaks = c(1, 4, 7, 10),label = c("Jan", "Apr", "Jul", "Oct"))
      })
      
      # test = reactive({(
      #   functional::Curry(
      #   geom_text_repel_interactive,
      #   
      #   data = (coverage_data_filtered() %>% 
      #             group_by(date_y) %>% 
      #             filter(date_m == max(date_m))),
      #   
      #   aes(x = .data$date_m,
      #       y = .data$N,
      #       color = as.factor(.data$date_y),
      #       label = as.factor(.data$date_y)),
      #   
      #   direction = "y",
      #   family=family_lato,
      #   segment.color = 'transparent')
      #   )})
      
      output$summary_coverage_season_plot_girafe = renderGirafe({
        girafe(ggobj = summary_coverage_season_plot() +
                 #add geom text layer separate for girafe object and download as different sizes needed
                 geom_text_repel_interactive(
                 size = 6,

                 data = (coverage_data_filtered_season() %>%
                           group_by(date_y) %>%
                           filter(date_m == max(date_m))),

                 aes(x = .data$date_m,
                     y = .data$N,
                     color = as.factor(.data$date_y),
                     label = as.factor(.data$date_y)),

                 direction = "y",
                 family=family_lato,
                 segment.color = 'transparent'),
               
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
      
      
      output$download_summary_coverage_season_plot = downloadHandler(
        filename = function() {paste(Sys.Date(), "coverage_season.png")},
        content = function(file) {ggsave(file, plot = (summary_coverage_season_plot()) +
                                           #add geom text layer separate for girafe object and download as different sizes needed
                                           geom_text_repel_interactive(
                                             size = 12,
                                             
                                             data = (coverage_data_filtered_season() %>%
                                                       group_by(date_y) %>%
                                                       filter(date_m == max(date_m))),
                                             
                                             aes(x = .data$date_m,
                                                 y = .data$N,
                                                 color = as.factor(.data$date_y),
                                                 label = as.factor(.data$date_y)),
                                             
                                             direction = "y",
                                             family=family_lato,
                                             segment.color = 'transparent') +
                                           #custom theme for download
                                           theme(plot.margin = margin(20,50,20,50),
                                                 axis.text.x = element_text(size = 34, face = "bold"),
                                                 axis.text.y = element_text(size = 34, face = "bold")
                                                 ),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "png")}
      )
      

    }
  )
}
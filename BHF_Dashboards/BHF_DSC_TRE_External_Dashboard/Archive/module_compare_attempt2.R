compareUI <- function(id){
ns <- NS(id)

tagList(


column(3,

#tabset panel styling
tags$head(
tags$style('

ul.nav-pills{
 background-color: transparent !important;
}
.nav-pills .nav-link.active {
color: #FF001F !important;
background-color:#F3F2F4 !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link.active:hover {
color: #FF001F !important;
background-color:#F3F2F4 !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link {
color: #FF001F;
background-color:white;
border: 1px solid white!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link:hover {
color: #A0003C !important;
background-color:white !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}'
))
),


## Data Coverage ===========================================================
fluidRow(titlePanel(h3(id = 'section_heading',"Data Coverage")),

         #UI INPUT
         column(3,

                tabsetPanel(id = "tab_selected_data_input", type="pills",

                            #DATA INPUT
                            tabPanel(title = "Data",
                                     value = "data_input",
                                     wellPanel(style = bhf_tab_panel_style,

                                               # prettySwitch(inputId = ns("multi_nation"),
                                               # label = "Multi nation comparison",
                                               # fill=TRUE),

                                               #conditionalPanel(condition = "input.multi_nation",

                                               #NATION 1
                                               selectizeInput(ns("nation_compare_initial"), paste("Nation 1:"),
                                                              choices = c("Choose" = "",nations_options)),

                                               #DATAWSET 1
                                               selectInput(ns("dataset_compare_initial"),
                                                           label = paste0("Dataset 1:"),
                                                           width = '100%',
                                                           choices = NULL),

                                               #NATION 2
                                               selectizeInput(ns("nation_compare_initial2"), paste("Nation 2:"),
                                                              choices = c("Choose" = "",nations_options)),

                                               #DATASET 2
                                               selectInput(ns("dataset_compare_initial2"),
                                                           label = paste0("Dataset 2:"),
                                                           width = '100%',
                                                           choices = NULL),

                                               #ADD/REMOVE ADDITIONAL INPUT
                                               actionButton(inputId = ns("remove"), label = "-"),
                                               actionButton(inputId = ns("add"), label = "+")

                                               )
                                     ),

                            #PLOT INPUT
                            tabPanel(title = "Plot",
                                     value = "plot_input",
                                     wellPanel(style = bhf_tab_panel_style,

                                               #DATE RANGE SLIDER
                                               sliderInput(inputId = ns("date_range_coverage2"),
                                                 label = "Date Range:",
                                                 #initialise values
                                                 min = 2018, max = 2021,
                                                 value = c(2018,2021),
                                                 step=1, sep = ""),

                                               #EXTREME VALUES
                                               prettySwitch(inputId = ns("all_records"),
                                                            label = "Show extreme dates", fill = TRUE),

                                               #TYPE INPUT
                                               radioButtons(
                                                 inputId = ns("type_compare"),
                                                 label = "Order:",
                                                 selected = count_options_selected,
                                                 choices = count_options)

                                               )
                                     )
                            )
                ),

         #UI OUTPUT
         column(9,

                tags$div(girafeOutput(ns("compare_coverage_plot_girafe"),
                                      width = '100%', height = '85%'))

                ),

         ))
}


compareServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      #Dynamic Dataset options depending on Nation selected

      #DATASET 1
      datasets_available_list_initial = reactive({
        req(input$nation_compare_initial)
        dataset_dashboard_list(nation=input$nation_compare_initial)
      })

      observeEvent(datasets_available_list_initial(), {
        updateSelectInput(
          inputId = "dataset_compare_initial",
          choices = c("Choose" = "",datasets_available_list_initial()))
      })

      #DATASET 2
      datasets_available_list_initial2 = reactive({
        req(input$nation_compare_initial2)
        dataset_dashboard_list(nation=input$nation_compare_initial2)
      })

      observeEvent(datasets_available_list_initial2(), {
        updateSelectInput(
          inputId = "dataset_compare_initial2",
          choices = c("Choose" = "",datasets_available_list_initial2()))
      })

      #INPUT COUNTER
      input_counter <- reactiveVal(1) #start counter at 1 instead of 0 as want 2 initial datasets


      # INSERT UI ADD ==========================================================
      observeEvent(input$add,

      {

        input_counter(input_counter() + 1)

        insertUI(
          selector = paste0("#", ns("remove")),
          where = "beforeBegin",
          ui =

            div(id = "selectize_div_all", #adding an extra top level div to control style of all that are added

               div(id = paste0("selectize_div",input_counter()),

                   #INSERT NATION
                   selectizeInput(ns(paste0("nation_compare",input_counter())),
                                  label = paste("Nation",input_counter()+1,":"),
                                  choices = c("Choose" = "",nations_options)),

                   #INSERT DATASET
                   selectInput(ns(paste0("dataset_compare",input_counter())),
                               label = paste("Dataset",input_counter()+1,":"),
                               width = '100%',
                               choices = NULL)
                   ),
               )
          )

        #UPDATE DATASETS AVAILABLE FOR INPUT ADDED
        datasets_available_list = reactive({
          req(input[[paste0("nation_compare",input_counter())]])
          dataset_dashboard_list(nation=input[[paste0("nation_compare",input_counter())]])
        })

        observeEvent(datasets_available_list(), {
          updateSelectInput(
            inputId = paste0("dataset_compare",
                             input_counter()),
            choices = c("Choose" = "",datasets_available_list()))
        })






      })


      # REMOVE UI ==============================================================
      observeEvent(input$remove,
      {removeUI(
          selector = paste0("#selectize_div", input_counter())
        )
        input_counter(input_counter() - 1)
      })

      # REMAINING OUTPUT =======================================================

      #listen for any inputs changing - update slider
      toListen <- reactive({
        list(reactiveValuesToList(input))
      })

      # toListen <- reactive({
      #   list(input$add,input$remove)
      # })

      observeEvent(toListen(), {



      compare_coverage_data_all_records =  reactive({
        t.data_coverage %>%
          left_join(datasets_available,by = c("dataset"="Dataset")) %>%

          #filter(.data$dataset %in% reactiveValuesToList(input)) %>%

          filter(.data$dataset %in% c(input$dataset_compare_initial,input$dataset_compare_initial2,
                                      input$dataset_compare2,input$dataset_compare3,
                                      input$dataset_compare4,input$dataset_compare5)) %>%

          #tooltips for plot
          mutate(N_tooltip = format(.data$N, nsmall=0, big.mark=",", trim=TRUE)) %>%
          mutate(N_tooltip_date = paste0(date_name,N_tooltip)) %>%
          mutate(N_tooltip_date_season = paste0(date_name_season,N_tooltip)) %>%
          filter(Type == input$type_compare) %>%
          ungroup()

      })

      compare_coverage_data_start_date =
        reactive({
          compare_coverage_data_all_records() %>%
            #filter date range
            mutate(start_date = as.Date(paste(start_date, 1, sep="-"), "%Y-%m-%d")) %>%
            filter(!start_date >= date_format) %>%
            #using current month but this should be updated to use production ym in future
            mutate(current_date = as.Date(paste(format(Sys.Date(), "%Y-%m"), 1, sep="-"), "%Y-%m-%d")) %>%
            filter(date_format <= current_date) %>%
            ungroup()
        })

      compare_coverage_data = reactive({
        if(input$all_records) {
          (compare_coverage_data_all_records())
        } else {
          (compare_coverage_data_start_date())
        }
      })

      #observe min and max years available for slider input
      compare_date_range_coverage_extremum2 = reactive({
        compare_coverage_data() %>%
          summarise(min = min(.data$date_y),
                    max = max(.data$date_y)) %>%
          pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
      })

      compare_date_range_coverage_min2 = reactive({compare_date_range_coverage_extremum2() %>% filter(.data$extremum=="min") %>% pull(year)})
      compare_date_range_coverage_max2 = reactive({compare_date_range_coverage_extremum2() %>% filter(.data$extremum=="max") %>% pull(year)})

      compare_date_range_coverage_extremum_start_date2 = reactive({
        compare_coverage_data_start_date() %>%
          summarise(min = min(.data$date_y),
                    max = max(.data$date_y)) %>%
          pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
      })

      compare_date_range_coverage_min_start_date2 = reactive({compare_date_range_coverage_extremum_start_date2() %>% filter(.data$extremum=="min") %>% pull(year)})
      compare_date_range_coverage_max_start_date2 = reactive({compare_date_range_coverage_extremum_start_date2() %>% filter(.data$extremum=="max") %>% pull(year)})




      observeEvent(
        toListen(),
        observe(
          {
        updateSliderInput(session, "date_range_coverage2",
                          min = compare_date_range_coverage_min2(),
                          max = compare_date_range_coverage_max2(),
                          value = c(
                            compare_date_range_coverage_min2(),
                            compare_date_range_coverage_max2()
                          ),
                          step=1
        )}))



      #date filtered dataset
      compare_coverage_data_filtered = reactive({
        compare_coverage_data() %>%
          filter(.data$date_y>=input$date_range_coverage2[1] & .data$date_y<=input$date_range_coverage2[2])
      })


      ## Trend Plot ============================================================

      compare_coverage_plot = reactive({
        ggplot(
          data = compare_coverage_data_filtered(),
          aes(x = .data$date_format,
              y = log(.data$N),
              color = .data$dataset,
              #data_id = .data$DateType,
              group = .data$dataset
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
          scale_colour_manual(values=compare_palette) +
          coord_cartesian(clip = "off") +
          # scale_colour_manual(values = c(
          #   "n"="#F8AEB3",
          #   "n_id"="#F88350",
          #   "n_id_distinct"="#b388eb")) +
          scale_y_continuous(labels = scales::label_number_si())
      })



      output$compare_coverage_plot_girafe = renderGirafe({
        girafe(ggobj = compare_coverage_plot()
            # (geom_text_repel_interactive()

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
      })


      # output$download_compare_coverage_plot = downloadHandler()


      # observe({

      #   print(names(input))
      #
      #   print(input$"nation_compare_initial") #1
      #   print(input$"dataset_compare_initial")
      #   print(input$"nation_compare_initial2") #2
      #   print(input$"dataset_compare_initial2")
      #
      #   print(input$"nation_compare2") #3
      #   print(input$"dataset_compare2")
      #   print(input$"nation_compare3") #4
      #   print(input$"dataset_compare3")
      #   print(input$"nation_compare4") #5
      #   print(input$"dataset_compare4")
      # })

    }
  )
}
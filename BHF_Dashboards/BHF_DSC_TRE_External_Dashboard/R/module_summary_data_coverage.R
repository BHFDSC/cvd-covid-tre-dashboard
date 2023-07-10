dataCoverageUI <- function(id){
  ns <- NS(id)
  
  tagList(


    fluidRow(
      
      # Inputs -----------------------------------------------------------------
      column(3,

             fluidRow(column(12,
             HTML("<br>"),
             sliderInput(inputId = ns("date_range_coverage"),
                         label = "Date Range:",
                         #initialise values
                         min = 2020, max = 2021, 
                         value = c(2020,2021), 
                         step=1, sep = ""
             ))),
             
             fluidRow(column(12,
                             
             prettySwitchCustom(inputId = ns("all_records"),
                          
               label = "Show extreme dates",
               spaces = 2,
               prompt_size = "medium",
               my_message = extreme_dates_text,
             
             fill = TRUE),

             )),

             
             conditionalPanel(ns = ns,
                              condition = "input.tab_selected_summary_coverage == 'summary_coverage_plot'",
                              
                              div(id = "css_pair_popup",
                                  
                              fluidRow(column(12,
                                tagList(uiOutput(ns("count_coverage_ex"))),
                                
                                
                              # checkboxGroupInput(inputId = ns("count_coverage_asd"),
                              #                    #label = "Count:",
                              # 
                              #                    label = h6(id='count_heading',paste0("Overall Counts:",stringi::stri_dup(intToUtf8(160),2)), tags$span(icon("info-circle"), id = "iconer") %>%
                              # 
                              #                                   add_prompt(
                              #                                     message = type_text,
                              #                                     position = "right", type = "error",
                              #                                     size = "medium", rounded = TRUE,
                              #                                     bounce=FALSE,animate=FALSE
                              #                                   )),
                              # 
                              #                    choices = count_options,
                              #                    selected = count_options_selected
                              # ),
                              
                              
                              ),

                              )),
                            
                            
             ),
             
             conditionalPanel(ns = ns,
                              condition = "input.tab_selected_summary_coverage == 'compare_plot'",


                              fluidRow(column(12,
                                              tagList(uiOutput(ns("count_coverage_season_ex"))),
                              # radioButtons(inputId = ns("count_coverage_season"),
                              #              label = h6(id='count_heading',paste0("Count:",stringi::stri_dup(intToUtf8(160),2)), tags$span(icon("info-circle"), id = "iconer") %>% 
                              #                           
                              #                           add_prompt(
                              #                             message = type_text,
                              #                             position = "right", type = "error",
                              #                             size = "medium", rounded = TRUE,
                              #                             bounce=FALSE,animate=FALSE
                              #                           )),
                              #              choices = count_options,
                              #              selected = count_options_selected_season
                              # ),
                              
                              #LOG SCALE
                              # prettySwitchCustom(inputId = ns("log_scale_summary_season"),
                              #                    label = "Log scale", fill = TRUE, value=FALSE, spaces = 2,info=FALSE),
                              
                              
                              #TREND LINE
                              # prettySwitchCustom(inputId = ns("trend_line_season"),
                              #                    label = "Show trend", fill = TRUE, value=FALSE, spaces = 2,my_message = trend_text,prompt_size="medium"),
                              
                              ),
                              ),

             ),
             
             
             #LOG SCALE
             prettySwitchCustom(inputId = ns("log_scale_summary"),
                                label = "Log scale", fill = TRUE, value=FALSE, spaces = 2,info=FALSE),
             
             #TREND LINE
             prettySwitchCustom(inputId = ns("trend_line"),
                                label = "Show trend", fill = TRUE, value=FALSE, spaces = 2,my_message = trend_text,prompt_size="medium"),


             



conditionalPanel(ns = ns,
                 condition = "input.tab_selected_summary_coverage == 'summary_coverage_plot'",
                 
                 dropdown(
                   id = "coverage_dropdown_image_plot",
                   inputId = "coverage_dropdown_image_plot",
                   
                   fluidRow(align="center", style="margin-top: -11%;
            padding-top: -11%;
            padding-left: -11.3%;
            margin-left: -11.3%;
            padding-right: -10.9%;
            margin-right:-10.9%;
            padding-bottom:3%;",
            h6("Download Plot", 
               style="color:white;background-color:#A0003C;
                     font-size:100%;
                     padding-top: 3%;
                     padding-bottom:3.5%;
                     border-top-left-radius: 10px !important;
                    border-top-right-radius: 10px !important;")),
            
            fluidRow(align="center",h6("Save as:", style="color:#3D3C3C;margin-top:-3%;margin-bottom:4%;")),
            fluidRow(downloadButton(outputId=ns("download_summary_coverage_plot_jpeg"),"JPEG (.jpeg)",icon=NULL)),
            fluidRow(downloadButton(outputId=ns("download_summary_coverage_plot_pdf"),"PDF (.pdf)",icon=NULL)),
            fluidRow(downloadButton(outputId=ns("download_summary_coverage_plot_png"),"PNG (.png)",icon=NULL)),
            
            size = "xs",
            status = "myClass",
            label = "Download Plot",
            icon = icon("file-image"),
            up = TRUE
                 ),        
                 
                 
),

conditionalPanel(ns = ns,
                 condition = "input.tab_selected_summary_coverage == 'compare_plot'",
                 

    
dropdown(
  id = "coverage_dropdown_image_season",
  inputId = "coverage_dropdown_image_season",
  
  fluidRow(align="center", style="margin-top: -11%;
            padding-top: -11%;
            padding-left: -11.3%;
            margin-left: -11.3%;
            padding-right: -10.9%;
            margin-right:-10.9%;
            padding-bottom:3%;",
           h6("Download Plot", 
              style="color:white;background-color:#A0003C;
                     font-size:100%;
                     padding-top: 3%;
                     padding-bottom:3.5%;
                     border-top-left-radius: 10px !important;
                    border-top-right-radius: 10px !important;")),
  
  fluidRow(align="center",h6("Save as:", style="color:#3D3C3C;margin-top:-3%;margin-bottom:4%;")),
  fluidRow(downloadButton(outputId=ns("download_summary_coverage_season_plot_jpeg"),"JPEG (.jpeg)",icon=NULL)),
  fluidRow(downloadButton(outputId=ns("download_summary_coverage_season_plot_pdf"),"PDF (.pdf)",icon=NULL)),
  fluidRow(downloadButton(outputId=ns("download_summary_coverage_season_plot_png"),"PNG (.png)",icon=NULL)),

  size = "xs",
  status = "myClass",
  label = "Download Plot",
  icon = icon("file-image"),
  up = TRUE
),



),



dropdown(
  
  
  id = "download_coverage_data",
  inputId = "download_coverage_data",
  
  
  fluidRow(align="center", style="margin-top: -11%;
           padding-top: -9%;
           padding-left: -5.9%;
           margin-left: -5.9%;
           padding-right: -11.3%;
           margin-right:-11.3%;
           padding-bottom:3%;",
           h6("Download Data", 
              style="color:white;background-color:#A0003C;
                     font-size:100%;
                     padding-top: 3%;
                     padding-bottom:3.5%;
                     border-top-left-radius: 10px !important;
                     border-top-right-radius: 10px !important;")),
  
  wellPanel(style = "background:white;border:white;
                     margin-left:2%;margin-right:2%;padding-left:0px;padding-right:0px;border-left:0px;border-right:0px;
                     padding-top:-5%;border-top:-5%;margin-top:-5%;
                     border-bottom:-25%;padding-bottom:-25%;margin-bottom:-25%;",
            radioButtons(inputId=ns("download_choice_compare"),
                         choiceNames = list(
                           tags$span(style = "font-size:100%;", "Selected input only"),
                           tags$span(style = "font-size:100%;", "Full dataset")
                         ),
                         choiceValues = list("selected","full"),
                         label = NULL,
                         selected="selected"
            )
  ),
  
  fluidRow(align="center",h6("Save as:", style="color:#3D3C3C;margin-bottom:4%;")),
  wellPanel(style = "background:white;border:white;margin-top:-0%;padding:0px;border:0px;margin-left:7%;margin-right:2%",
            fluidRow(downloadButton(outputId=ns("download_coverage_data_csv"),"CSV (.csv)",icon=NULL)),
            fluidRow(downloadButton(outputId=ns("download_coverage_data_xlsx"),"Excel (.xlsx)",icon=NULL)),
            fluidRow(downloadButton(outputId=ns("download_coverage_data_txt"),"Text (.txt)",icon=NULL))
  ),

  size = "xs",
  status = "myClass",
  label = "Download Data",
  icon = icon("file-lines"),
  up = TRUE
),


#simulate a click on the dropdown button when input$rnd changes (see server)
#see server side too
tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_csv', function(x){
                                                                     $('html').click();});")
),

tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_excel', function(x){
                                                                     $('html').click();});")
),

tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop2_txt', function(x){
                                                                     $('html').click();});")
),


# simulate a click on the dropdown button when input$rnd changes (see server)
# see server side too
tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_jpeg', function(x){
                                                                     $('html').click();});")
),

tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_pdf', function(x){
                                                                     $('html').click();});")
),

tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_png', function(x){
                                                                     $('html').click();});")
), 


tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_season_jpeg', function(x){
                                                                     $('html').click();});")
),

tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_season_pdf', function(x){
                                                                     $('html').click();});")
),

tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_season_png', function(x){
                                                                     $('html').click();});")
), 





),




      
      # Outputs ----------------------------------------------------------------
      
      column(9,style=(style='padding-right:80px;padding-left:80px;padding-top:20px;
                                     margin-top:-4.0%;'),
             tabsetPanel(
               
               id = ns("tab_selected_summary_coverage"),

               #conditionalPanel(
                 #condition = "output.coverage_render_binary == 0",
               tabPanel(title = "Trend", 
                        value = "summary_coverage_plot",
                        class = "one",
                        tags$div(girafeOutput(ns("summary_coverage_plot_girafe"),
                                              width = '100%', height = '100%')),

                        uiOutput(ns("summary_coverage_plot_render"))
                        # conditionalPanel((condition = paste0("output.", ns("coverage_render_binary"), "==0")),
                        #                  span("groups of words", style = "color:red") 
                        # ), 
                        # conditionalPanel((condition = paste0("output.", ns("coverage_render_binary"), "==1")),
                        #                  span("groups of words", style = "color:blue") 
                        # )
                        
                          # tags$div(girafeOutput(ns("summary_coverage_plot_girafe"),
                          #                       width = '100%', height = '100%')) 
                        #)
               ),
               #conditionalPanel(
                 #condition = "output.coverage_render_binary == 1",
               # tabPanel(title = "Trend", 
               #          value = "summary_coverage_plot",
               #          class = "one",
               #          span("groups of words", style = "color:blue") 
               #)
               #),
               tabPanel(title = "Seasonality", 
                        value = "compare_plot", 
                        class = "one",
                        #uiOutput(ns("coverage_render_binary"))
                        #htmlOutput("coverage_render_binary")
                        
                        tags$div(girafeOutput(ns("summary_coverage_season_plot_girafe"),
                                              width = '100%', height = '100%')
                                 
                                 # %>% shinycssloaders::withSpinner(type = 4
                                 #                                  #,color = colour_bhf_lightred
                                 #                                  ,size = 0.7
                                 #                                  ,custom.css = TRUE
                                 #                                  ,id = "custom_spinner"
                                 #                                  )
                                 ),
                        uiOutput(ns("summary_coverage_season_plot_render"))
                        
                        )
             )),
      
    )
  )
}


dataCoverageServer <- function(id, dataset_summary, nation_summary, coverage_data) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$count_coverage_ex <- renderUI({

        tagList(
          checkboxGroupInput(inputId = "summary_module-data_coverage_module-count_coverage", #IMPORTANT for using renderUI so inputID can be recognised by plots
                             label = "Overall Count:", 
                             choices = c('<span class="count_options_cov">Records'='n',


'<span class="count_options_cov">Records with a de-identified PERSON ID 


        <div class="pretty p-default p-switch p-fill"></div>
          <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate"
          aria-label="Number of records with
a de-identified person
identifier that are
potentially linkable
across datasets within
the respective TRE">
            <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
            </span></div></span>'='n_id',


'<span class="count_options_cov">Distinct de-identified PERSON ID 


        <div class="pretty p-default p-switch p-fill"></div>
          <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate"
          aria-label="The unique number of 
de-identified person 
identifiers in the dataset, 
excluding null values">
            <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
            </span></div></span>'='n_id_distinct'
),
selected = count_options_selected),
          tags$script(
            "
        $('#summary_module-data_coverage_module-count_coverage .checkbox label span').map(function(choice){
            this.innerHTML = $(this).text();
        });
        "
          )
        )
      })
      
      output$count_coverage_season_ex <- renderUI({
        
        tagList(
          radioButtons(inputId = "summary_module-data_coverage_module-count_coverage_season", #IMPORTANT for using renderUI so inputID can be recognised by plots
                             label = "Overall Count:", 
                             choices = c('<span class="count_options_cov">Records'='n',
                                         
                                         
                                         '<span class="count_options_cov">Records with a de-identified PERSON ID 


        <div class="pretty p-default p-switch p-fill"></div>
          <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate"
          aria-label="Number of records with
a de-identified person
identifier that are
potentially linkable
across datasets within
the respective TRE">
            <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
            </span></div></span>'='n_id',


'<span class="count_options_cov">Distinct de-identified PERSON ID 


        <div class="pretty p-default p-switch p-fill"></div>
          <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate"
          aria-label="The unique number of 
de-identified person 
identifiers in the dataset, 
excluding null values">
            <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
            </span></div></span>'='n_id_distinct'
                             ),
selected = count_options_selected_season),
tags$script(
  "
        $('#summary_module-data_coverage_module-count_coverage_season .radio span').map(function(choice){
            this.innerHTML = $(this).text();
        });
        "
)
        )
      })

      
      coverage_render = reactive({datasets_available %>%
        filter(.data$Dataset == dataset_summary()) %>%
          select(.data$coverage,.data$coverage_reason)
      })
      
      #observe(print(coverage_render()))
      
      output$coverage_render_binary = renderUI({coverage_render() %>% pull(coverage)})
      #observe(print(coverage_render_binary))

      output$summary_coverage_plot_render = renderUI({coverage_render() %>% pull(coverage_reason)})
      output$summary_coverage_season_plot_render = renderUI({coverage_render() %>% pull(coverage_reason)})
      #observe(print(ccoverage_render_text))
      outputOptions(output, "coverage_render_binary", suspendWhenHidden = FALSE)
 
      coverage_data_all_records =  reactive({
        t.data_coverage %>%
          left_join(datasets_available,by = c("dataset"="Dataset")) %>%
          filter(.data$dataset==dataset_summary()) %>%
          #tooltips for plot
          mutate(N_tooltip = format(.data$N, nsmall=0, big.mark=",", trim=TRUE)) %>%
          mutate(N_tooltip_date = paste0(date_name,N_tooltip)) %>%
          mutate(N_tooltip_date_season = paste0(date_name,N_tooltip)) #date_name_season
        
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
                filter(!start_date > date_format) %>%
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
                            NULL,#date_range_coverage_min_start_date(),
                            NULL#date_range_coverage_max_start_date()
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
      
      y_axis = reactive({paste(ifelse(input$log_scale_summary,"Monthly Count (Log Scale)","Monthly Count (Linear Scale)"))})
      
      coverage_title_download = reactive({paste("Data Coverage - ", pull(filter(t.dataset_dashboard,Dataset==dataset_summary()),Title))})

      summary_coverage_plot = reactive({
        
        validate(
          need(nrow(coverage_data_filtered()) >0, message = FALSE)
        )
        
        ggplot(
          data = coverage_data_filtered(),
          aes(x = .data$date_format,
              if(input$log_scale_summary){y=(.data$N)} else {y=.data$N},
              color = .data$Type,
              #data_id = .data$Type,
              group = .data$Type
          )
        ) +
         
          geom_line_interactive(size = 2.5,
                                alpha = if(input$trend_line){1} else {1},
                                aes(
                                  data_id = .data$dataset
                                )) +
          
       
          
          geom_point_interactive(
            aes(tooltip = .data$N_tooltip_date),
            alpha = if(input$trend_line){1} else {1},
            fill = "white",
            size = 2.5,
            stroke = 1.5,
            shape = 20) +
          
       
          
          {if(input$trend_line)geom_smooth_interactive(aes(fill = .data$Type,
                                                           tooltip = .data$N_tooltip_date), method="auto", se=TRUE, fullrange=FALSE, level=0.95)} +

        labs(x = NULL, y = y_axis()) +
          theme_minimal() +
          theme(
            text=element_text(family=family_lato),
            panel.grid = element_blank(),
            plot.margin = margin(10,10,0,0),
            plot.background = element_rect(fill='white',color='white'),
            panel.background = element_rect(fill='white',color='white'),
            axis.ticks = element_blank(),
            axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=14, color="#4D4C4C"),
            axis.text.x = element_text(size = 14, face = "bold"),
            axis.text.y = element_text(size = 13, face = "bold"),
            legend.position = "none"
          ) +
          coord_cartesian(clip = "off") +

          
          scale_colour_manual(values=summary_coverage_palette, name = "colour_summary") +
          scale_fill_manual(values=summary_coverage_palette, name = "colour_summary")  +
          
          scale_y_continuous(labels = scales::label_number_si(),
                             trans=if(input$log_scale_summary){scales::pseudo_log_trans(base = 10)} else {trend="identity"}
          ) 
        
          #{if(input$log_scale_summary)scale_y_continuous(labels = scales::label_number_si()) else {scale_y_continuous(labels = scales::label_number_si())}} #, limits = c(0, NA)
      })
      

      y_nudge = reactive({(
        #nudge up a 30th of difference between max and min
        (
          (
            (
              coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
          ) /30)
      )})
      
      y_nudge_log = reactive({(
        #nudge up a 30th of difference between max and min
        (
          (
            (
              log(coverage_data_filtered() %>% mutate(N=log(N)) %>% filter(N == max(N)) %>% distinct(N) %>% pull(N))) - (
                log(coverage_data_filtered() %>% mutate(N=log(N)) %>% filter(N == min(N)) %>% distinct(N) %>% pull(N)))
          ) /30)
      )})
      
      x_nudge = reactive({
        (
          as.numeric(
            (coverage_data_filtered() %>% filter(date_format == max(date_format)) %>% distinct(date_format) %>% pull(date_format)) -
              (coverage_data_filtered() %>% filter(date_format == min(date_format)) %>% distinct(date_format) %>% pull(date_format))
          )/10)
      })
      


      output$summary_coverage_plot_girafe = renderGirafe({
        
        validate(
          need(nrow(coverage_data_filtered()) >0, message = FALSE)
        )
        
        girafe(ggobj = summary_coverage_plot() +
                 
                 (geom_text_repel_interactive(
                   size = 7,
                   fontface="bold",
                   data = (
                     coverage_data_filtered() %>% 
                       filter(date_format == max(date_format)) %>%
                       left_join(as.data.frame(count_options) %>% 
                                   rename(Type=count_options) %>% 
                                   rownames_to_column("count_options"),by="Type") %>%
                       left_join(tibble(
                         count_options=c("Records","Records with a de-identified PERSON ID","Distinct de-identified PERSON ID"),
                         count_options_1=c("Records","Records with PERSON ID","Distinct PERSON IDs")
                       ),by="count_options"
                       )
                   ),
                   
                   aes(
                     x = .data$date_format + x_nudge(),
                     y = if(input$log_scale_summary){(.data$N) } else {.data$N + (
                       #nudge up a 30th of difference between max and min
                       (
                         (
                           (
                             coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                               coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                         ) /30)
                     )},
                     color = .data$Type,
                     label = .data$count_options_1
                   ),

                   direction = "y",
                   #box.padding = 1, max.overlaps = Inf,
                   #hjust=1, #right just
                   family=family_lato,
                   segment.color = 'transparent'))
               
               ,
               width_svg = 16,
               height_svg = 9,
               options = list(
                 opts_tooltip(
                   opacity = 0.95, #opacity of the background box
                   css = "background-color:#FF0030;
            color:white;font-size:10pt;font-style:italic;
            padding:5px;border-radius:10px 10px 10px 10px;"
                 ),
            #to work - need data_id on
            opts_hover_inv(
              css = "stroke-width:3; opacity:0.6;" #"opacity:0.2; transition-delay:0.2s;"
            ),
            opts_hover(
              css = if(input$trend_line){"opacity: 1; transition-delay:0.2s;"} else {"opacity: 1; transition-delay:0.2s;"} 
            ),
            #turn off save as png as will put this as a shiny command to match excel download
            opts_toolbar(saveaspng = FALSE),
            opts_selection(type="none")
               )
        )
      })


      output$download_summary_coverage_plot_jpeg = downloadHandler(
        filename = function() {paste0("data_coverage_trend_",str_remove_all(Sys.Date(),"-"),".jpeg")},
        content = function(file) {ggsave(file, plot = (summary_coverage_plot()) +
                                           ggtitle(coverage_title_download()) +
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
                                               x = .data$date_format + x_nudge(),
                                               y = if(input$log_scale_summary){(.data$N) } else {.data$N + (
                                                 #nudge up a 30th of difference between max and min
                                                 (
                                                   (
                                                     (
                                                       coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                                                         coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                                                   ) /30)
                                               )},
                                               color = .data$Type,
                                               label = .data$count_options
                                             ),
                                             
                                             direction = "y",
                                             family=family_lato,
                                             segment.color = 'transparent')) +
                                           #new theme for download
                                           theme(plot.margin = margin(20,50,20,50),
                                                 axis.text.x = element_text(size = 34, face = "bold"),
                                                 axis.text.y = element_text(size = 34, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=34, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 #plot.title = element_markdown(lineheight = 2.8, margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 plot.title = element_text(color="#4D4C4C", size=38, face = "bold",margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                           ),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "jpeg")}
      )
      
      output$download_summary_coverage_plot_pdf = downloadHandler(
        filename = function() {paste0("data_coverage_trend_",str_remove_all(Sys.Date(),"-"),".pdf")},
        content = function(file) {ggsave(file, plot = (summary_coverage_plot()) +
                                           ggtitle(coverage_title_download()) +
                                           (geom_text_repel_interactive(
                                             size = 4,
                                             data = (
                                               coverage_data_filtered() %>% 
                                                 filter(date_format == max(date_format)) %>%
                                                 left_join(as.data.frame(count_options) %>% 
                                                             rename(Type=count_options) %>% 
                                                             rownames_to_column("count_options"),by="Type")
                                             ),
                                             
                                             aes(
                                               x = .data$date_format + x_nudge(),
                                               y = if(input$log_scale_summary){(.data$N) } else {.data$N + (
                                                 #nudge up a 30th of difference between max and min
                                                 (
                                                   (
                                                     (
                                                       coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                                                         coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                                                   ) /30)
                                               )},
                                               color = .data$Type,
                                               label = .data$count_options
                                             ),
                                             
                                             direction = "y",
                                             family=family_lato,
                                             segment.color = 'transparent')) +
                                           #new theme for download
                                           theme(plot.margin = margin(20,50,20,50),
                                                 axis.text.x = element_text(size = 10, face = "bold"),
                                                 axis.text.y = element_text(size = 10, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=10, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 #plot.title = element_markdown(lineheight = 2.8, margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 plot.title = element_text(color="#4D4C4C", size=12, face = "bold",margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                           ),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "pdf")}
      )

      output$download_summary_coverage_plot_png = downloadHandler(
        filename = function() {paste0("data_coverage_trend_",str_remove_all(Sys.Date(),"-"),".png")},
        content = function(file) {ggsave(file, plot = (summary_coverage_plot()) +
                                           ggtitle(coverage_title_download()) +
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
                                               x = .data$date_format + x_nudge(),
                                               y = if(input$log_scale_summary){(.data$N) } else {.data$N + (
                                                 #nudge up a 30th of difference between max and min
                                                 (
                                                   (
                                                     (
                                                       coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                                                         coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                                                   ) /30)
                                               )},
                                               color = .data$Type,
                                               label = .data$count_options
                                             ),
                                             
                                             direction = "y",
                                             family=family_lato,
                                             segment.color = 'transparent')) +
                                           #new theme for download
                                           theme(plot.margin = margin(20,50,20,50),
                                                 axis.text.x = element_text(size = 34, face = "bold"),
                                                 axis.text.y = element_text(size = 34, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=34, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 #plot.title = element_markdown(lineheight = 2.8, margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 plot.title = element_text(color="#4D4C4C", size=38, face = "bold",margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 ),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "png")}
      )
      
      
      
      ## Season Plot ===========================================================

      
      summary_coverage_season_plot = reactive({
        
        validate(
          need(nrow(coverage_data_filtered_season()) >0, message = FALSE)
        )
        
        ggplot(
          data = coverage_data_filtered_season() %>% mutate(date_y=as.character(date_y)),
          aes(x = .data$date_m,
              y = .data$N,
              color = .data$date_y,
              #data_id = .data$date_m,
              group = .data$date_y
          )
        ) +
          geom_line(size = 2.6,
                                alpha = 0.8) +
          geom_point_interactive(
            aes(tooltip = .data$N_tooltip_date_season),
            fill = "white",
            size = 2.6,
            stroke = 1.5,
            shape = 20) +
          
          labs(x = NULL, y = "Count (Linear Scale)") +
          

          theme_minimal() +
          theme(
            text=element_text(family=family_lato),
            panel.grid = element_blank(),
            plot.margin = margin(10,50,0,0),
            plot.background = element_rect(color=NA),
            panel.background = element_rect(color = NA),
            axis.ticks = element_blank(),
            axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=14, color="#4D4C4C"),
            axis.text.x = element_text(size = 14, face = "bold"),
            axis.text.y = element_text(size = 13, face = "bold"),
            legend.position = "none"
          ) +
          coord_cartesian(clip = "off") +
          

          
          scale_colour_manual(values = c(

          season_colour_palette()
            
            )) +
          
          scale_y_continuous(labels = scales::label_number_si()) +
          scale_x_continuous(breaks = 1:12, #c(1, 4, 7, 10),
                             label = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))
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
        
        validate(
          need(nrow(coverage_data_filtered_season()) >0, message = FALSE)
        )
        
        girafe(ggobj = summary_coverage_season_plot() +
                 #add geom text layer separate for girafe object and download as different sizes needed
                 geom_text_repel_interactive(
                 size = 8,

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
                   css = "background-color:#FF0030;
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
            opts_toolbar(saveaspng = FALSE),
            opts_selection(type="none")
               )
        )
      })
      
      
      output$download_summary_coverage_season_plot_jpeg = downloadHandler(
        filename = function() {paste0("data_coverage_seasonality_",str_remove_all(Sys.Date(),"-"),".jpeg")},
        content = function(file) {ggsave(file, plot = (summary_coverage_season_plot()) +
                                           ggtitle(coverage_title_download()) +
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
                                                 axis.text.y = element_text(size = 34, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=34, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 #plot.title = element_markdown(lineheight = 2.8, margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 plot.title = element_text(color="#4D4C4C", size=38, face = "bold",margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                           ),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "jpeg")}
      )
      
      output$download_summary_coverage_season_plot_pdf = downloadHandler(
        filename = function() {paste0("data_coverage_seasonality_",str_remove_all(Sys.Date(),"-"),".pdf")},
        content = function(file) {ggsave(file, plot = (summary_coverage_season_plot()) +
                                           ggtitle(coverage_title_download()) +
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
                                                 axis.text.y = element_text(size = 34, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=34, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 #plot.title = element_markdown(lineheight = 2.8, margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 plot.title = element_text(color="#4D4C4C", size=38, face = "bold",margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                           ),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "pdf")}
      )
      
      
      output$download_summary_coverage_season_plot_png = downloadHandler(
        filename = function() {paste0("data_coverage_seasonality_",str_remove_all(Sys.Date(),"-"),".png")},
        content = function(file) {ggsave(file, plot = (summary_coverage_season_plot()) +
                                           ggtitle(coverage_title_download()) +
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
                                                 axis.text.y = element_text(size = 34, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=34, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 #plot.title = element_markdown(lineheight = 2.8, margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 plot.title = element_text(color="#4D4C4C", size=38, face = "bold",margin = margin(t = 6, r = 0, b = 6, l = 0)), #ggtext
                                                 ),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 16, height = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "png")}
      )
      

      

      
      
      
      
      
      

      

      observe({
        if(is.null(input$rnd_jpeg)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_jpeg', click)
            var compare_jpeg = document.getElementById('summary_module-data_coverage_module-download_summary_coverage_plot_jpeg')
            compare_jpeg.onclick = function() {click += 1; Shiny.onInputChange('rnd_jpeg', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_jpeg, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_jpeg", ""))
      })
      
      
      observe({
        if(is.null(input$rnd_jpeg)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_jpeg', click)
            var compare_jpeg = document.getElementById('summary_module-data_coverage_module-download_summary_coverage_season_plot_jpeg')
            compare_jpeg.onclick = function() {click += 1; Shiny.onInputChange('rnd_jpeg', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_jpeg, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_season_jpeg", ""))
      })
      
      
      
      observe({
        if(is.null(input$rnd_pdf)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_pdf', click)
            var compare_pdf = document.getElementById('summary_module-data_coverage_module-download_summary_coverage_plot_pdf')
            compare_pdf.onclick = function() {click += 1; Shiny.onInputChange('rnd_pdf', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_pdf, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_pdf", ""))
      })


      observe({
        if(is.null(input$rnd_pdf)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_pdf', click)
            var compare_pdf = document.getElementById('summary_module-data_coverage_module-download_summary_coverage_season_plot_pdf')
            compare_pdf.onclick = function() {click += 1; Shiny.onInputChange('rnd_pdf', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_pdf, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_season_pdf", ""))
      })


      observe({
        if(is.null(input$rnd_png)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_png', click)
            var compare_png = document.getElementById('summary_module-data_coverage_module-download_summary_coverage_plot_png')
            compare_png.onclick = function() {click += 1; Shiny.onInputChange('rnd_png', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_png, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_png", ""))
      })
      
      
      observe({
        if(is.null(input$rnd_png)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_png', click)
            var compare_png = document.getElementById('summary_module-data_coverage_module-download_summary_coverage_season_plot_png')
            compare_png.onclick = function() {click += 1; Shiny.onInputChange('rnd_png', click)};
            ")
        }
      })
      
      observeEvent(input$rnd_png, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop1_season_png", ""))
      })
      
      
      
      observeEvent(input$download_coverage_data, {
        
        ns <- session$ns
        
        shinyalert::shinyalert("Export Data:", 
                               type = "info",
                               size = "xs",
                               html = TRUE,
                               text = tagList(
                                 #textInput(inputId = "namere", label = NULL),
                                 selectInput(inputId = ns("download_choice_compare"), choices=c("with selected input"="selected","in full"="full"), label=NULL),
                                 downloadButton(ns("confName"), "Confirm")
                               ),
                               closeOnEsc = TRUE,
                               closeOnClickOutside = TRUE,
                               showConfirmButton = FALSE,
                               showCancelButton = FALSE,
                               animation = TRUE
        )
        runjs("
        var confName = document.getElementById('summary_module-data_coverage_module-confName')
        confName.onclick = function() {swal.close();}
        ")
        
      })
      
      
      
      # output$confName = downloadHandler(
      #   filename = function() {if(input$download_choice_compare=="selected"){
      #     paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".xlsx")} else {
      #       paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".xlsx")}
      #     },
      #   content = function(file) {writexl::write_xlsx(
      #     
      #     if(input$download_choice_compare=="selected"){
      #       
      #       t.data_coverage_source %>%
      #         arrange(dataset,date_ym) %>%
      #         left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
      #         filter(.data$dataset == dataset_summary()) %>%
      #         ungroup() %>%
      #         mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
      #         filter(!is.na(date_ym)) %>%
      #         separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
      #         mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
      #         filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
      #         
      #         select(dataset,title, date_ym, any_of(input$count_coverage)) %>%
      #         mutate(export_date = Sys.Date())
      #             
      #     } else {t.data_coverage_source %>%
      #         arrange(dataset,date_ym) %>%
      #         left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
      #         filter(.data$dataset == dataset_summary()) %>%
      #         ungroup() %>%
      #         mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
      #         filter(!is.na(date_ym)) %>%
      #         select(dataset,title, date_ym, n, n_id, n_id_distinct) %>%
      #         mutate(export_date = Sys.Date())},
      #     
      #     format_headers = FALSE,
      #     path=file)}
      # )
      

      output$download_coverage_data_xlsx = downloadHandler(
        filename = function() {if(input$download_choice_compare=="selected"){
          paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".xlsx")} else {
            paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".xlsx")}
        },
        content = function(file) {writexl::write_xlsx(
          
          if(input$download_choice_compare=="selected"){
            
            t.data_coverage_source %>%
              arrange(dataset,date_ym) %>%
              left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
              filter(.data$dataset == dataset_summary()) %>%
              ungroup() %>%
              mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
              filter(!is.na(date_ym)) %>%
              separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
              mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
              filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
              
              select(dataset,title, date_ym, any_of(input$count_coverage)) %>%
              mutate(export_date = Sys.Date())
            
          } else {t.data_coverage_source %>%
              arrange(dataset,date_ym) %>%
              left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
              filter(.data$dataset == dataset_summary()) %>%
              ungroup() %>%
              mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
              filter(!is.na(date_ym)) %>%
              select(dataset,title, date_ym, n, n_id, n_id_distinct) %>%
              mutate(export_date = Sys.Date())},
          
          format_headers = FALSE,
          path=file)}
      )
      
      output$download_coverage_data_csv = downloadHandler(
        filename = function() {if(input$download_choice_compare=="selected"){
          paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".csv")} else {
            paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".csv")}
        },
        content = function(file) {write_csv(
          
          if(input$download_choice_compare=="selected"){
            
            t.data_coverage_source %>%
              arrange(dataset,date_ym) %>%
              left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
              filter(.data$dataset == dataset_summary()) %>%
              ungroup() %>%
              mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
              filter(!is.na(date_ym)) %>%
              separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
              mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
              filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
              
              select(dataset,title, date_ym, any_of(input$count_coverage)) %>%
              mutate(export_date = Sys.Date())
            
          } else {t.data_coverage_source %>%
              arrange(dataset,date_ym) %>%
              left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
              filter(.data$dataset == dataset_summary()) %>%
              ungroup() %>%
              mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
              filter(!is.na(date_ym)) %>%
              select(dataset,title, date_ym, n, n_id, n_id_distinct) %>%
              mutate(export_date = Sys.Date())},
          
          path=file)}
      )
      
      
      output$download_coverage_data_txt = downloadHandler(
        filename = function() {if(input$download_choice_compare=="selected"){
          paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".txt")} else {
            paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".txt")}
        },
        content = function(file) {write_tsv(
          
          if(input$download_choice_compare=="selected"){
            
            t.data_coverage_source %>%
              arrange(dataset,date_ym) %>%
              left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
              filter(.data$dataset == dataset_summary()) %>%
              ungroup() %>%
              mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
              filter(!is.na(date_ym)) %>%
              separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
              mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
              filter(.data$date_y>=input$date_range_coverage[1] & .data$date_y<=input$date_range_coverage[2]) %>%
              
              select(dataset,title, date_ym, any_of(input$count_coverage)) %>%
              mutate(export_date = Sys.Date())
            
          } else {t.data_coverage_source %>%
              arrange(dataset,date_ym) %>%
              left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
              filter(.data$dataset == dataset_summary()) %>%
              ungroup() %>%
              mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
              filter(!is.na(date_ym)) %>%
              select(dataset,title, date_ym, n, n_id, n_id_distinct) %>%
              mutate(export_date = Sys.Date())},
          
          path=file)}
      )
      
      
      observe({
        if(is.null(input$rnd_csv)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_csv', click)
            var compare_csv = document.getElementById('summary_module-data_coverage_module-download_coverage_data_csv')
            compare_csv.onclick = function() {click += 1; Shiny.onInputChange('rnd_csv', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_csv, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_csv", ""))
      })
      
      
      observe({
        if(is.null(input$rnd_excel)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_excel', click)
            var compare_xlsx = document.getElementById('summary_module-data_coverage_module-download_coverage_data_xlsx')
            compare_xlsx.onclick = function() {click += 1; Shiny.onInputChange('rnd_excel', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_excel, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_excel", ""))
      })
      
      observe({
        if(is.null(input$rnd_txt)){
          runjs("
            var click = 0;
            Shiny.onInputChange('rnd_txt', click)
            var compare_txt = document.getElementById('summary_module-data_coverage_module-download_coverage_data_txt')
            compare_txt.onclick = function() {click += 1; Shiny.onInputChange('rnd_txt', click)};
            ")      
        }
      })
      
      observeEvent(input$rnd_txt, {
        shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                       session$sendCustomMessage("close_drop2_txt", ""))
      })
      

      
      
      
      observeEvent(input$tab_selected_summary_coverage,{
        #req(input$tab_selected_summary_coverage)
        if (input$tab_selected_summary_coverage == 'summary_coverage_plot') {
          shinyjs::enable("log_scale_summary")
          shinyjs::enable("trend_line")
          shinyjs::enable("pretty_custom_icon")
        } else {
          shinyjs::disable("log_scale_summary")
          shinyjs::disable("trend_line")
          shinyjs::disable("pretty_custom_icon")
        }
      })
      

      
      observe({
        toggle(id = "summary_coverage_plot_render", condition = isTRUE(dataset_summary() %in% coverage_render_messages))
        toggle(id = "summary_coverage_season_plot_render", condition = isTRUE(dataset_summary() %in% coverage_render_messages))
      })
      observe({
        toggle(id = "summary_coverage_plot_girafe", condition = isFALSE(dataset_summary() %in% coverage_render_messages))
        toggle(id = "summary_coverage_season_plot_girafe", condition = isFALSE(dataset_summary() %in% coverage_render_messages))
      })
      
    }
  )
}
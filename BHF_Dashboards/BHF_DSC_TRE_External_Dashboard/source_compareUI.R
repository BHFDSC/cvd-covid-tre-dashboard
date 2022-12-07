## Data Coverage ===========================================================
fluidRow(titlePanel(h3(id = 'section_heading_hyper',
                       shinyLink(to = "dcov_meth", label = "Data Coverage") %>% add_prompt(
                         message = "Go to methodology",
                         position = "right", type = "info",
                         arrow=FALSE,
                         size = "s", rounded = TRUE,
                         bounce=FALSE,animate=FALSE)
                       )),
         
         #tabset panel styling for pills
         tags$head(tags$style(tabset_panel_compare_styling)),
         
         #UI INPUT
         column(3,
                style = 'z-index:99 !important;',
                tabsetPanel(id = "tab_selected_data_input", type="pills",
                            
                            
                            #DATA INPUT
                            tabPanel("Data",
                                 
                                     value = "data_input",
                                     id = "data_input_css",
                                    
                                     wellPanel(style = bhf_tab_panel_style,
                                               
                                               div(id = "message_temp",
                                                   div(style = "color:#A0003C !important; margin-bottom:5%;",
                                                   "Click below to begin comparing datasets:")
                                                   ),

                                               
                                               tags$div(id = "Panels"),
                                               actionButton("add",
                                                            "Add Dataset")
                                               
                                     )
                            ),
                            
                            #PLOT INPUT
                            tabPanel(title = "Plot",
                                     value = "plot_input",
                                     fluidRow(
                                     wellPanel(style = bhf_tab_panel_style,
                                               
                                               #DATE RANGE SLIDER
                                               sliderInput(inputId = "date_range_coverage2",
                                                           label = "Date Range:",
                                                           #initialise values
                                                           min = 2018, max = 2021,
                                                           value = c(2018,2021),
                                                           step=1, sep = ""),
                                               
                                               #EXTREME VALUES
                                               fluidRow(column(12,
                                               prettySwitchCustom(inputId = "all_records",
                                                            label = "Show extreme dates", fill = TRUE,spaces = 2,
                                                            my_message = extreme_dates_text,prompt_size="medium",prompt_position="bottom-right"))),
                                               
                                               #TYPE INPUT
                                               fluidRow(
                                               radioButtons(
                                                 inputId = "type_compare",
                                                 label = h6(id='count_heading',paste0("Count:",stringi::stri_dup(intToUtf8(160),2)),
                                                            tags$span(icon("info-circle"), id = "iconer") %>% 
                                                              
                                                              add_prompt(
                                                                message = type_text,
                                                                position = "right", type = "error",
                                                                size = "medium", rounded = TRUE,
                                                                bounce=FALSE,animate=FALSE
                                                              )),
                                                 selected = count_options_selected_season,
                                                 choices = count_options)),
                                               
                                               #LOG SCALE
                                               prettySwitchCustom(inputId = "log_scale",
                                                            label = "Log scale", fill = TRUE, value=TRUE, info=FALSE),
                                               
                                               #TREND LINE
                                               prettySwitchCustom(inputId = "trend_line",
                                                            label = "Show trend", fill = TRUE, value=FALSE, spaces = 2, my_message = trend_text , prompt_size="medium"),
                                               
                                               
                                               fluidRow(column(12,
                                               downloadButton(outputId = "download_compare_coverage_plot",
                                                              label = "Download PNG",
                                                              icon = icon("file-image"))
                                               )),

                                               fluidRow(column(12,
                                               actionButton("download_coverage_data",
                                                              label="Export Data",
                                                              icon = icon("file-excel"))
                                               )),
                                               
                                               # dropdown(id = "testingf",
                                               #   radioGroupButtons(
                                               #     inputId = "box1.0",
                                               #     label = "Choose groups", 
                                               #     choiceNames = c("Antimicrobial - Groups", "Antimicrobials"), 
                                               #     choiceValues = c("ab_group", "ab_type"), 
                                               #     direction = "vertical"
                                               #   ),
                                               #   radioGroupButtons(
                                               #     inputId = "box1.1",
                                               #     label = "Show", 
                                               #     choiceNames = c("Prescriptions", "DDD per 100 bed days", "DOT per 100 bed days"),
                                               #     choiceValues = c("prescriptions", "DDD_100", "DOT_100"),
                                               #     selected = "prescriptions", 
                                               #     direction = "vertical"
                                               #   ),
                                               #   size = "xs",
                                               #   icon = icon("gear", class = "opt"), 
                                               #   up = TRUE
                                               # )
                                               

                                               
                                     )
                            )
                ))
         ),
         
         #UI OUTPUT
         column(9,
                
                tags$div(girafeOutput("compare_coverage_plot_girafe",
                                      width = '100%', height = '85%') 
                        # %>% shinycssloaders::withSpinner(type = 4, color = colour_bhf_lightred ,size = 0.7)
                         )
                
                #tableOutput("table"),
                #textOutput("test")
                #textOutput("reactive_test"),
                #tableOutput("reactive_test_table")
                
         ),
)

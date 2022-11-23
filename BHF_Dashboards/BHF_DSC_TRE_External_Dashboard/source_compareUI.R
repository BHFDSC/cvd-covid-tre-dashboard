## Data Coverage ===========================================================
fluidRow(titlePanel(h3(id = 'section_heading',"Data Coverage")),
         
         #tabset panel styling
         tags$head(tags$style(tabset_panel_compare_styling)),
         
         #UI INPUT
         column(3,
                
                tabsetPanel(id = "tab_selected_data_input", type="pills",
                            
                            #DATA INPUT
                            tabPanel(title = "Data",
                                     value = "data_input",
                                     wellPanel(style = bhf_tab_panel_style,
                                               
                                               tags$div(id = "Panels"),
                                               actionButton("add",
                                                            "Add Dataset")
                                               
                                     )
                            ),
                            
                            #PLOT INPUT
                            tabPanel(title = "Plot",
                                     value = "plot_input",
                                     wellPanel(style = bhf_tab_panel_style,
                                               
                                               #DATE RANGE SLIDER
                                               sliderInput(inputId = "date_range_coverage2",
                                                           label = "Date Range:",
                                                           #initialise values
                                                           min = 2018, max = 2021,
                                                           value = c(2018,2021),
                                                           step=1, sep = ""),
                                               
                                               #EXTREME VALUES
                                               prettySwitch(inputId = "all_records",
                                                            label = "Show extreme dates", fill = TRUE) %>%
                                                 
                                                 add_prompt(
                                                   message = extreme_dates_text,
                                                   position = "right", type = "error",
                                                   size = "small", rounded = TRUE
                                                 ),
                                               
                                               #TYPE INPUT
                                               fluidRow(
                                               radioButtons(
                                                 inputId = "type_compare",
                                                 label = "Order:",
                                                 selected = count_options_selected,
                                                 choices = count_options) %>%
                                                 
                                                 add_prompt(
                                                   message = type_text,
                                                   position = "right", type = "error",
                                                   size = "small", rounded = TRUE
                                                 )),
                                               
                                               #LOG SCALE
                                               prettySwitch(inputId = "log_scale",
                                                            label = "Log scale", fill = TRUE, value=TRUE),
                                               
                                               #TREND LINE
                                               prettySwitch(inputId = "trend_line",
                                                            label = "Show trend", fill = TRUE, value=FALSE),
                                               
                                     )
                            )
                )
         ),
         
         #UI OUTPUT
         column(9,
                
                tags$div(girafeOutput("compare_coverage_plot_girafe",
                                      width = '100%', height = '85%')),
                #tableOutput("table"),
                #textOutput("test")
                #textOutput("reactive_test"),
                #tableOutput("reactive_test_table")
                
         ),
)

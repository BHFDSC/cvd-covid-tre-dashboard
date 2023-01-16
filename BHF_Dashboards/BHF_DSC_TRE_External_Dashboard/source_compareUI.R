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
                                               
                                               
                                               # fluidRow(column(12,
                                               # downloadButton(outputId = "download_compare_coverage_plot",
                                               #                label = "Download PNG",
                                               #                icon = icon("file-image"))
                                               # )),

                                               # fluidRow(column(12,
                                               # actionButton("download_coverage_data",
                                               #                label="Export Data",
                                               #                icon = icon("file-excel"))
                                               # )),
                                               
                                               
                                               dropdown(
                                                 id = "compare_dropdown_image",
                                                 inputId = "compare_dropdown_image",
                                              
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
                                                 fluidRow(downloadButton(outputId="compare_jpeg","JPEG (.jpeg)",icon=NULL)),
                                                 fluidRow(downloadButton(outputId="compare_pdf","PDF (.pdf)",icon=NULL)),
                                                 fluidRow(downloadButton(outputId="compare_png","PNG (.png)",icon=NULL)),
                                                
                                                 #no longer using radioGroupButtons but have made radioGroupButtons style above with downloadButtons
                                                 # radioGroupButtons(
                                                 #   inputId = "download_image_choice2",
                                                 #   label = "Export as:",
                                                 #   choiceNames = c("JPEG","PDF","PNG"),
                                                 #   choiceValues = c(".jpeg", ".pdf", ".png"),
                                                 #   selected = character(0),
                                                 #   width = "100%",
                                                 #   direction = "vertical"
                                                 # ),
                                                 size = "xs",
                                                 status = "myClass",
                                                 label = "Download Plot",
                                                 icon = icon("file-image"),
                                                 up = TRUE
                                               ),
                                               
                                               
                                               #simulate a click on the dropdown button when input$rnd changes (see server)
                                               #see server side too
                                               tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_jpeg', function(x){
                                                                     $('html').click();});")
                                               ),
                                               
                                               tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_pdf', function(x){
                                                                     $('html').click();});")
                                               ),
                                               
                                               tags$head(tags$script("Shiny.addCustomMessageHandler('close_drop1_png', function(x){
                                                                     $('html').click();});")
                                               ),
                                            
                                               
                                               dropdown(
                                              
                                                 
                                                 id = "compare_dropdown_data",
                                                 inputId = "compare_dropdown_data",
                                            
                                        
                                                 fluidRow(align="center", style="margin-top: -11%;
                                                                            padding-top: -11%;
                                                                            padding-left: -11.3%;
                                                                            margin-left: -11.3%;
                                                                            padding-right: -10.9%;
                                                                            margin-right:-10.9%;
                                                                            padding-bottom:3%;",
                                                          h6("Download Data", 
                                                                            style="color:white;background-color:#A0003C;
                                                                            font-size:100%;
                                                                            padding-top: 3%;
                                                                            padding-bottom:3.5%;
                                                                            border-top-left-radius: 10px !important;
                                                                            border-top-right-radius: 10px !important;")),
                                                 
                                                 wellPanel(style = "background:white;border:white;margin-left:-3%;margin-right:-3%;
                                                           padding-top:5px;padding-bottom:5px;padding-left:0px;padding-right:0px;
                                                           border-top:5px;border-bottom:5px;border-left:0px;border-right:0px;",
                                                 radioButtons(inputId="compare_download_type",
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
                                                 wellPanel(style = "background:white;border:white;margin-top:-0%;padding:0px;border:0px;",
                                                 fluidRow(downloadButton(outputId="compare_csv","CSV (.csv)",icon=NULL)),
                                                 fluidRow(downloadButton(outputId="compare_xlsx","Excel (.xlsx)",icon=NULL)),
                                                 fluidRow(downloadButton(outputId="compare_txt","Text (.txt)",icon=NULL))
                                                 ),
                                                 
                                                 #no longer using radioGroupButtons but have made radioGroupButtons style above with downloadButtons
                                                 # radioGroupButtons(
                                                 #   inputId = "download_image_choice2",
                                                 #   label = "Export as:",
                                                 #   choiceNames = c("JPEG","PDF","PNG"),
                                                 #   choiceValues = c(".jpeg", ".pdf", ".png"),
                                                 #   selected = character(0),
                                                 #   width = "100%",
                                                 #   direction = "vertical"
                                                 # ),
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
                                               

                                               
                                     )
                            )
                ))
         ),
         
         #UI OUTPUT
         column(9,
                
                #tableOutput("test_output")
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

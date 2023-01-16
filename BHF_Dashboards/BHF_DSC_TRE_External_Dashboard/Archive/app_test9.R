mainapp_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    
    # Application title
    hidden(div(id = ns("app_title"),
               titlePanel("Old Faithful Geyser Data"))),
    # Application UI elements
    hidden(
      fluidRow(id = ns("app_slider_plot"),
               column(
                 4,
                 sliderInput(ns("bins"),
                             "Number of bins:",
                             min = 1,
                             max = 50,
                             value = 30)
               ),
               column(
                 8,
                 plotOutput(ns("distPlot"))
               )
      )
    )
  )
}
mainapp_server <- function(input, output, session) {
  
  delay(ms = 3500, show("app_title"))
  delay(ms = 3800, show("app_slider_plot"))
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}


splash_ui <- function(id) {
  ns <- NS(id)
  div(id = ns("splash_screen"), img(src = "bhf_dsc_logo.png"),
      style = "text-align:center; padding-top:250px;",
      
      fluidRow(
      actionButton("testid","Click here"))
  )
  
  
}
splash_server <- function(input, output, session) {
  observeEvent(input$testid, {
  hide("splash_screen", anim = TRUE, animType = "fade", time = 3)
  })
}

# Define UI for application that draws a histogram
ui <- fluidPage(
  useShinyjs(),
  fluidRow(splash_ui("splash_module")),
  fluidRow(mainapp_ui("mainapp_module"))
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  ss <- callModule(splash_server, "splash_module")
  ma <- callModule(mainapp_server, "mainapp_module")
}

shinyApp(ui, server)
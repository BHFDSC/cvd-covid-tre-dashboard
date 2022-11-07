library(shiny)

ui <- shinyUI(fluidPage(

  titlePanel("Hello Shiny!"),
  
  wellPanel(style = "background: white; border: white;
",
fluidRow(style = "background: rgb(2,0,36);
background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
border-top-left-radius: 10px !important; /*Round Edges*/
border-bottom-left-radius: 10px !important; /*Round Edges*/
border-top-right-radius: 10px !important; /*Round Edges*/
border-bottom-right-radius: 10px !important; /*Round Edges*/
",
    column(3,
           selectInput(inputId = "nation_summary",
                       label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                       choices = c("Country1","Country2"))),
    
    column(3,
           selectInput(inputId = "dataset_summary",
                       label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                       choices = c("Test1","Test2")))
),

    fluidRow(
      plotOutput("distPlot")
    
  )
)))


server <- shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = 10 + 1)
    
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
})

shinyApp(ui=ui,server=server)
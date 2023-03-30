library(shiny)
ui <- fluidPage(
  tabsetPanel(
    tabPanel("Data", 
             uiOutput("moreControls") 
    ),
    tabPanel("Research",
             uiOutput("moreControls2") 
    )
  ),
  plotOutput("plot1")
)

server <- function(input, output) {
  output$moreControls <- renderUI({
    tagList(
      sliderInput("mean", "Mean", -10, 10, 1),
      textInput("label", "Label")
    )
  })
  
  output$moreControls2 <- renderUI({
    tagList(
      sliderInput("sd", "SD", 1, 50, 10),
      textInput("label2", "Label2")
    )
  })
  outputOptions(output, "moreControls2", suspendWhenHidden = FALSE)
  
  output$plot1 <- renderPlot({ 
    req(input$mean, input$sd)
    hist(rnorm(n = 100, input$mean, input$sd) , xlim = c(-100, 100) )
  })
  
}
shinyApp(ui, server)

  library(shiny)
library(shinyjs)
data <- matrix(1:20, nrow=5)

ui <-  fluidPage(title = 'Count Button Clicks',
                 useShinyjs(),
                 fluidRow(style = "padding-bottom: 20px;",


                          
                          tags$head(
                            tags$script("Shiny.addCustomMessageHandler('close_drop1', function(x){
                  $('html').click();
                });")
                          ),
                fluidRow(
                  column(6,
                         dropdown(

                           downloadButton("but1", "Close"),
                           label = "Drop 1",
                           inputId = "drop1"
                         )
                  )
                 )
))

server <- function(input, output, session) {

  
  output$downloadclickCount <- renderText({
    paste('Download Button Clicks =', input$rnd)
  })
  

  
  
  observe({
    if(is.null(input$rnd)){
      runjs("
            var click = 0;
            Shiny.onInputChange('rnd', click)
            var but1 = document.getElementById('but1')
            but1.onclick = function() {click += 1; Shiny.onInputChange('rnd', click)};
            ")      
    }
  })
  
  observeEvent(input$rnd, {
    session$sendCustomMessage("close_drop1", "")
  })
  
}

shinyApp(ui, server)
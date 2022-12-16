library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  tags$head(
    tags$script("Shiny.addCustomMessageHandler('close_drop1', function(x){
                  $('html').click();
                });")
  ),
  fluidRow(
    column(6,
           dropdown(
             actionButton("but1", "Close"),
             label = "Drop 1",
             inputId = "drop1"
           )
    ),

  )
)

server <- function(input, output, session) {
  observeEvent(input$but1, {
    session$sendCustomMessage("close_drop1", "")
  })

}


ui <- fluidPage(
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
    ),
    
  )
)

server <- function(input, output, session) {
  
  observeEvent(input$but1, {
    session$sendCustomMessage("close_drop1", "")
  })
  
  observe({
    if(is.null(input$rnd)){
      runjs("
            var click = 0;
            Shiny.onInputChange('rnd', click)
            var dwnldBtn = document.getElementById('dwnldBtn')
            dwnldBtn.onclick = function() {click += 1; Shiny.onInputChange('rnd', click)};
            ")      
    }
  })
  
  observe(print(input$rnd))
  
}

shinyApp(ui, server)




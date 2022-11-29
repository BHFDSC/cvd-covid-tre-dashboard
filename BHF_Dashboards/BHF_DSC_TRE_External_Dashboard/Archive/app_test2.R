library(shiny)
library(shinyalert)
library(ggplot2)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  useShinyalert(),
  plotOutput("vmgraph"),
  actionButton("downloadPlot", "Download Plot")
) 

server <- function(input, output) {
  
  output$vmgraph <- renderPlot({plot(mtcars)})
  
  observeEvent(input$downloadPlot, {
    shinyalert("Save as:", 
               type = "info",
               size = "m",
               html = TRUE,
               text = tagList(
                 textInput(inputId = "name", label = NULL ),
                 downloadButton("confName", "Confirm")
               ),
               closeOnEsc = TRUE,
               closeOnClickOutside = TRUE,
               showConfirmButton = FALSE,
               showCancelButton = TRUE,
               animation = TRUE
    )
    runjs("
        var confName = document.getElementById('confName')
        confName.onclick = function() {swal.close();}
        ")
  })
  
  output$confName <- downloadHandler(
    filename = function(){
      paste(input$name, ".png", sep = "")},
    content = function(file) {
      ggsave(file, plot = plot(mtcars), width = 12, height = 7.7)
    }
  )
  
}

shinyApp(ui, server)
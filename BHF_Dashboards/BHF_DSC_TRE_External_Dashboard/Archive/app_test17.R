myModuleUI <- function(id) {
  ns <- NS(id)
  
  tabPanel(
    "My Plot",
    plotOutput(ns("myplot"), id = "myplot_output")
  )
}

myModule <- function(input, output, session) {
  output$myplot <- renderPlot({
    # Code to generate the plot
    plot(1:10)
  })
}

ui <- fluidPage(
  shinyjs::useShinyjs(),
  actionButton("hide_button", "Hide Plot"),
  myModuleUI("my_module")
)

server <- function(input, output, session) {
  callModule(myModule, "my_module")
  
  observeEvent(input$hide_button, {
    shinyjs::onclick("hide_button", {
      shinyjs::hide("myplot_output")
    })
  })
}

shinyApp(ui, server)
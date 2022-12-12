library("shiny")
library("shinyWidgets")


ui <- fluidPage(
  
  dropdownButton(
    tags$h3("List of Inputs"),
    selectInput(inputId = 'xcol',
                label = 'X Variable',
                choices = names(iris)),
    
    selectInput(inputId ='ycol',
                label  = 'Y variable',
                choices= c("A","B","C")) ,
    actionButton(inputId = "submit1",
                 label = "Submit"),
    circle = TRUE, 
    status = "primary",
    inputId = "mydropdown",
    icon = icon("gear"), width = "700px"
    
    
  )
)





server <- function(input, output, session) {
  
}

shinyApp(ui = ui, server = server)
library(shiny)
library(shinyhelper)
library(magrittr)

ui <- fluidPage(
  
  titlePanel(title = "Demo APP"),
  
  sidebarLayout(
    
    sidebarPanel = sidebarPanel(
      
      selectInput(inputId = "dataset", "choose DataSet",
                  choices = c("MTCARS","IRSIS")
      ) %>% 
        helper(type = "inline",
               title = "Inline Help",
               content = c("This helpfile is defined entirely in the UI!",
                           "This is on a new line.",
                           "This is some <b>HTML</b>."),
               size = "s")
    ),
    
    mainPanel = mainPanel(
      verbatimTextOutput(outputId = "TABLE")
      
    )
  )
)


server <- function(input, output) {
  observe_helpers()
  output$TABLE<-renderText({
    
    paste0("Dataset selcted: ",input$dataset)
    
  }) 
}

shinyApp(ui, server)
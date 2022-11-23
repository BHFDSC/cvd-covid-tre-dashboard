library(shiny)

generateRandomString <- function(n = 10, m = 10) {
  elements <- c()
  
  chars <- c(LETTERS, letters)
  
  for(idx in 1:n) {
    element <- c()
    
    for(entry in 1:m) {
      val <- sample(c("pair","odd"),1)
      
      switch(val,
             pair = {
               # Add a letter
               element <- c(element, sample(chars,1))
             },
             odd = {
               # Add a number
               element <- c(element, as.character(sample(0:9,1)))
             }
      )
    }
    
    elements <- c(elements, paste0(element,collapse=""))
  }
  
  elements
}

# Define the UI
ui <- fluidPage(
  column(3,
  tags$div(id = 'placeholder'),
  actionButton("adder", "Add")),
  
  column(9,textOutput("test"))
  
)


# Define the server code
server <- function(input, output) {
  rv <- reactiveValues()
  
  rv$counter <- 0
  
  observeEvent(input$adder,{
    rv$counter <- rv$counter + 1
    
    add <- sprintf("%03d",rv$counter)
    
    prefix <- generateRandomString(1,20)
    filterId <- paste0(prefix,'_adder_', add)
    divId <- paste0(prefix,'_adder_div_', add)
    elementFilterId <- paste0(prefix,'_adder_object_', add)
    removeFilterId <- paste0(prefix,'_remover_', add)
    
    insertUI(
      selector = '#placeholder',
      ui = tags$div(
        id = divId,
        fluidRow(
          column(10,style = "margin-top:10%; margin-left:0%; margin-right:0%;",
                 textInput(elementFilterId, label = "Introduce text", value = "")),
          column(1, style = "margin-top:16.9%; margin-left:0%; margin-right:0%;",
                 actionButton(removeFilterId, label = "x", style = ""))
          ),
        
        
        
        )
      )
    
    
    
    # Observer that removes a filter
    observeEvent(input[[removeFilterId]],{
      rv$counter <- rv$counter - 1
      removeUI(selector = paste0("#", divId))
    })
    
    
    output$test = renderPrint(list(reactiveValuesToList(input)))
    
  })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server, options = list(launch.browser = T))
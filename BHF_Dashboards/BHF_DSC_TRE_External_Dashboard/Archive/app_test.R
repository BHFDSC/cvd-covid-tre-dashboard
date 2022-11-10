library(shiny)


LHSchoices <- c("X1", "X2", "X3", "X4")


#------------------------------------------------------------------------------#

# MODULE UI ----
variablesUI <- function(id, number) {
  
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(6,
             selectInput(ns("variable"),
                         paste0("Select Variable ", number),
                         choices = c("Choose" = "", LHSchoices)
             )
      ),
      
      column(6,
             numericInput(ns("value.variable"),
                          label = paste0("Value ", number),
                          value = 0, min = 0
             )
      )
    )
  )
  
}

#------------------------------------------------------------------------------#

# MODULE SERVER ----

variables <- function(input, output, session, variable.number){
  reactive({
    
    req(input$variable, input$value.variable)
    
    # Create Pair: variable and its value
    df <- data.frame(
      "variable.number" = variable.number,
      "variable" = input$variable,
      "value" = input$value.variable,
      stringsAsFactors = FALSE
    )
    
    return(df)
    
  })
}

#------------------------------------------------------------------------------#

# Shiny UI ----

ui <- fixedPage(
  verbatimTextOutput("test1"),
  tableOutput("test2"),
  variablesUI("var1", 1),
  h5(""),
  actionButton("insertBtn", "Add another line")
  
)

# Shiny Server ----

server <- function(input, output) {
  
  add.variable <- reactiveValues()
  
  add.variable$df <- data.frame("variable.number" = numeric(0),
                                "variable" = character(0),
                                "value" = numeric(0),
                                stringsAsFactors = FALSE)
  
  var1 <- callModule(variables, paste0("var", 1), 1)
  
  observe(add.variable$df[1, ] <- var1())
  
  observeEvent(input$insertBtn, {
    
    btn <- sum(input$insertBtn, 1)
    
    insertUI(
      selector = "h5",
      where = "beforeEnd",
      ui = tagList(
        variablesUI(paste0("var", btn), btn)
      )
    )
    
    newline <- callModule(variables, paste0("var", btn), btn)
    
    observeEvent(newline(), {
      add.variable$df[btn, ] <- newline()
    })
    
  })
  
  output$test1 <- renderPrint({
    print(add.variable$df)
  })
  
  output$test2 <- renderTable({
    add.variable$df
  })
  
}

#------------------------------------------------------------------------------#

shinyApp(ui, server)
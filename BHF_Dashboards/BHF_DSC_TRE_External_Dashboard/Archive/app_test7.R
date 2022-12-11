library(shiny)
library(rhandsontable)
library(tidyverse)

make_DF <- function(n) {
  DF <- data_frame(
    entry = 1:n,
    protein = NA_character_,
    MW = NA_real_,
    n = NA_integer_,
    mean = NA_real_,
    sd = NA_real_,
    units = factor("ng/mL", levels  = c("pg/mL", "ng/mL", 'mcg/mL', 'mg/mL', 'g/mL'))
  )
  DF[-1]
}

ui <- fluidPage(
  tabPanel("Input", 
           column(4,
                  wellPanel(
                    numericInput("n_entries",
                                 "Number of Concentrations to estimate:",
                                 value = 1,
                                 min = 1),
                    actionButton("update_table", "Update Table")
                  )
           ),
           column(8,
                  rHandsontableOutput("input_data") )
  ),
  tabPanel("Output",
           column(12,
                  tableOutput("test_output")
           )
  )
)

server <- function(input, output) {
  # create a reactive value to store the current df
  values <- reactiveValues()
  
  observe({
    
    if (input$update_table == 1) {
      # isolate is to make sure df is not updated when input changes
      isolate(values$df <- make_DF(input$n_entries))
      
      
    }
    
    if (input$update_table > 1) {
      isolate({
        
        DF_new <- make_DF(input$n_entries)
        values$df <- rbind(values$df, DF_new)
        
      })      
    }    
  })
  
  observeEvent(input$update_table, {
    output$test_output <- renderTable(values$df)
    output$input_data <- renderRHandsontable({rhandsontable(values$df)})
  })
}

shinyApp(ui = ui, server = server)
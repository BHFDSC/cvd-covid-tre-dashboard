ui <-
  fluidPage(titlePanel("example"),
            sidebarLayout(
              
              sidebarPanel(
                numericInput(
                  "criteria_count",
                  label = "How many criteria are being considered? (max = 5)",
                  2,
                  min = 2,
                  max = 5
                ),
                
                textInput("critera_text",
                          label = "Type the different criteria titles, seperated by commas.",
                          value = "Example A, Example B"),
                
                conditionalPanel(condition = "input.criteria_count == 2",
                                 uiOutput("mySelectInput"))
              ),
              
              mainPanel()
              
            ))

server <-
  function(input, output) {
    output$mySelectInput <- renderUI({
      criteria1 <- strsplit(input$critera_text, ", ")[[1]][1]
      criteria2 <- strsplit(input$critera_text, ", ")[[1]][2]
      
      selectInput(
        "main_cri1",
        label = paste0(
          "How much more important is ",
          criteria1,
          " than ",
          criteria2,
          "?"
        ),
        choices = c(
          "9 (Extremely more important)",
          "7 (Much more important)",
          "5 (Moderately more important)",
          "3 (Slightly more important)",
          "1 (Equally as important)",
          "1/3 (Slightly less important)",
          "1/5 (Moderately less important)",
          "1/7 (Much less important)",
          "1/9 (Extremely less important)"
        )
      )
    })
  }

shinyApp(ui = ui, server = server)
library(shiny)

doc = 'test'

# Modules
setUnitUI <- function(id) {
  ns <- NS(id)
  selectInput(ns('unit'), 'unit', c('km', 'mile'))
}

setUnitModule <- function(input, output, session) {
  reactive(input$unit)
}

setValueUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns('dynamicSlider'))
}

setValueModule <- function(input, output, session, unitGetter) {
  output$dynamicSlider <- renderUI({
    ns <- session$ns
    unit <- unitGetter()
    if (unit == 'km') {
      sliderInput(ns('pickValue'), paste('Pick value in', unit), 
                  min=0, max=150, value=0)
    } else {
      sliderInput(ns('pickValue'), paste('Pick value in', unit), 
                  min=0, max=100, value=0)
    }
  })
}


showValueUI <- function(id) {
  ns <- NS(id)
  textOutput(ns('value'))
}

showValueModule <- function(input, output, session, unitGetter, valueGetter) {
  output$value <- renderText(paste('You chose', valueGetter(), unitGetter()))
}





ui <- fluidPage(sidebarLayout(
  sidebarPanel(p(paste(doc, collapse='\n'))),
  mainPanel(setUnitUI('unit'), 
            setValueUI('value'),
            showValueUI('show'))
))


server <- function(input, output, session) {
  unitGetter <- callModule(setUnitModule, 'unit')
  valueGetter <- callModule(setValueModule, 'value', unitGetter)
  callModule(showValueModule, 'show', unitGetter, valueGetter)
}


shinyApp(ui, server, options=list(launch.browser=TRUE))
library(shiny)
library(shinyalert)

mod_match_columns_ui <- function(id){
  ns <- NS(id)
  tagList(
    shinyalert::useShinyalert(),
    actionButton(ns("run"), label = "Start!")
  )
}

mod_match_columns_server <- function(id) {
  moduleServer(id,
               function(input, output, session) {
                 
                 ns <- session$ns
                 
                 options <- list(c("option_1","option_2"),
                                 c("option_3","option_4"))
                 
                 lapply(1:2, function(col){
                   
                   output[[paste0("dropdown",col)]] <- renderUI({
                     shinyWidgets::pickerInput(
                       inputId = ns(paste0("options",col)),
                       label = paste("Options",col,"listed below"),
                       choices = options[[col]],
                       selected = "",
                       multiple = FALSE,
                       options = shinyWidgets::pickerOptions(size = 15)
                     )
                   })
                   
                 })
                 
                 observeEvent(input$run, {
                   
                   shinyalert::shinyalert(
                     title = "Pick an option!",
                     html = TRUE,
                     text = tagList(
                       lapply(1:2, function(i){uiOutput(ns(paste0("dropdown",i)))})
                     )
                     # callbackR = function(x) { message("Hello ", x) },
                     # inputId = ns(paste0("modal"))
                   )
                   
                 })
                 
                 observe({
                   print(input$options1)
                   print(input$options2)
                   print(input$shinyalert)
                 })
                 
               })
}

ui <- fluidPage(
  tagList(
    mod_match_columns_ui("match_columns_ui_1")
  )
)

server <- function(input, output, session) {
  mod_match_columns_server("match_columns_ui_1")
}

shinyApp(ui = ui, server = server)
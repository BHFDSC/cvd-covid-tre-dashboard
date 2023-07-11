getwd()
#adding libraries
library(shiny)
library(ggplot2)
library(dygraphs)
library(tidyverse)
library(lubridate)
library(anytime)
library(plotly)
options(scipen=99999)

#adding datasets
df <- read_csv('analoguous.csv')

#converting to date time
df$date_ym <- anydate(df$date_ym)
df$date_ym <- ymd(df$date_ym)

#app 
ui <- fluidPage(
  titlePanel('Dataset Frequencies'),
  sidebarPanel(
      selectInput('data', "What dataset(s) would you like to view?", 
                        choices = c(unique(df$dataset)), 
                     multiple = FALSE)
  ),
  mainPanel(
    fluidRow(
      column(12, plotlyOutput('timeseries'))
    )
  )
  
)

server <- function(input, output, session){
  filtered <- reactive({df[df$dataset == input$data, ]})
  
  output$timeseries <- renderPlotly({ggplotly((ggplot(filtered(), 
                                         aes(x=date_ym, y=n_id_distinct)) +
    geom_line()))
  })
  
}
shinyApp(ui,server)
#this dashboard works with SNOMED

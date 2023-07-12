getwd()
#adding libraries
library(shiny)
library(ggplot2)
library(dygraphs)
library(tidyverse)
library(lubridate)
library(anytime)
library(plotly)
library(collapsibleTree)
options(scipen=99999)

#adding datasets
df <- read_csv('analoguous.csv')

#converting to date time
df$date_ym <- anydate(df$date_ym)
df$date_ym <- ymd(df$date_ym)

#dataset for dendrogram
General_Information <- separate(df, date_ym, into=c('year', 'month'), sep = '-')

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
    ),
    fluidRow(
      column(12, collapsibleTreeOutput('generalInfo'))
    )
  )
  
)

server <- function(input, output, session){
  filtered <- reactive({df[df$dataset == input$data, ]})
  
  output$timeseries <- renderPlotly({ggplotly(
    ggplot(filtered(), aes(x = date_ym)) + 
      geom_line(aes(y=n), colour = 'lightslateblue') +
      geom_line(aes(y = n_id_distinct), colour = 'tomato') +
      labs(x = 'Date', y='Cases')
  )
    
  })
  output$generalInfo <- renderCollapsibleTree({
    collapsibleTree(General_Information, c('dataset', 'year', 'month', 'n'),
                    tooltip = TRUE, attribute = 'n_id_distinct')
   
  })
  
}
shinyApp(ui,server)
#this dashboard works with SNOMED


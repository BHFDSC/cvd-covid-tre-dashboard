#adding libraries
library(shiny)
library(ggplot2)
library(dygraphs)
library(tidyverse)
library(lubridate)
library(anytime)
library(plotly)
library(collapsibleTree)
library(shinydashboard)
options(scipen=99999)

#adding datasets
df <- read_csv('analoguous.csv')

#converting to date time
df$date_ym <- anydate(df$date_ym)
df$date_ym <- ymd(df$date_ym)

#dataset for dendrogram
General_Information <- separate(df, date_ym, into=c('year', 'month'), sep = '-')

#app 
ui <- dashboardPage(skin = 'black',
                    dashboardHeader(title = 'Medical Datasets'),
                    dashboardSidebar(
                      sidebarMenu(
                        selectInput('data', "What Dataset would you like to view?", 
                                    choices = c(unique(df$dataset)), 
                                    multiple = FALSE)
                      )
                    ),
                    dashboardBody(
                      fluidRow(valueBoxOutput('dataname', width = 4),
                               valueBoxOutput('datayear', width = 4),
                               valueBoxOutput('datasum', width = 4)),
                      fluidRow(
                        box(title = 'Dataset Overview', solidHeader = TRUE, status = 'primary',
                            collapsibleTreeOutput('generalInfo', height = 300)),
                        box(title = 'Dataset Timeseries', solidHeader = TRUE, status = 'primary',
                            plotlyOutput('timeseries', height = 300)))
                    )
)

server <- function(input, output, session){
  session$allowReconnect(TRUE)
  filtered <- reactive({df[df$dataset == input$data, ]})
  output$dataname <- renderValueBox({valueBox(subtitle = "Dataset", value = input$data,icon=icon('chart-simple'),
                                              color='light-blue')})
  output$datayear <- renderValueBox({
    dataset <- filtered()
    years <- range(year(dataset$date_ym))
    valueBox(subtitle = "Years included", value = paste0(years[1], " - ", years[2]), icon = icon('calendar'), color = 'light-blue')
  })
  
  output$datasum <- renderValueBox({
    valueBox(subtitle = 'Dataset with the most Distinct Cases', value = df %>% group_by(dataset) %>% summarise(data_sum = sum(n_id_distinct)) %>% 
               filter(data_sum == max(data_sum)) %>% select(-data_sum), icon = icon('gauge-high'), color = 'navy')})
  
  output$generalInfo <- renderCollapsibleTree({
    collapsibleTree(General_Information, c('dataset', 'year', 'month', 'n'),
                    tooltip = TRUE, attribute = 'n_id_distinct')
    
  })
  
  output$timeseries <- renderPlotly({ggplotly(
    ggplot(filtered(), aes(x = date_ym)) + 
      geom_line(aes(y=n), colour = 'lightslateblue', alpha = 0.7) +
      geom_line(aes(y = n_id_distinct), colour = 'tomato', alpha = 0.7) +
      labs(x = 'Date', y='Cases')
  )
    
  })
  
}
shinyApp(ui,server)
#this dashboard works with SNOMED


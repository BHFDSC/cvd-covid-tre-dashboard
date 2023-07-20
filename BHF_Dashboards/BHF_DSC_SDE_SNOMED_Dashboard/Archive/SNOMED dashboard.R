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
ui <-
dashboardPage(skin = 'blue',
                    dashboardHeader(title = tags$div(
                      tags$a(
                        href = 'https://www.hdruk.ac.uk/helping-with-health-data/bhf-data-science-centre/',
                        tags$img(src = "logo.jpg", style = 'height: 30px; width: auto;'),
                        style = 'display: inline-block; vertical-align: middle;'
                      ),
                      tags$span('Medical Datasets', style = 'display: inline-block; margin-left: 10px; vertical-align: middle;')
                    ), 
                                    titleWidth = 300,
                                    tags$li(class = 'dropdown',
                                            tags$a(
                                              href = 'https://forms.gle/deVEvdWHVD6JKXJ89',
                                              icon('envelope'),
                                              'Feedback or Suggestions?'
                                            )
                                    )),
                    dashboardSidebar(sidebarMenu(id = 'sidebar',
                      menuItem('Overview', tabName = 'page1'),
                      menuItem('Dashboard', tabName = 'page2')
                    )
                                     
                      
                                    
                      
                    ),
                    dashboardBody(tags$head(tags$link(rel = 'stylesheet', 
                                                      type = 'text/css', 
                                                      href='custom.css')),
                                  tabItems(
                                    tabItem(tabName = 'page1',
                                            fluidRow(
                                              column(width = 12, box(height = 200, width = 600)),
                                            fluidRow(
                                              column(width = 6,
                                              box(title = "Overview", height = 250, 
                                                         width = 300,
                                      textOutput('overviewtext')
                                      )),
                                      column(width = 6, 
                                             box(title = "SNOMED CT", 
                                                 height = 250, width = 300, 
                                                 textOutput('snomed'),tags$head(
                                                   tags$style(HTML(
                                                     '#nextbtn{background-color:grey; color:white} 
                                                     #nextbtn:hover{background-color: maroon; color:white}'))),
                                                 actionButton('nextbtn', 'Click to view the dashboard!', 
                                                                                    icon('paper-plane'))))
                                      
                                    
                                    ))),
                                    tabItem(tabName = 'page2', 
                                            selectInput('data', "What Dataset would you like to view?", 
                                                        choices = c(unique(df$dataset)), 
                                                        multiple = FALSE),
                                      fluidRow(valueBoxOutput('dataname', width = 4),
                                               valueBoxOutput('datayear', width = 4),
                                               valueBoxOutput('datasum', width = 4)),
                                      fluidRow(tags$style(HTML('.box.box-solid.box-danger>.box-header{color:whitestone; background: maroon}')),
                                        box(title = 'Data View: Dataset, Year, Month, Distinct Cases', 
                                            solidHeader = TRUE, status='danger',
                                            collapsibleTreeOutput('generalInfo', height = 300)),
                                        box(title = 'Data Coverage', solidHeader = TRUE, status = 'danger',
                                            plotlyOutput('timeseries', height = 300)))
                                    )
                                  )
                      
                    )
)

server <- function(input, output, session){
  session$allowReconnect(TRUE)
  filtered <- reactive({df[df$dataset == input$data, ]})
  
  output$overviewtext <- renderText({'Welcome to this interactive Dashboard! 
  The Dashboard provides information on certain groups of patients, 
  each identified by a dataset and time period.
    This dashboard aims to provide researchers with an
    overview of the data available for research as well as cutting down 
    on time spent performing exploratory data analysis (EDA).'})
  
  output$snomed <- renderText({'SNOMED CT stands for Systemised Nomencleture 
  of Medicine - Clinical Terms. That is, 
  it is a system used to standardise the description of clinical terms
    in Hospitals and GP practices.'})
  
  observeEvent(input$nextbtn, {
    updateTabItems(session, "sidebar", "page2")
  })
  
  output$dataname <- renderValueBox({valueBox(subtitle = "Dataset", value = input$data,icon=icon('chart-simple'),
                                              color='light-blue')})
  output$datayear <- renderValueBox({
    dataset <- filtered()
    years <- range(year(dataset$date_ym))
    valueBox(subtitle = "Years included", value = paste0(years[1], " - ", years[2]), icon = icon('calendar'), color = 'light-blue')
  })
  
  output$datasum <- renderValueBox({
    valueBox(subtitle = 'Dataset with the most Distinct Cases', value = df %>% group_by(dataset) %>% summarise(data_sum = sum(n_id_distinct)) %>% 
               filter(data_sum == max(data_sum)) %>% select(-data_sum), icon = icon('gauge-high'), color = 'black')})
  
  output$generalInfo <- renderCollapsibleTree({
    collapsibleTree(General_Information, c('dataset', 'year', 'month', 'n'),
                    tooltip = TRUE, attribute = 'n_id_distinct')
    
  })
  
  output$timeseries <- renderPlotly({ggplotly(
    ggplot(filtered(), aes(x = date_ym)) + 
      geom_line(aes(y=n), colour = 'lightslateblue', alpha = 0.7) +
      #geom_line(aes(y = n_id_distinct), colour = 'tomato', alpha = 0.7) +
      labs(x = 'Date', y='Cases')
  ) %>% layout(plot_bgcolor = "white",
               paper_bgcolor = "white")
    
  })
  
}
shinyApp(ui,server)
#this dashboard works with SNOMED
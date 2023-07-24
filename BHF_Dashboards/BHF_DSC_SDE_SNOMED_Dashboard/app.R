library(tidyverse)
library(shiny)
library(ggplot2)
library(dygraphs)
library(lubridate)
library(anytime)
library(plotly)
library(collapsibleTree)
library(shinydashboard)
library(readxl)
library(reactable)
options(scipen=99999)

df <- read_csv("table2.csv")
`Cluster Descriptions` <- read_csv("table1.csv")
dict <- read_excel('data dictionary.xlsx')

sum(is.na(df))
head(df)
sum(is.na(df$ConceptId_2))
df$date_ym <- anydate(df$date_ym)
df$date_ym <- ymd(df$date_ym)
df <- replace(df, is.na(df), 0)


#add comma to numeric columns for cluster and timeseries
`Cluster Descriptions`$n <- format(`Cluster Descriptions`$n, big.mark = ",")
#separate into month and year for dendro
`Data Tree` <- separate(df, date_ym, into=c('year', 'month'), sep = '-')
#remove all \
`Data Tree`$ConceptId_Description_2 <- gsub("\\([^\\)]+\\)|\\[[^\\]]+\\]", "", `Data Tree`$ConceptId_Description_2)
#remove all :
`Data Tree`$ConceptId_Description_2 <- sub(".*:", "", `Data Tree`$ConceptId_Description_2)
#convert ID to cluster
`Data Tree`$Cluster_ID <- as.factor(`Data Tree`$Cluster_ID)


ui <- dashboardPage(
  dashboardHeader(tags$li(class = 'dropdown', tags$style('.main-header{max-height: 200px}'))),
  dashboardSidebar(width = 200, sidebarMenu(id = 'sidebar', menuItem('Introduction', tabName = 'page1'), menuItem('Dashboard', tabName = 'page2'))),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = 'page1',
        fluidRow(
          column(width = 12, box(title = 'picture', height = 200, width = 600))
        ),
        fluidRow(
          column(width = 6, box(title = 'Overview', height = 250, width = 300, textOutput('overviewtext'))),
          column(width = 6, box(title = 'SNOMED/GDPPR', height = 250, width = 300, textOutput('snomed'))),
          column(
            width = 12,
            class = 'table-output-column',
            box(title = 'Data Dictionary', DT::dataTableOutput('dictionary'), width = 600)
          )
        ),
        fluidRow(
          column(
            width = 12,
            align = 'right',
            actionButton('nextbtn', 'Click to view the dashboard!', icon('paper-plane'))
          )
        )
      ),
      tabItem(
        tabName = 'page2',
        tabBox(width = 12,id = 'tabbox', title = 'Data Overview',
               tabPanel(title = 'Clusters', 
                        collapsibleTreeOutput('cluster')),
               tabPanel(title = 'Distinct Data', 
                        collapsibleTreeOutput('tree'))
        ),
        fluidRow(column(width = 12, box(width = 600,
                                        selectInput('data', "What Cluster would you like to view?", 
                                                    choices = c(unique(`Cluster Descriptions`$Cluster_Desc)), 
                                                    multiple = FALSE)))),
        fluidRow(valueBoxOutput('clustername', width = 6),
                 valueBoxOutput('clustern', width = 6), 
                 valueBoxOutput('clusterdesc', width = 12)
        ),
        fluidRow(column(width = 12, box(title = 'Graph Resizer', width = 200, 
                                        actionButton('resize', 'Click to view cases above 1000', width = '200px'),
                                       actionButton('reset', 'Click to Reset Plot')))),
        
                 fluidRow(column(width = 12, box(width = 500, title = 'Timeseries', 
                                       solidHeader = TRUE, status = 'danger',
                                       plotlyOutput('timeseries', height = 300))))
      )
    )
  )
)

server <- function(input, output, session) {
  session$allowReconnect(TRUE)
  filtered <- reactive({`Cluster Descriptions`[`Cluster Descriptions`$Cluster_Desc == input$data, ]})
  
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
  
  
  output$dictionary <- DT::renderDataTable(dict, options = list(pageLength = 5))
  
  output$tree <- renderCollapsibleTree({
    collapsibleTree(`Data Tree`, c('Cluster_ID', 'year', 'month', 'ConceptId_Description_2'), 
                    tooltip = TRUE, attribute = 'n')
  })
  
  output$cluster <- renderCollapsibleTree({
    collapsibleTree(`Cluster Descriptions`, 
                    c('Cluster_Category', 'Cluster_Desc', 'Cluster_ID'), 
                    tooltip = TRUE, attribute = 'n_code')
  })
  
  
  output$clustername <- renderValueBox({
    value <- filtered()$Cluster_ID
    valueBox(subtitle = "Cluster ID", value = value)
  })
  
  output$clusterdesc <- renderValueBox({
    valueBox(subtitle = "Cluster Category", value = filtered()$Cluster_Category)})
  
  
  output$clustern <- renderValueBox({
    value <- filtered()$n
    valueBox(subtitle = "Records in GDPPR", value = value)
  })
  
  filtered_data <- reactiveVal()
  
  observeEvent(input$resize, {
    filtered_data(df[df$Cluster_ID %in% filtered() & df$n > 1000, ])
  })
  
  observeEvent(input$reset, {
    filtered_data(NULL)
  })
  
  output$timeseries <- renderPlotly({
    filtered_plot_data <- df[df$Cluster_ID %in% filtered(), ]
    
    if (is.null(filtered_data())) {
      plot_data <- filtered_plot_data
    } else {
      plot_data <- filtered_data()
    }
    
    ggplotly(
      ggplot(plot_data, aes(x = date_ym, colour = ConceptId_Description_2)) + 
        geom_area(aes(y = n)) +
        geom_line(aes(y=n), alpha = 0.7) +
        labs(x = 'Date', y='Cases') + scale_y_continuous(labels = scales::comma)
    ) %>% layout(plot_bgcolor = "white",
                 paper_bgcolor = "white")
    
  })
  
  
  
  
}

shinyApp(ui, server)



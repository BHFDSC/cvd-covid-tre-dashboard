library(tidyverse)
library(shiny)
library(ggplot2)
library(dygraphs)
library(lubridate)
library(anytime)
library(plotly)
library(collapsibleTree)
library(shinydashboard)
library(shinyalert)
library(readxl)
library(reactable)
library(viridis)
library(shinycssloaders)
options(scipen=99999)

df2 <- read_csv('full_df.csv')
dict <- read_excel('data dictionary.xlsx')

sum(is.na(df2$ConceptId_2 ))
df2$date_ym <- anydate(df2$date_ym)
df2$date_ym <- ydm(df2$date_ym)
df2 <- replace(df2, is.na(df2), 0)


#separate into month and year for dendrogram
`Data Tree` <- separate(df2, date_ym, into=c('year', 'month'), sep = '-')
#remove all \
`Data Tree`$ConceptId_Description_2 <- gsub("\\([^\\)]+\\)|\\[[^\\]]+\\]", "", `Data Tree`$ConceptId_Description_2)
#remove all :
`Data Tree`$ConceptId_Description_2 <- sub(".*:", "", `Data Tree`$ConceptId_Description_2)
#convert ID to cluster
`Data Tree`$Cluster_ID <- as.factor(`Data Tree`$Cluster_ID)

#add comma to numeric columns for cluster and timeseries
df2$records_total <- format(df2$records_total, big.mark = ",")
df2$individuals <- format(df2$individuals, big.mark = ",")

category <- read_csv('second_import.csv')
category$date_ym <- anydate(category$date_ym)
category$date_ym <- ymd(category$date_ym)


ui <- dashboardPage(
  dashboardHeader(title = "SNOMED Codes and Clusters in GDPPR", #HTML("<a href='https://digital.nhs.uk/coronavirus/gpes-data-for-pandemic-planning-and-research/guide-for-analysts-and-users-of-the-data'></a>"),
                  titleWidth = 450,
    tags$li(class = 'dropdown', tags$style('.main-header{max-height: 200px}')),
                  tags$li(class = 'dropdown',
                          tags$a(
                            href = 'https://forms.gle/deVEvdWHVD6JKXJ89',
                            icon('envelope'),
                            'Feedback or Suggestions?'
                          )
                  )),
  dashboardSidebar(width = 180, sidebarMenu(id = 'sidebar', menuItem('Introduction', tabName = 'page1'), menuItem('Dashboard', tabName = 'page2'))),
  dashboardBody(tags$head(tags$link(rel = 'stylesheet', 
                                    type = 'text/css', 
                                    href='custom.css')),
    tabItems(
      tabItem(
        tabName = 'page1',
        fluidRow(
          #column(width = 12, 
          imageOutput("pic", height = "auto", width = "auto")
        ),
        div(style = "margin-top: 20px;"),
        fluidRow(
          column(width = 12, box(title = 'Overview', height = 200, width = 300, textOutput('overviewtext'))),
          #column(width = 6, box(title = 'SNOMED/GDPPR', height = 250, width = 300, textOutput('snomed'))),
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
            tags$head(
              tags$style(HTML(
                '#nextbtn{background-color:grey; color:white} 
                                                     #nextbtn:hover{background-color: maroon; color:white}'))),
            actionButton('nextbtn', 'Click to view the dashboard!', icon('paper-plane'))
          )
        )
      ),
      tabItem(
        tabName = 'page2',
        tabBox(width = 12,id = 'tabbox', title = 'Data Overview',
               tabPanel(title = 'Concepts', 
                        collapsibleTreeOutput('cluster')%>% withSpinner(color="maroon")),
               # tabPanel(title = 'Cluster Codes', 
               #          collapsibleTreeOutput('tree')),
               tabPanel(title = 'Data Coverage',
                        selectInput('clusterchoice', 'Pick a Category to view its Coverage Period', 
                                    choices = c(unique(category$Cluster_category)), multiple = F),
                        uiOutput('daterange'),
                        plotlyOutput('clusterplot', height = 300)%>% withSpinner(color="maroon"))
        ),
        fluidRow(column(width = 12, box(width = 600,
                                        selectInput('data', "Pick a Cluster to Visualise", 
                                                    choices = c(unique(df2$Cluster_Desc)), 
                                                    multiple = FALSE),
                                        checkboxInput('compare', 'Would you like to compare it?', F),
                                        conditionalPanel(condition = 'input.compare',
                                                         selectInput('otherdata', 'Pick a plot to Compare',
                                                                     choices = c(unique(df2$Cluster_Desc)),
                                                                     multiple = F))))),
        fluidRow(valueBoxOutput('clustername', width = 4),
                 valueBoxOutput('clustern', width = 4),
                 valueBoxOutput('individuals', width = 4),
                 valueBoxOutput('clusterdesc', width = 12),
                 valueBoxOutput('clustercat', width = 12)
                 
        ),
        fluidRow(column(width = 12, box(title = 'Graph Toolkit', width = 200,
                                        fluidRow(
                                          column(width = 4,
                                                 actionButton('resize', 'Click to view cases above 1000', width = '100%'),
                                                 tags$head(
                                                   tags$style(HTML(
                                                     '#resize{background-color:grey; color:white} 
                                                     #resize:hover{background-color: maroon; color:white}')))
                                          ),
                                          column(width = 4,
                                                 actionButton('reset', 'Click to Reset Plot', width = '100%'),
                                                 tags$head(
                                                   tags$style(HTML(
                                                     '#reset{background-color:grey; color:white} 
                                                     #reset:hover{background-color: maroon; color:white}')))
                                          ),
                                          column(width = 4,
                                                 actionButton('earlydates', 'Click to View percentage before 1990', width = '100%'),
                                                 tags$head(
                                                   tags$style(HTML(
                                                     '#earlydates{background-color:grey; color:white} 
                                                     #earlydates:hover{background-color: maroon; color:white}')))
                                          )
                                        ),
                                        style = "margin-bottom: 20px;"  # Adjust the margin to create spacing
                                        # actionButton('resize', 'Click to view cases above 1000', width = '200px'),
                                        # actionButton('reset', 'Click to Reset Plot', width = '200px'),
                                        # actionButton('earlydates', 'Click to View percentage before 1990', width = '400px'),
                                        # checkboxInput('log',"Tick to view Log Scale", F)
        ))),
        
        fluidRow(column(width = 12, box(width = 500, title = 'Cluster Timeseries', 
                                        solidHeader = TRUE, #status = 'success',
                                        plotlyOutput('timeseries', height = 300)%>% withSpinner(color="maroon"),
                                        conditionalPanel(condition = 'input.compare',
                                                         plotlyOutput('timeseriestwo', height = 300)),
                                        conditionalPanel(condition = 'input.log', 
                                                         plotlyOutput('timeseriesthree', height = 300)))))
      )
    )
  )
)

server <- function(input, output, session) {
  session$allowReconnect(TRUE)
  filtered <- reactive({df2[df2$Cluster_Desc == input$data, ]})
  filteredtwo <- reactive({df2[df2$Cluster_Desc == input$otherdata, ]})
  filteredval <- reactive({df2[df2$Cluster_Desc == input$data, ][1, ]})
  clusterfilter <- reactive({category[category$Cluster_category == input$clusterchoice, ]})
  
  
  output$pic <- renderImage({
    return(list(src = "www/Heart_data_title_slide.jpg", contentType = "image/jpeg", width = "100%", height = 470))
  }, deleteFile = FALSE) #where the src is wherever you have the picture
  
  
  output$overviewtext <- renderText({'Welcome to the interactive GDPPR SNOMED dashboard. 
   provides an overview of the dataset for analysts and other users of the 
   General Practice Extraction Service (GPES) Data for Pandemic Planning and Research (GDPPR)
   that will provide information for coronavirus (COVID-19) planning and research.
  This Dashboard provides information on certain groups of patients, 
  each identified by a dataset and time period.
    This dashboard aims to provide researchers with an
    overview of the data available for research as well as cutting down 
    on time spent performing exploratory data analysis (EDA).
    SNOMED CT stands for Systemised Nomencleture 
  of Medicine - Clinical Terms. That is, 
  it is a system used to standardise the description of clinical terms
    in Hospitals and GP practices.'
  })
  
  
  output$snomed <- renderText({'SNOMED CT stands for Systemised Nomencleture
  of Medicine - Clinical Terms. That is,
  it is a system used to standardise the description of clinical terms
    in Hospitals and GP practices.'})
  
  observeEvent(input$nextbtn, {
    updateTabItems(session, "sidebar", "page2")
  })
  
  
  
  output$dictionary <- DT::renderDataTable(dict, options = list(pageLength = 5))
  
  # output$tree <- renderCollapsibleTree({
  #   collapsibleTree(`Data Tree`, c('Cluster_ID', 'year', 'month', 'ConceptId_Description_2'),
  #                   tooltip = TRUE, attribute = 'records_total')
  # })
  
  output$cluster <- renderCollapsibleTree({Sys.sleep(1)
    collapsibleTree(df2, root = 'SNOMED CT', linkLength = 200,
                    c('Cluster_Category', 'Cluster_Desc', 'ConceptId_Description_2')
                    )
  })
  
  output$daterange <- renderUI({
    sliderInput('date', 'Pick a date range to view', min= min(clusterfilter()$date_ym), 
                max = max(clusterfilter()$date_ym), 
                value = c(min= min(clusterfilter()$date_ym), max = max(clusterfilter()$date_ym)))
  })
  
  observeEvent(input$date, {
    updateSliderInput(session, 'date', value = input$date)
  })

  
  output$clusterplot <- renderPlotly({Sys.sleep(1)
    req(input$date)
    ggplotly(
      ggplot(clusterfilter(), aes(x = date_ym)) +
        geom_line(aes(y = records_month, colour = 'Records Month'), alpha = 0.7, show.legend = TRUE) +
        geom_line(aes(y = valid_idmonth, colour = 'Valid Id'), alpha = 0.7, show.legend = TRUE) +
        geom_line(aes(y = distinct_id, colour = 'Distinct Id'), alpha = 0.7, show.legend = TRUE) +
        labs(x = 'Date', y = 'Cases', colour = 'Key') +
        scale_y_continuous(labels = scales::comma) +
        scale_x_date(limits = c(input$date[1], input$date[2])) +
        scale_color_manual(values = c('Records Month' = '#440154',
                                      'Valid Id' = '#31688E',
                                      'Distinct Id' = '#6DCD59')) +
        theme_minimal()+
        theme(legend.position = 'right') 
    ) %>% layout(plot_bgcolor = "white", paper_bgcolor = "white")
  })
  
  
  output$clustername <- renderValueBox({
    value <- filteredval()$Cluster_ID
    valueBox(subtitle = "Cluster ID", value = value)
  })
  
  output$clustercat <- renderValueBox({
    valueBox(subtitle = "Cluster Category", value = filteredval()$Cluster_Category)})
  
  
  output$clustern <- renderValueBox({
    value <- filteredval()$records_total
    valueBox(subtitle = "Records in GDPPR", value = value)
  })
  
  output$individuals <- renderValueBox({
    value <- filteredval()$individuals
    valueBox(subtitle = "Distinct Individuals", value = value)
  })
  
  output$clusterdesc <- renderValueBox({
    valueBox(subtitle = "Cluster Description", value = filteredval()$Cluster_Desc)})
  
  observeEvent(input$earlydates, {shinyalert(text = filteredval()$pre_1990_n_pct,
                                             animation = T, type = 'info')})
  
  filtered_data <- reactiveVal()
  filtered_datatwo <- reactiveVal()
  
  
  observeEvent(input$resize, {
    filtered_data(filtered()[filtered()$records_month > 1000, ]) #(df2[df2$Cluster_ID %in% filtered() & df2$records_month > 1000, ])
    filtered_datatwo(filteredtwo()[filteredtwo()$records_month > 1000, ])
  })
  
  
  observeEvent(input$reset, {
    filtered_data(NULL)
    filtered_datatwo(NULL)
  })
  
  observeEvent(input$data, {
    filtered_data(NULL)
  })
  
  
  
  output$timeseries <- renderPlotly({Sys.sleep(1)
    filtered_plot_data <- filtered() #df2[df2$Cluster_ID %in% filtered(), ]
    filtered_plot_datatwo <- filteredtwo()

    if (is.null(filtered_data())) {
      plot_data <- filtered_plot_data
    } else {
      plot_data <- filtered_data()
    }
    
    
    ggplotly(
      ggplot(plot_data, aes(x = date_ym, fill = ConceptId_Description_2)) +
        geom_area(aes(y = records_month, fill = ConceptId_Description_2)) +
        #geom_line(aes(y=n), alpha = 0.7) +
        labs(x = 'Date', y='Cases') +
        scale_y_continuous(labels = scales::comma) +
        scale_fill_viridis_d() +
        theme_minimal()+
        #scale_y_log10(labels = scales::comma) +
        theme(legend.position = 'none'), tooltip = 'fill'
    ) %>% layout(plot_bgcolor = "white",
                 paper_bgcolor = "white")
    
    
    
    # if(input$compare){
    # combined_data <- rbind(filtered_plot_data, filtered_plot_datatwo)
    # 
    #   ggplotly(
    #     ggplot(combined_data, aes(x = date_ym, fill = ConceptId_Description_2)) +
    #       geom_area(aes(y = records_month)) +
    #       facet_grid(Cluster_Desc ~ .) +
    #       labs(x = 'Date', y = 'Cases') +
    #       scale_y_continuous(labels = scales::comma) +
    #       scale_fill_viridis_d() +
    #       theme_minimal() +
    #       theme(legend.position = 'none'), tooltip = 'fill'
    #   ) %>% layout(plot_bgcolor = "white", paper_bgcolor = "white")}


    
  })
  
  output$timeseriestwo <- renderPlotly({
    req(input$compare)
    filtered_plot_datatwo <- filteredtwo() #df[df$Cluster_ID %in% filteredtwo(), ]

    if (is.null(filtered_datatwo())) {
      plot_data <- filtered_plot_datatwo
    } else {
      plot_data <- filtered_datatwo()
    }

    ggplotly(
      ggplot(plot_data, aes(x = date_ym, fill = ConceptId_Description_2)) +
        geom_area(aes(y = records_month, fill = ConceptId_Description_2)) +
        #geom_line(aes(y=n), alpha = 0.7) +
        labs(x = 'Date', y='Cases') +
        scale_y_continuous(labels = scales::comma) +
        scale_fill_viridis_d() +
        theme_minimal()+
        #scale_y_log10(labels = scales::comma) +
        theme(legend.position = 'none'), tooltip = 'fill'
    ) %>% layout(plot_bgcolor = "white",
                 paper_bgcolor = "white")

  })


  # output$timeseriesthree <- renderPlotly({
  #   req(input$log)
  #   filtered_plot_datatwo <- filteredtwo() #df[df$Cluster_ID %in% filteredtwo(), ]
  #   
  #   if (is.null(filtered_datatwo())) {
  #     plot_data <- filtered_plot_datatwo
  #   } else {
  #     plot_data <- filtered_datatwo()
  #   }
  #   
  #   ggplotly(
  #     ggplot(plot_data, aes(x = date_ym, colour = ConceptId_Description_2)) + 
  #       #geom_area(aes(y = n, fill = ConceptId_Description_2)) +
  #       geom_line(aes(y=records_month), alpha = 0.7) +
  #       labs(x = 'Date', y='Cases') + 
  #       #scale_y_continuous(labels = scales::comma) +
  #       scale_fill_viridis_d() +
  #       scale_y_log10(labels = scales::comma) +
  #       theme_minimal()+
  #       theme(legend.position = 'none'), tooltip = 'colour'
  #   ) %>% layout(plot_bgcolor = "white",
  #                paper_bgcolor = "white")
  #   
  # })
  # 
  
}

shinyApp(ui, server)




# output$facet_plot <- renderPlotly({
#   req(input$compare)
#   filtered_plot_data <- filtered()
#   filtered_plot_datatwo <- filteredtwo()
#   
#   combined_data <- rbind(filtered_plot_data, filtered_plot_datatwo)
#   
#   ggplotly(
#     ggplot(combined_data, aes(x = date_ym, fill = ConceptId_Description_2)) +
#       geom_area(aes(y = records_month)) +
#       facet_grid(. ~ Cluster_Desc) +
#       labs(x = 'Date', y = 'Cases') +
#       scale_y_continuous(labels = scales::comma) +
#       scale_fill_viridis_d() +
#       theme_minimal() +
#       theme(legend.position = 'none'), tooltip = 'fill'
#   ) %>% layout(plot_bgcolor = "white", paper_bgcolor = "white")
# })






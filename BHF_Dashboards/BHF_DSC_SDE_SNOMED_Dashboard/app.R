#importing libraries
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
library(scales)
library(NestedMenu)
library(shinycssloaders)
options(scipen=99999)

#reading in datasets 
df2 <- read_csv('full_df.csv')
dict <- read_excel('data dictionary.xlsx')

#formatting date, replacing 0
sum(is.na(df2$ConceptId_2 ))
df2$date_ym <- anydate(df2$date_ym)
df2$date_ym <- ydm(df2$date_ym)
df2 <- replace(df2, is.na(df2), 0)


#separate data into month and year for dendrogram
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

#reading in cluster category data
category <- read_csv('second_import.csv')
category$date_ym <- anydate(category$date_ym)
category$date_ym <- ymd(category$date_ym)

#dashboard header
header <- dashboardHeader(
                            title = div(
    a(href = 'https://www.hdruk.ac.uk/helping-with-health-data/bhf-data-science-centre/',
      HTML('<img src="headerlogo.png" alt="Logo" height="30" style="vertical-align: left;">')
    ),
    "SNOMED Codes and Clusters in GDPPR"
  ),
                  titleWidth = 600,
    tags$li(class = 'dropdown', tags$style('.main-header{max-height: 200px}')),
                  tags$li(class = 'dropdown',
                          tags$a(
                            href = 'https://forms.gle/deVEvdWHVD6JKXJ89',
                            icon('envelope'),
                            'Feedback or Suggestions?'
                          )
                          
                  ))
  
#dashboard sidebar
sidebar <- dashboardSidebar(collapsed = T, width = 180, sidebarMenu(id = 'sidebar', 
                                            menuItem('Introduction', tabName = 'page1'), 
                                            menuItem('Dashboard', tabName = 'page2')))
#dashboard body
body <- dashboardBody(tags$head(tags$link(rel = 'stylesheet', 
                                    type = 'text/css', 
                                    href='custom.css')),
    tabItems(
      tabItem(
        tabName = 'page1',
        fluidRow(
          imageOutput("pic", height = "auto", width = "auto")
        ),
        div(style = "margin-top: 20px;"),
        fluidRow(
          column(width = 12, box(title = 'Overview', height = 280, width = 300, htmlOutput('overviewtext'))),
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
                                                     #nextbtn:hover{background-color: navy; color:white}'))),
            actionButton('nextbtn', 'Click to view the dashboard!', icon('paper-plane'))
          )
        )
      ),
      tabItem(
        tabName = 'page2',
        tabBox(width = 12,id = 'tabbox', title = 'Data Overview',
               tabPanel(title = 'Concepts', actionButton(inputId = 'conceptinfo', label = icon('info')
                                                         ), tags$head(
                                                           tags$style(HTML(
                                                             '#conceptinfo{background-color:grey; color:white} 
                                                     #conceptinfo:hover{background-color: navy; color:white}'))), 
                        collapsibleTreeOutput('cluster')%>% withSpinner(color="navy")),
               tabPanel(title = 'Data Coverage',
                        selectInput('clusterchoice', 'Pick a Category to view its Coverage Period', 
                                    choices = c(unique(category$Cluster_category)), multiple = F),
                        uiOutput('daterange'),
                        plotlyOutput('clusterplot', height = 300)%>% withSpinner(color="navy"))
        ),
        fluidRow(column(width = 12, box(width = 600,
                                        
                                        selectInput('data', "Pick a Category to Visualise",
                                                    choices = c(unique(df2$Cluster_Category)),
                                                    multiple = FALSE),
                                        selectInput('datatwo', "Pick a Cluster to Visualise",
                                                    choices = c(unique(df2$Cluster_Desc)),
                                                    multiple = FALSE),
                                        checkboxInput('compare', 'Would you like to compare it?', F),
                                        conditionalPanel(condition = 'input.compare',
                                                         selectInput('otherdata', 'Pick a Category to Compare',
                                                                     choices = c(unique(df2$Cluster_Category)),
                                                                     multiple = F),
                                                         selectInput('otherdatatwo', 'Pick a Cluster to Compare',
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
                                                     #resize:hover{background-color: navy; color:white}
                                                     #resize.disabled-button {background-color: lightgrey;
                                                     color: darkgrey;
                                                     cursor: not-allowed;}
                                                     #resize[disabled] { opacity:0.4; cursor : not-allowed !important; }
                                                     #resize.disabled-button:hover {
                                                     background-color: lightgrey;}')))
                                          ),
                                          column(width = 4,
                                                 actionButton('reset', 'Click to Reset Plot', width = '100%'),
                                                 tags$head(
                                                   tags$style(HTML(
                                                     '#reset{background-color:grey; color:white} 
                                                     #reset:hover{background-color: navy; color:white}
                                                     
                                                     ')))
                                          ),
                                          column(width = 4,
                                                 actionButton('earlydates', 'Click to View percentage before 1990', width = '100%'),
                                                 tags$head(
                                                   tags$style(HTML(
                                                     '#earlydates{background-color:grey; color:white} 
                                                     #earlydates:hover{background-color: navy; color:white}')))
                                          ),
                                          
                                        style = "margin-bottom: 20px;"  # Adjust the margin to create spacing
                                        
        ))),
        
        fluidRow(column(width = 12, box(width = 500, title = 'Cluster Timeseries', 
                                        solidHeader = TRUE,
                                        actionButton(inputId = 'timeseriesinfo', label = icon('info')
                                        ),checkboxInput("showLegend", "Show Legend", value = TRUE), tags$head(
                                          tags$style(HTML(
                                            '#timeseriesinfo{background-color:grey; color:white} 
                                                     #timeseriesinfo:hover{background-color: navy; color:white}'))),
                                        plotlyOutput('timeseries', height = 500)%>% withSpinner(color="navy"),
                                        conditionalPanel(condition = 'input.compare')
                                        ))),
        fluidRow(
          column(
            width = 12,
            align = 'right',
            tags$head(
              tags$style(HTML(
                '#backbtn{background-color:grey; color:white} 
                                                     #backbtn:hover{background-color: navy; color:white}'))),
            actionButton('backbtn', 'Back', icon('backward'))
          )
        )
      )
    )
  ))
#ui
ui <- dashboardPage(header, sidebar, body)


#server
server <- function(input, output, session) {
  observeEvent(input$data, {
    selected_category <- input$data
    if (!is.null(selected_category)) {
      updateSelectInput(session, "datatwo",
                        label = "Pick a Cluster to Visualise",
                        choices = unique(df2$Cluster_Desc[df2$Cluster_Category == selected_category]))
    } else {
      updateSelectInput(session, "datatwo",
                        label = "Pick a Cluster to Visualise",
                        choices = NULL)
    }
  })
  
  observeEvent(input$otherdata, {
    selected_categorytwo <- input$otherdata
    if (!is.null(selected_categorytwo)) {
      updateSelectInput(session, "otherdatatwo",
                        label = "Pick a Cluster to Compare",
                        choices = unique(df2$Cluster_Desc[df2$Cluster_Category == selected_categorytwo]))
                        
    } else {
      updateSelectInput(session, "otherdatatwo",
                        label = "Pick a Cluster to Compare",
                        choices = NULL)
    }
  })
  
  session$allowReconnect(TRUE)
  filtered <- reactive({df2[df2$Cluster_Desc == input$datatwo, ]})
  filteredtwo <- reactive({df2[df2$Cluster_Desc == input$otherdatatwo, ]})
  filteredval <- reactive({df2[df2$Cluster_Desc == input$datatwo, ][1, ]})
  clusterfilter <- reactive({category[category$Cluster_category == input$clusterchoice, ]})
  
  #cover picture
  output$pic <- renderImage({
    return(list(src = "www/Heart_data_title_slide.jpg", contentType = "image/jpeg", width = "100%", height = 470))
  }, deleteFile = FALSE) #where the src is wherever you have the picture
  
  #Overview
  output$overviewtext <- renderUI({HTML(paste(
  p("Welcome to the interactive GDPPR SNOMED dashboard!"), 
   p("This provides an overview of the dataset for analysts and other users of the 
   General Practice Extraction Service (GPES) Data for Pandemic Planning and Research (GDPPR)
   that will provide information for coronavirus (COVID-19) planning and research
    This Dashboard provides information on certain groups of patients, 
      each identified by a Cluster Category and time period.
      This dashboard aims to provide researchers with an
      overview of the data available for research as well as cutting down 
      on time spent performing exploratory data analysis (EDA).
      SNOMED CT stands for Systemised Nomenclature 
      of Medicine - Clinical Terms. That is, 
      it is a system used to standardise the description of clinical terms
      in Hospitals and GP practices."),
  p(tags$a(href = 'https://digital.nhs.uk/coronavirus/gpes-data-for-pandemic-planning-and-research/guide-for-analysts-and-users-of-the-data',
           "For more information about GDPPR, please click here",
           style = "color: navy;"))))
    })
  
  
  
  
  
  #page navigation
  observeEvent(input$nextbtn, {
    updateTabItems(session, "sidebar", "page2")
  })
  
  observeEvent(input$backbtn, {
    updateTabItems(session, "sidebar", "page1")
  })
  
  
  #data dictionary
  output$dictionary <- DT::renderDataTable(dict, options = list(pageLength = 5))
  

  #cluster dendrogram
  output$cluster <- renderCollapsibleTree({Sys.sleep(1)
    collapsibleTree(df2, root = 'SNOMED CT', linkLength = 200,
                    c('Cluster_Category', 'Cluster_Desc', 'ConceptId_Description_2')
                    )
  })
  
  #slider for cluster category
  output$daterange <- renderUI({
    sliderInput('date', 'Pick a date range to view', min= min(clusterfilter()$date_ym), 
                max = max(clusterfilter()$date_ym), 
                value = c(min= min(clusterfilter()$date_ym), max = max(clusterfilter()$date_ym)))
  })
  
  #cluster category navigator updater
  observeEvent(input$date, {
    updateSliderInput(session, 'date', value = input$date)
  })
  
  

  #cluster category plot
  output$clusterplot <- renderPlotly({Sys.sleep(1)
    req(input$date)
    ggplotly(
      ggplot(clusterfilter(), aes(x = date_ym)) +
        geom_line(aes(y = records_month, colour = 'Records Month'), alpha = 0.7, show.legend = TRUE) +
        geom_line(aes(y = valid_idmonth, colour = 'Valid Id'), alpha = 0.7, show.legend = TRUE) +
        geom_line(aes(y = distinct_id, colour = 'Distinct Id'), alpha = 0.7, show.legend = TRUE) +

        labs(x = 'Date', y = 'Cases', colour = 'Key') +
        scale_y_continuous(labels = label_number(scale_cut = cut_short_scale())) +
        scale_x_date(limits = c(input$date[1], input$date[2])) +
        scale_color_manual(values = c('Records Month' = '#440154',
                                      'Valid Id' = '#31688E',
                                      'Distinct Id' = '#6DCD59')) +
        theme_minimal()+
        theme(legend.position = 'right') 
    ) %>% layout(plot_bgcolor = "white", paper_bgcolor = "white")
  })
  
  #cluster id display
  output$clustername <- renderValueBox({
    value <- filteredval()$Cluster_ID
    valueBox(subtitle = "Cluster ID", value = value)
  })
  
  #cluster category value display
  output$clustercat <- renderValueBox({
    valueBox(subtitle = "Cluster Category", value = filteredval()$Cluster_Category)})
  
  #records in gdppr display
  output$clustern <- renderValueBox({
    value <- filteredval()$records_total
    valueBox(subtitle = "Records in GDPPR", value = value)
  })
  
  #distinct individuals display
  output$individuals <- renderValueBox({
    value <- filteredval()$individuals
    valueBox(subtitle = "Distinct Individuals", value = value)
  })
  
  #cluster description display
  output$clusterdesc <- renderValueBox({
    valueBox(subtitle = "Cluster Description", value = filteredval()$Cluster_Desc)})
  
  #percentage before 1990
  observeEvent(input$earlydates, {shinyalert(text = filteredval()$pre_1990_n_pct,
                                             animation = T, type = 'info')})
  
  #dendrogram info box
  observeEvent(input$conceptinfo, {shinyalert(text = 'Click through to view SNOMED CT Cluster Categories, Clusters and Concepts',
                                             animation = T, type = 'info')})
  
  observeEvent(input$timeseriesinfo, {shinyalert(text = 'Hover on plot for more information',
                                              animation = T, type = 'info')})
  
  filtered_data <- reactiveVal()
  filtered_datatwo <- reactiveVal()
  
  #resize plot
  observeEvent(input$resize, {
    filtered_data(filtered()[filtered()$records_month > 1000, ]) 
    filtered_datatwo(filteredtwo()[filteredtwo()$records_month > 1000, ])
  })
  
  #disable resize button when compare is checked
  observeEvent(input$compare, {
    if (input$compare) {
      shinyjs::disable("resize")
      shinyjs::addClass("resize", "disabled-button")
    } else {
      shinyjs::enable("resize")
      shinyjs::removeClass("resize", "disabled-button")
    }
  })
  
  #reset plot after resizing
  observeEvent(input$reset, {
    filtered_data(NULL)
    filtered_datatwo(NULL)
  })
  
  #disable reset button when compare is checked
  observeEvent(input$compare, {
    if (input$compare) {
      shinyjs::disable("reset")
    } else {
      shinyjs::enable("reset")
    }
  })
  
  observeEvent(input$datatwo, {
    filtered_data(NULL)
  })
  
  
  
  #timeseries plot
  output$timeseries <- renderPlotly({
    Sys.sleep(1)
    filtered_plot_data <- filtered() 
    filtered_plot_datatwo <- filteredtwo()
    combined_data <- rbind(filtered_plot_data, filtered_plot_datatwo)
    
    
    if (input$compare) {
      plot_data <- combined_data
      p <- ggplot(plot_data, aes(x = date_ym, fill = ConceptId_Description_2)) +
        geom_area(aes(y = records_month, fill = ConceptId_Description_2)) +
        labs(x = 'Date', y = 'Cases') +
        scale_y_continuous(labels = label_number(scale_cut = cut_short_scale())) +
        scale_fill_viridis_d() +
        theme_minimal() +
        theme(legend.position = 'none')
      
      p <- p + facet_grid(Cluster_Desc ~ .)
    } else {
      if (is.null(filtered_data())) {
        plot_data <- filtered_plot_data
      } else {
        plot_data <- filtered_data()
      }
      
      p <- ggplot(plot_data, aes(x = date_ym, fill = ConceptId_Description_2)) +
        geom_area(aes(y = records_month, fill = ConceptId_Description_2)) +
        labs(x = 'Date', y = 'Cases') +
        scale_y_continuous(labels = label_number(scale_cut = cut_short_scale())) +
        scale_fill_viridis_d() +
        theme_minimal() +
        theme(legend.position = 'none')
    } 
    
    if (input$showLegend) {
      p <- p + theme(legend.position = "left")
    }
    
    
    ggplotly(p, tooltip = 'fill') %>% layout(plot_bgcolor = 'white', paper_bgcolor = 'white')
  })
  
  
}

shinyApp(ui, server)
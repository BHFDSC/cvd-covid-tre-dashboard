
current_dir_example = dirname(rstudioapi::getSourceEditorContext()$path)

source(paste0((current_dir_example),'/data.R'))
source(paste0((current_dir_example),'/inputs.R'))
source(paste0((current_dir_example),'/common_functions.R'))

library(shiny)
library(bslib)
library(shinydashboard)
library(shinyWidgets)
library(shinyBS)
library(shinyjs)
library(hover)
library(DT)
library(scales)
library(ggiraph)
library(patchwork)
library(fontawesome)
library(ggtext)


ui = fluidPage(
  
  
  fluidRow(
    
    #Inputs - Plots
    column(3,checkboxInput("test", "Test")),
    #Ouputs
    column(9,
           tabsetPanel(
             tabPanel("Plot", value="eda_plot",
                      tags$div(plotOutput("completeness_plot",
                                          width='100%'))),
             tabPanel("Summary", value="completeness_summary",
                      tags$div(tableOutput("")))
           )),
    
    
  )
  
)


server = 
  function(input, output, session) {
    
    # pull the variable names from a chosen dataset to use as test data
    completeness_test_data = reactive({data_dictionary %>%
      filter(table=="hes_ae_{fyear}_dars_nic_391419_j3w9t") %>%
      #this will be reactive and table names need aligned to input table names in addition to the table names used when data downloaded from TRE in aggreagate
      select(display_name_label) %>%
      mutate(completeness = round(runif(nrow(.))*100,2))
    })
    
output$completeness_plot = renderPlot({ ggplot(data=completeness_test_data(),
           #%>%
           #mutate(answer = fct_relevel(.data$display_name_label, (() %>% pull()))), 
           aes(x=.data$display_name_label, y=.data$completeness)) +
      geom_bar(stat="identity",fill = "red", alpha = 0.3) +
      coord_flip(clip = 'off')  +
      labs(x="",y="BLAH") +
      theme(
        plot.title = element_markdown(size = 11, lineheight = 1.2),
        plot.subtitle = element_markdown(size = 11, lineheight = 1.2),
        legend.position = "none",
        plot.title.position = 'plot', #align to outer margin; applies to subtitle too
        #panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        plot.margin = margin(0,30,0,0)
      ) +
      geom_text(aes(label=paste0(round(completeness)," %")), hjust=-0.2)
})
    
  }

shinyApp(ui = ui, server = server)


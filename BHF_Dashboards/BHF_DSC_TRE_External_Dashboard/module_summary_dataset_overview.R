source('bhf_dsc_hds_designkit.R')

datasetOverviewUI <- function(id){
  ns <- NS(id)
  tagList(
    
    
    #### Value Boxes ==================================================
    fluidRow(class = "dashboard_css",
             valueBoxOutput(ns("registrations"), width = 4),
             valueBoxOutput(ns("batch_summary"), width = 4)
    ),
    
  )
}


datasetOverviewServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {
      
      #### Value Boxes =============================================================
      output$registrations = renderValueBox({
        customValueBox(
          title = "Registrations",
          icon = icon("user"),
          subtitle = "",
          value = HTML(paste(paste0(names(count_options),":"),collapse = '<br/>')),
          color = colour_bhf_darkred,
          background = customValueBox_global_colour,
          border = customValueBox_border_colour,
          href = NULL
        )
      })
      
      output$batch_summary = renderValueBox({
        customValueBox(
          title = "Batch Summary",
          icon = icon("file"),
          subtitle = "",
          value = HTML(paste("Batch ID:", "Production Date:", "&nbsp", sep="<br/>")),
          color = colour_bhf_darkred,
          background = customValueBox_global_colour,
          border = customValueBox_border_colour,
          href = NULL
        )
      })
      
    }
  )
}
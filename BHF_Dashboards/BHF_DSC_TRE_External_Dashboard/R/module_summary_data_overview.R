dataOverviewUI <- function(id){
  ns <- NS(id)
  tagList(

    # Outputs ------------------------------------------------------------------
    fluidRow(class = "dashboard_css",
             valueBoxOutput(ns("registrations"), width = 4),
             valueBoxOutput(ns("batch_summary"), width = 4)
    ),
    
  )
}


dataOverviewServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {
      
      dataset_overview = reactive({
        t.dataset_overview %>%
        filter(dataset == dataset_summary())
      })
      
      #### Value Boxes =============================================================
      output$registrations <- renderValueBox({
        if (nrow(dataset_overview())>1){
          return(customValueBox(
            title = "Records",
            icon = icon("user"),
            subtitle = "",
            value = HTML(paste(paste0("<b>",names(count_options),":</b>"),
                               collapse = '<br/>')),
            color = colour_bhf_darkred,
            background = customValueBox_global_colour,
            border = customValueBox_border_colour,
            href = NULL
          ))
        }
        customValueBox(
          title = "Records",
          icon = icon("user"),
          subtitle = "",
          value = HTML(paste(paste0("<b>",names(count_options),":</b>"),
                              dataset_overview() %>% 
                                select(n,n_id,n_id_distinct) %>% 
                                pivot_longer(everything()) %>% 
                                pull(value),
                              collapse = '<br/>')),
          color = colour_bhf_darkred,
          background = customValueBox_global_colour,
          border = customValueBox_border_colour,
          href = NULL
        )
      })
      
      
      output$batch_summary = renderValueBox({
        if (nrow(dataset_overview())>1){
          return(customValueBox(
            title = "Batch Summary",
            icon = icon("file"),
            subtitle = "",
            value = HTML(paste0(paste(paste0("<b>",c("Batch ID","Production Date","Archived On"),":</b>"),
                                      collapse = '<br/>'))),
            color = colour_bhf_darkred,
            background = customValueBox_global_colour,
            border = customValueBox_border_colour,
            href = NULL
          ))
        }
        customValueBox(
          title = "Batch Summary",
          icon = icon("file"),
          subtitle = "",
          value = HTML(paste0(paste(paste0("<b>",c("Batch ID","Production Date","Archived On"),":</b>"),
                                    dataset_overview() %>% 
                                      select(batch,production_date) %>% 
                                      pivot_longer(everything()) %>% 
                                      pull(value),
                                    collapse = '<br/>'))),
          color = colour_bhf_darkred,
          background = customValueBox_global_colour,
          border = customValueBox_border_colour,
          href = NULL
          )
      })
        
    }
  )
}
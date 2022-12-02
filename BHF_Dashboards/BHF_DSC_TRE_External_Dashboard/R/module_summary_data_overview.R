dataOverviewUI <- function(id){
  ns <- NS(id)
  tagList(

    # Outputs ------------------------------------------------------------------
    fluidRow(class = "overview_css",
             
             column(4,
  

             valueBoxOutput(ns("registrations"), width="100%")
             
             ),
             
             
             column(4, 

               valueBoxOutput(ns("batch_summary"), width="100%")
             
             )
             
             )
    
    #spsComps::heightMatcher(ns("test2"),ns("test1"))
  )
}


dataOverviewServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {
      
      dataset_overview = reactive({
        t.dataset_overview %>%
        mutate(across(c(n,n_id,n_id_distinct),.fn =~as.numeric(.))) %>%
        mutate(across(c(n,n_id,n_id_distinct), .fn = ~ scales::comma(.))) %>%
        mutate(across(c(n,n_id,n_id_distinct), .fn = ~ replace_na(.,"null"))) %>%
        filter(dataset == dataset_summary()) %>%
        shhh() #suppress warnings about coercing NAs
      })
      
      archived_on = reactive({
        
        dataset_overview() %>%
          left_join(datasets_available%>%select(dataset=Dataset,exported)) %>%
          select(archived_on) %>% 
          pivot_longer(everything()) %>% 
          pull(value)
        
      })

      export_date_batch = reactive({
          if(nation_summary()=="England"){export_date_england} else if (nation_summary()=="Scotland"){export_date_scotland} else {export_date_wales}
      })
      
      archived_on_list = reactive({if(length(archived_on()==0)){archived_on()} else {""}})
      
      batch_summary = reactive({
        
        c(
          archived_on_list(),
          export_date_batch()
        )
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
        if (length(archived_on())>1){
          return(customValueBox(
            title = "Batch Summary",
            icon = icon("file"),
            subtitle = "",
            value = HTML(paste0(paste(paste0("<b>",c("Archived On", "Exported On"),":</b>"),
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
          value = HTML(paste0(paste(paste0("<b>",c("Archived On","Exported On"),":</b>"),
                                    batch_summary(),
                                    collapse = '<br/>'),"<br/>&nbsp")),
          color = colour_bhf_darkred,
          background = customValueBox_global_colour,
          border = customValueBox_border_colour,
          href = NULL
          )
      })
      
      # HTML(paste0(paste(paste0("<b>",c("Batch ID","Archived On"),":</b>"),
      #                   collapse = '<br/>'),"<br/>&nbsp"))
        
      # HTML(paste0(paste(paste0("<b>",c("Batch ID","Archived On"),":</b>"),
      #                   dataset_overview() %>% 
      #                     select(BatchId,archived_on) %>% 
      #                     pivot_longer(everything()) %>% 
      #                     pull(value),
      #                   collapse = '<br/>'),"<br/>&nbsp"))
    }
  )
}
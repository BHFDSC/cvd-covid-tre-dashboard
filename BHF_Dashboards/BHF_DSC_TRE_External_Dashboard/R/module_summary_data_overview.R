dataOverviewUI <- function(id){
  ns <- NS(id)
  tagList(

    # Outputs ------------------------------------------------------------------
    fluidRow(class = "overview_css",
             
             column(5,
  

             valueBoxOutput(ns("registrations"), width="100%")
             
             ),
             
             
             column(5, 

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
          
        if(nation_summary() == "England" ){
          t.dataset_overview = t.dataset_overview_eng
        }
        else if (nation_summary() == "Wales" ){
          t.dataset_overview = t.dataset_overview_wales  %>% rename(n_id_distinct = n_distinct)  
        }
        else if (nation_summary() == "Scotland" ){
          t.dataset_overview = t.dataset_overview_scotland %>% 
            mutate(archived_on = as.Date( archived_on, tryFormats = c("%d/%m/%Y")))
        }
        
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
        
        # validate(need(dataset_summary() ,
        #               message = FALSE))
        
        
 
        customValueBox(
          title = "Overall Counts",
          icon = icon("user"),
          subtitle = "",
          value = HTML(
            paste0(HTML('<div class="inner" style="margin-top:20px;">'),
            HTML('<h6 id="count_heading">
                       <b>Records: </b>'),
            (dataset_overview() %>% select(n) %>% pivot_longer(everything()) %>% pull(value)),
            HTML('</h6><h6 id="count_heading">
                       <b>Records with a de-identified PERSON ID: </b>'),
                   (dataset_overview() %>% select(n_id) %>% pivot_longer(everything()) %>% pull(value)),
                   HTML('   
                       <div class="pretty p-default p-switch p-fill"></div>
                       <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate" 
                       aria-label="Number of records with
a de-identified person 
identifier that are 
potentially linkable 
across datasets within 
the respective TRE">
                      <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
                      </span></h6></div>'),
HTML('</h6><h6 id="count_heading">
                       <b>Distinct de-identified PERSON ID: </b>'),
(dataset_overview() %>% select(n_id_distinct) %>% pivot_longer(everything()) %>% pull(value)),
HTML('   
                       <div class="pretty p-default p-switch p-fill"></div>
                       <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate" 
                       aria-label="The unique number of 
de-identified person 
identifiers in the dataset, 
excluding null values">
                      <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
                      </span></h6></div></div>'))),

          color = '#413C45',
          background = '#EEE8FF',
          border = '#EEE8FF',
          href = NULL
        )
      })
      
      

  
      
      
      output$batch_summary = renderValueBox({
        
        # validate(need(dataset_summary() ,
        #               message = FALSE))
        
        

        
        
        customValueBox(
          title = "Batch Summary",
          icon = icon("file"),
          subtitle = "",
          value = HTML(
            paste0(HTML('<div class="inner" style="margin-top:20px;">'),

HTML('</h6><h6 id="count_heading">
                       <b>Archived on: </b>'),
(batch_summary()[1]),
HTML('   
                       <div class="pretty p-default p-switch p-fill"></div>
                       <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate" 
                       aria-label="The date the dataset 
was provisioned in the 
respective TRE">
                      <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
                      </span></h6></div>'),
HTML('</h6><h6 id="count_heading">
                       <b>Exported on: </b>'),
(batch_summary()[2]),
HTML('   
                       <div class="pretty p-default p-switch p-fill"></div>
                       <span "te" id="pretty_custom_icon" class="hint--right hint--error hint--medium hint--rounded hint--no-animate" 
                       aria-label="The date the 
aggregated dataset 
summary was 
produced and safely 
exported from the TRE 
for inclusion in the 
dashboard">
                      <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
                      </span></h6>'),
HTML('</h6><h6 id="count_heading">
                       <b>&nbsp</b></h6></div>'))),
          # value = HTML(paste0(paste(paste0("<b>",c("Archived On","Exported On"),":</b>"),
          #                           batch_summary(),
          #                           collapse = '<br/>'),"<br/>&nbsp")),
          color = '#413C45',
          background = '#EEE8FF',
          border = '#EEE8FF',
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
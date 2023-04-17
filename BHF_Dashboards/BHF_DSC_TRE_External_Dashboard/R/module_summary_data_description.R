dataDescriptionUI <- function(id){
  ns <- NS(id)
  tagList(
    # Outputs ------------------------------------------------------------------
    textOutput(ns("description")),
    br(),
    uiOutput(ns("tab"))
    #textOutput(ns("info")),
  )
}

dataDescriptionServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
    

      dataset_desc_filter = reactive({
        datasets_available %>%
          filter(.data$Nation == nation_summary()) %>% 
          filter(.data$Dataset == dataset_summary())
      }) #%>% bindCache(dataset_summary(),nation_summary())

         
      observeEvent(dataset_summary(),
      output$description <- renderPrint({
        #to prevent all descriptions rendering print blank until df filtered
        if (nrow(dataset_desc_filter())>1){
          return(cat(""))
        }
        cat(dataset_desc_filter() %>%
          select(Description) %>%
            pull())
      })
      )
      
      

      

      
      #%>% bindCache(dataset_summary(),nation_summary())
      
      
      url1 <- reactive({a(ifelse(grepl("digital.nhs", 
                             datasets_available$url1[datasets_available$Dataset == dataset_summary() & 
                                                       datasets_available$Nation == nation_summary() ]),"NHS England",
                       ifelse(grepl("nicor", 
                                    datasets_available$url1[datasets_available$Dataset == dataset_summary() & 
                                                              datasets_available$Nation == nation_summary()]),"NICOR website",
                              ifelse(grepl("scot", 
                                           datasets_available$url1[datasets_available$Dataset == dataset_summary() & 
                                                                     datasets_available$Nation == nation_summary()]), "Public Health Scotland",
                                     ""))),
                href = datasets_available$url1[datasets_available$Dataset == dataset_summary() & 
                                                 datasets_available$Nation == nation_summary()],
                target = "_blank")

        })
                
      #observe(print(url1()))
      
      url2 <- reactive({a("Health Data Research Innovation Gateway", 
                       href = datasets_available$url2[datasets_available$Dataset == dataset_summary() & 
                                                        datasets_available$Nation == nation_summary()],
                target = "_blank")})
      
      #observe(print(url2()))
      
      
      
      current_df = reactive({datasets_available%>%filter(Dataset==dataset_summary())%>%filter(Nation==nation_summary())})
      
      #observe(print(current_df()))
      
      toListen <- reactive({
        list(nation_summary(), dataset_summary())
      })
      
      
      
      print_urls = reactive({
        
        req(nation_summary(), dataset_summary())
        
        validate(need(current_df() ,
                      message = FALSE))
        
        validate(need(nation_summary() ,
                      message = FALSE))
        
        if(is.na(current_df()$url1) & !is.na(current_df()$url2)) {tagList("For more information see:",br(),url2())} 
        
        else if(is.na(current_df()$url2) & !is.na(current_df()$url1)) {tagList("For more information see:",br(),url1())} 
        
        else if(is.na(current_df()$url1) & is.na(current_df()$url2)) {""} 
        
        else 
          
        {tagList("For more information see:",br(),url1(), "and", url2())}
        
      })
      
      observeEvent(dataset_summary(), {
      output$tab <- renderUI({
        
        #need this to stop the error printing between country changes
        if (nrow(dataset_desc_filter())==0){
        ""
        } else
        {print_urls()}
        
        }) #%>% bindCache(dataset_summary(),nation_summary())
         #%>% bindCache(dataset_summary(),nation_summary())

      })
      
      #observe(print(nrow(dataset_desc_filter())))

    }
  )
}







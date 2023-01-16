dataDescriptionUI <- function(id){
  ns <- NS(id)
  tagList(
    # Outputs ------------------------------------------------------------------
    textOutput(ns("description")),
    br(),textOutput(ns("info")),
    uiOutput(ns("tab"))
  )
}

dataDescriptionServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
      

      dataset_desc_filter = reactive({
        datasets_available %>%
        filter(.data$Dataset == dataset_summary())
      }) %>% bindCache(dataset_summary(),nation_summary())

         
      observeEvent(dataset_summary(),
      output$description <- renderPrint({
        #to prevent all descriptions rendering print blank until df filtered
        if (nrow(dataset_desc_filter())>1){
          return(cat(""))
        }
        cat(dataset_desc_filter() %>%
          select(Description) %>%
            pull())
      
        
      output$info <- renderText({
        
        validate(need(dataset_summary() ,
                      message = FALSE))
        
        "For more information see:"}) 
      #%>% bindCache(dataset_summary(),nation_summary())
      
      url1 <- a(ifelse(grepl("digital.nhs", 
                             datasets_available$url1[datasets_available$Dataset == dataset_summary()]),"NHS Digital",
                       ifelse(grepl("nicor", 
                                    datasets_available$url1[datasets_available$Dataset == dataset_summary()]),"NICOR website",
                              ifelse(grepl("scot", 
                                           datasets_available$url1[datasets_available$Dataset == dataset_summary()]), "Public Health Scotland",
                                     ""))),
                href = datasets_available$url1[datasets_available$Dataset == dataset_summary()],
                target = "_blank")
                
                
      url2 <- a("Health Data Research Innovation Gateway", 
                       href = datasets_available$url2[datasets_available$Dataset == dataset_summary()],
                target = "_blank")
      
      output$tab <- renderUI({
        

        validate(need(dataset_summary() ,
                      message = FALSE))
        
        if(is.na(datasets_available$url2[datasets_available$Dataset == dataset_summary()]))

       
        {tagList(url1)} 
        
        else if(is.na(datasets_available$url1[datasets_available$Dataset == dataset_summary()]))
          
        {tagList(url2)}
        
        else 
           
          {tagList(url1, "and", url2)}
                       
          }) %>% bindCache(dataset_summary(),nation_summary())
        }) %>% bindCache(dataset_summary(),nation_summary())
      )
    }
  )
}






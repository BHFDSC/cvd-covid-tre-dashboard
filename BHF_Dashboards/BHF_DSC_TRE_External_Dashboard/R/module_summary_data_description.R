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
      })

         
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
        "For more information see:"})    
      
      url1 <- a(ifelse(grepl("digital.nhs", 
                             datasets_available$url1[datasets_available$Dataset == dataset_summary()]),"NHS Digital",
                       ifelse(grepl("nicor", 
                                    datasets_available$url1[datasets_available$Dataset == dataset_summary()]),"NICOR website",
                              ifelse(grepl("scot", 
                                           datasets_available$url1[datasets_available$Dataset == dataset_summary()]), "Public Health Scotland",
                                     ""))),
                href = datasets_available$url1[datasets_available$Dataset == dataset_summary()])
                
                
      url2 <- a(ifelse(is.na(datasets_available$url2[datasets_available$Dataset == dataset_summary()]),
                       "", "Health Data Gateway"), 
                       href = datasets_available$url2[datasets_available$Dataset == dataset_summary()])
      
      output$tab <- renderUI({
       
         tagList(url1, "and", url2)
      
          
          })
        })
      )
    }
  )
}



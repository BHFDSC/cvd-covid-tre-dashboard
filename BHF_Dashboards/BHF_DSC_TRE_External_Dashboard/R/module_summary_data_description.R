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
      
      url1 <- a("NHS Digital", 
                href= datasets_available$nhsd_url[datasets_available$Dataset == dataset_summary()])
      url2 <- a("Health Data Gateway", 
                href= datasets_available$hdg_url[datasets_available$Dataset == dataset_summary()])
      output$tab <- renderUI({
        tagList(url1, "and",  url2)
        
          })
        })
      )
    }
  )
}



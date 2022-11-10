dataDescriptionUI <- function(id){
  ns <- NS(id)
  tagList(
    # Outputs ------------------------------------------------------------------
    textOutput(ns("description"))
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
        })
      )
    }
  )
}


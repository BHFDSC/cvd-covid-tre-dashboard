#Outputs
methodologyOutput <- function(id){
  ns <- NS(id)
  tagList(
      fluidRow(
      column(12,style=appendix_css,
       
       h4("Holding Text"),
       h5("Sub Title",style="padding-bottom:4px;"),
       p(span("Some text: ", style = "font-weight: bold;"),
         "as an example",
         style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
       p(span("blah blah", style = "font-weight: bold;"),
         "and blah",
         style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
      ),
      )
  )
}


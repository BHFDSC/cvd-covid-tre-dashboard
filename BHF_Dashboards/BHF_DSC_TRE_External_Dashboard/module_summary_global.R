module_global_ui <- function(id){
  ns <- NS(id)
  tagList(
    column(3,style = bhf_global_options_column_style_left,
           div(id = "nation_css",
               class = "nation_css",
               selectInput(inputId = "nation_summary",
                           label = shiny::HTML("<p></p><span style='color: white'>Nation:</span>"),
                           choices = nations_options))
    ),                            
    
    column(6,style = bhf_global_options_column_style_middle,
           div(id = "dataset_css",
               class = "dataset_css",
               selectInput(inputId = "dataset_summary",
                           label = shiny::HTML("<p></p><span style='color: white'>Dataset:</span>"),
                           width = '100%',
                           choices = NULL))
    ),
    
    
    column(3,style = bhf_global_options_column_style_right
    )
  )
}


module_global_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      return(input)
      
    }
  )
}
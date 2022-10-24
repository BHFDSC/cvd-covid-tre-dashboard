module_ui <- function(id){
  ns <- NS(id)
  tagList(
    # UI elements here
  )
}

module_server <- function(id){
  moduleServer(
    id,
    function(input, output, session){
      # logic here
    }
  )
}
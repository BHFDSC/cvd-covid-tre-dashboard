library(shiny)
library(DT)

set.seed(2282018)
company <- data.frame(Company = letters[1:10], Sales = scales::dollar(runif(10, 200, 1230)), stringsAsFactors = F)

css <- HTML(".pull-left{float: left !important;}
            .pull-right{float: right !important;}")

js <- HTML("$(function(){
        setTimeout(function(){
           $('.dataTables_filter').addClass('pull-left');
           $('.dataTables_length').addClass('pull-right');
           }, 200);
           });")

# UI ---- 
ui <- function(){
  
  fluidPage(
    tags$head(tags$style(css),
              tags$script(js)),
    
    sidebarLayout(
      
      sidebarPanel(numericInput("nums", label = "Num Input", value = 1, min = 1, max = 10)),
      
      mainPanel(dataTableOutput("mytable"))
    )       
  )
}

# server ----
server <- function(input, output, session){
  
  output$mytable <- renderDataTable({
    datatable(company, 
              caption = tags$caption("StackOverflow Example"), 
              filter = "none", 
              options = list(
                autoWidth = T, 
                pageLength = 10, 
                scrollCollapse = T, 
                dom = '<"top"l>t<"bottom"f>')
    )
  })
}
shinyApp(ui, server)
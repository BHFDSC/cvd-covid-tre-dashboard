library("shiny")
library(shinydashboard)
library(shinydashboardPlus)
library(DT)

jscode <-"
$(document).ready(function(){
            $('#mycarousel').carousel( { interval:  true } );
});"

shinyApp(
  ui = dashboardPage(
    header = dashboardHeader(),
    sidebar = dashboardSidebar(),
    body = dashboardBody(
      tags$head(
        tags$style(HTML("
      #mycarousel {
        width:900px;
        height:600px;
      }
    .carousel-control{
      color:#FF0000;
    }
    "))
      ),
    tags$head(tags$script(HTML(jscode))),
    carousel(
      id = "mycarousel",
      carouselItem(
        DTOutput("show_iris_dt")
      ),
      carouselItem(
        caption = "An image file",
        tags$img(src = "YBS.png")
      ),
      carouselItem(
        caption = "Item 3",
        tags$img(src = "http://placehold.it/900x500/39CCCC/ffffff&text=Happy+New+Year")
      )
    )
    ),
    title = "Carousel Demo"
  ),
  server = function(input, output) {
    output$show_iris_dt <- renderDT({
      datatable(iris)
    })
  }
)
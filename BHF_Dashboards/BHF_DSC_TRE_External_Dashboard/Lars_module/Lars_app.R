#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(readxl)
#getwd()


data_dictionary = read_excel("C:/RProjects/BHF_DSC_HDS/BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Lars_module/TRE_DD_391419_j3w9t.xlsx", sheet = "gdppr", skip = 2)

filename <- "C:/RProjects/BHF_DSC_HDS/BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Lars_module/TRE_DD_391419_j3w9t.xlsx"

sheets <- readxl::excel_sheets(filename)

read_excel_allsheets <- function(filename, tibble = FALSE, except_sheet_no = NA, skip = 0, collate = TRUE) {
# reading all the names of the sheets
  sheets <- readxl::excel_sheets(filename)
# applying any exceptions eg cover sheets  
  if (!is.na(except_sheet_no)){
    sheets <- sheets[-except_sheet_no]
  }
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X, skip = skip))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  if (collate){
  x <- dplyr::  bind_rows(x)
  }
  x
}

data_dictionary <- read_excel_allsheets(filename, tibble = FALSE, except_sheet_no = 1, skip = 2)


shinyApp(
  ui = fluidPage(DTOutput('tbl')),
  server = function(input, output) {
    output$tbl = renderDT(
      data_dictionary, options = list(lengthChange = FALSE)
    )
  }
)
# Run the application 
#shinyApp(ui = ui, server = server)


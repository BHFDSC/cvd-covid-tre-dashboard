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


routefolder <- getwd()
routefolder <- "C:/Users/LarsMurdock/Documents/Repo/BHF_DSC_HDS/BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Lars_module"

dictionarypath_Eng <- paste0(routefolder, "/TRE_DD_391419_j3w9t.xlsx")
dictionarypath_Scot <- paste0(routefolder, "/DD_Scotland.xlsx")

sheets_Eng <- readxl::excel_sheets(dictionarypath_Eng)
sheets_Eng
sheets_Scot <- readxl::excel_sheets(dictionarypath_Scot)
sheets_Scot


read_excel_allsheets <- function(filename, tibble = FALSE, except_sheet_no = NA, skip = 0, collate = TRUE) {
# reading all the names of the sheets
  sheets <- readxl::excel_sheets(filename)
# applying any exceptions eg cover sheets  
  if (!sum(is.na(except_sheet_no))){
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

data_dictionary_Eng <- read_excel_allsheets(filename = dictionarypath_Eng, tibble = FALSE, except_sheet_no = 1, skip = 2)

data_dictionary_Scot <- read_excel_allsheets(filename = dictionarypath_Scot, tibble = FALSE, except_sheet_no = c(1,2), skip = 0, collate = TRUE)


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


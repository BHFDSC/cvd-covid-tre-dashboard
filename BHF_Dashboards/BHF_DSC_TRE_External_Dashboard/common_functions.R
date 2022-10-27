library(tidyverse)
library(readxl)

dataset_dashboard_list = function(nation,key="Dataset available"){
  
  nation_datasets = datasets_available %>%
    filter(Key==key & Nation==nation)
  
  nation_datasets_list = list()
  
  groups = pull(distinct(nation_datasets,Group))
  
  for(i in 1:length(groups)){
    nation_datasets_list[[i]]=
      setNames(
        pull(filter(nation_datasets,Group==groups[i]),Dataset),
        pull(filter(nation_datasets,Group==groups[i]),Title)
      )
  }
  
  names(nation_datasets_list) = groups
  
  return(nation_datasets_list)
  
}


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




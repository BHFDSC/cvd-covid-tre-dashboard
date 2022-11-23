
# This script is to read in the Wales data and clean it into a more user friendly format, ready for the app



#install.packages("xlsx")

#location
Wales_dic_file <- "BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Archive/Lars_module/Wales_scraping.xlsx"

# reading in all the sheets
sheets <- readxl::excel_sheets(Wales_dic_file)
input <- lapply(sheets, function(X) readxl::read_excel(Wales_dic_file, sheet = X, col_names = FALSE))

# tidying

# creating a list to collect the tables onces cleaned
output = list()
# output_spreadsheet <- "BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Archive/Lars_module/DD_Wales.xlsx"
output_spreadsheet <- "BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Data/DD_Wales.xlsx"


# looping through the lists to pivot and clean etc
for (i in (1:length(input))){
output[[i]] <- as.data.frame(matrix(as.matrix(input[[i]]), ncol = 3, byrow = TRUE ))
colnames(output[[i]]) = c("Variable", "Description", "Data Type")
output[[i]]$`Data Type` <- stringr :: str_replace(output[[i]]$`Data Type`, "Data type", "")
output[[i]]$table <- sheets[i]

# writing 
if(i == 1){append_bool = FALSE} else { append_bool = TRUE}

xlsx :: write.xlsx(output[[i]], 
                   output_spreadsheet, 
                   row.names = FALSE, 
                   append = append_bool,
                   sheetName = sheets[i])

}

# writing




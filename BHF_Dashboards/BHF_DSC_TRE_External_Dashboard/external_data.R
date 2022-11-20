#current_dir_data = dirname(rstudioapi::getSourceEditorContext()$path)

# TRE Dataset Provisioning Dashboard -------------------------------------------
t.dataset_dashboard = read.csv('Data/TRE_dataset_link.csv')

datasets_available = t.dataset_dashboard %>%
  mutate(across(-c("Description"), .fn=~str_trim(.,side="both"))) %>%
  mutate(across(everything(), .fn=~na_if(.,""))) %>%
  filter(!is.na(Dataset)) %>%
  filter(!is.na(Title))

# TRE Data Dictionary ----------------------------------------------------------

#England
t.data_dictionaryEng = read_excel_allsheets('Data/TRE_DD_391419_j3w9t.xlsx',
                                       tibble = FALSE,
                                       except_sheet_no = 1,
                                       skip = 2) %>%
  mutate(table = str_replace(table,paste0("_",database),"")) %>%
  filter(!is.na(table))

# duplicating in case there are any downstream chunks depending on the name 'data_dictionary'
data_dictionary <- t.data_dictionaryEng


#Scotland
# pathfornow = "C:/Users/LarsMurdock/Documents/Repo/BHF_DSC_HDS/BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Data/DD_Scotland.xlsx"

t.data_dictionaryScot = read_excel_allsheets( #pathfornow, 
  "Data/DD_Scotland.xlsx",
                                       tibble = FALSE,
                                       except_sheet_no = c(1,2),
                                       skip = 0,
                                       collate = FALSE) 

t.data_dictionaryScot = Map(cbind, names(t.data_dictionaryScot), t.data_dictionaryScot) 

# Renaming the tables in the list so that they can be reactively called
for (i in (1: length(t.data_dictionaryScot))){ colnames(t.data_dictionaryScot[[i]])[1] <- 'table'}

# Merging and removing blank rows  
t.data_dictionaryScot = t.data_dictionaryScot %>% 
  dplyr:: bind_rows() %>% 
  filter( !is.na(Type))





# Data Coverage Pre Processed from data_preprocessing
t.data_coverage = read_rds("Data/data_coverage")

# Dataset Overview -------------------------------------------------------------
t.dataset_overview = read.csv('Data/export_dashboard_NHSD_20221108_date_overview.csv')

# Dataset Overview -------------------------------------------------------------
t.dataset_completeness = read.csv('Data/export_dashboard_NHSD_20221108_data_completeness.csv')







#current_dir_data = dirname(rstudioapi::getSourceEditorContext()$path)

# TRE Dataset Provisioning Dashboard -------------------------------------------
t.dataset_dashboard = read.csv('Data/TRE_dataset_link.csv')

datasets_available = t.dataset_dashboard %>%
  mutate(across(-c("Description"), .fn=~str_trim(.,side="both"))) %>%
  mutate(across(everything(), .fn=~na_if(.,""))) %>%
  filter(!is.na(Dataset)) %>%
  filter(!is.na(Title))

# TRE Data Dictionary ----------------------------------------------------------
# t.data_dictionary = readxl::read_excel((paste0(current_dir_data,
#                                                '/Data/TRE_DD_391419_j3w9t.xlsx')))
data_dictionary = read_excel_allsheets('Data/TRE_DD_391419_j3w9t.xlsx',
                                       tibble = FALSE,
                                       except_sheet_no = 1,
                                       skip = 2) %>%
  mutate(table = str_replace(table,paste0("_",database),"")) %>%
  filter(!is.na(table))


# Data Coverage Pre Processed from data_preprocessing
t.data_coverage = read_rds("Data/data_coverage")

# Dataset Overview -------------------------------------------------------------
t.dataset_overview = read.csv('Data/export_dashboard_NHSD_20221108_date_overview.csv')

# Dataset Overview -------------------------------------------------------------
t.dataset_completeness = read.csv('Data/export_dashboard_NHSD_20221108_data_completeness.csv')







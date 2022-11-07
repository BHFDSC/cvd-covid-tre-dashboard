current_dir_data = dirname(rstudioapi::getSourceEditorContext()$path)

# TRE Dataset Provisioning Dashboard -------------------------------------------
t.dataset_dashboard = read.csv(paste0(current_dir_data,
                                      '/Data/TRE_dataset_provisioning_dashboard.csv'))

datasets_available = t.dataset_dashboard %>%
  mutate(across(everything(), .fn=~str_trim(.,side="both")))

# TRE Data Dictionary ----------------------------------------------------------
t.data_dictionary = readxl::read_excel((paste0(current_dir_data,
                                               '/Data/TRE_DD_391419_j3w9t.xlsx')))
data_dictionary = read_excel_allsheets(paste0(current_dir_data,
                                              '/Data/TRE_DD_391419_j3w9t.xlsx'),
                                       tibble = FALSE,
                                       except_sheet_no = 1,
                                       skip = 2)



# Data Collection Start Dates --------------------------------------------------
t.dataset_start_dates = read.csv(paste0(current_dir_data,
                                        '/Data/TRE_dataset_collection_start_dates.csv')) %>%
  suppressWarnings()

# Data Coverage Pre Processed from data_preprocessing
t.data_coverage = read_rds("Data/data_coverage")

# Datset Descriptions ----------------------------------------------------------

t.dataset_overview = read.csv(paste0(current_dir_data,
                               '/Data/TRE_dataset_overview.csv')) 


dataset_desc <- read.csv(paste0(current_dir_data,'/Data/TRE_dataset_descriptions.csv'))


linkage = read.csv(paste0(current_dir_data,'/Data/linkage.csv'))



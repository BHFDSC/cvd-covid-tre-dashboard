library(tidyverse)


current_dir_data = dirname(rstudioapi::getSourceEditorContext()$path)

# TRE Dataset Provisioning Dashboard
t.dataset_dashboard = read.csv(paste0(current_dir_data,'/Data/TRE_dataset_provisioning_dashboard.csv'))

datasets_available = t.dataset_dashboard %>%
  mutate(across(everything(), .fn=~str_trim(.,side="both")))

# Test Dataset using GDPPR Date and HES AE
t.monthly_grouped_gdppr_date = read.csv(paste0(current_dir_data,'/Data/monthly_grouped_gdppr_date.csv')) %>% 
  mutate(freq="Monthly") %>% rename(date=date_m)
t.weekly_grouped_gdppr_date = read.csv(paste0(current_dir_data,'/Data/weekly_grouped_gdppr_date.csv')) %>% 
  mutate(freq="Weekly") %>% rename(date=date_w)
t.monthly_grouped_hes_ae = read.csv(paste0(current_dir_data,'/Data/monthly_grouped_hes_ae.csv')) %>% 
  mutate(freq="Monthly") %>% rename(date=date_m)
t.weekly_grouped_hes_ae = read.csv(paste0(current_dir_data,'/Data/weekly_grouped_hes_ae.csv')) %>% 
  mutate(freq="Weekly") %>% rename(date=date_w)

test_dataset_static = t.monthly_grouped_gdppr_date %>%
  bind_rows(t.weekly_grouped_gdppr_date) %>%
  bind_rows(t.monthly_grouped_hes_ae) %>%
  bind_rows(t.weekly_grouped_hes_ae) %>%
  mutate(date_format = if_else(freq=="Monthly",as.Date(paste(date_y, date, 1, sep="-"), "%Y-%m-%d"),
                       if_else(freq=="Weekly",as.Date(paste(date_y, date, 1, sep="-"), "%Y-%U-%u"),
                              as.Date(NA)))) %>%
  mutate(date_name = if_else(freq=="Weekly",
                             paste0("Week ",date,": "),
                             if_else(freq=="Monthly",
                                     paste0(month.name[date],": "),
                                     as.character(NA))))



# TRE Data Dictionary
t.data_dictionary = readxl::read_excel((paste0(current_dir_data,'/Data/TRE_DD_391419_j3w9t.xlsx')))
data_dictionary = read_excel_allsheets(paste0(current_dir_data,
                                              '/Data/TRE_DD_391419_j3w9t.xlsx'), tibble = FALSE, except_sheet_no = 1, skip = 2)

dataset_desc <- read.csv(paste0(current_dir_data,'/Data/TRE_dataset_descriptions_test.csv'))

                                       
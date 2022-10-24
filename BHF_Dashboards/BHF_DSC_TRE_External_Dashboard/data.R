library(tidyverse)

current_dir_data = '/Users/fionnachalmers/Documents/github/BHF_TRE_Dashboard_External'
#dirname(rstudioapi::getSourceEditorContext()$path)

# TRE Dataset Provisioning Dashboard
t.dataset_dashboard = read.csv(paste0(current_dir_data,'/Data/TRE_dataset_provisioning_dashboard.csv'))

datasets_available = t.dataset_dashboard %>%
  mutate(across(everything(), .fn=~str_trim(.,side="both")))

# Test Dataset using GDPPR Date and HES AE
t.monthly_grouped_gdppr_date = read.csv(paste0(current_dir_data,'/Data/monthly_grouped_gdppr_date.csv')) %>% mutate(freq="Monthly") %>% rename(date=date_m)
t.weekly_grouped_gdppr_date = read.csv(paste0(current_dir_data,'/Data/weekly_grouped_gdppr_date.csv')) %>% mutate(freq="Weekly") %>% rename(date=date_w)
t.monthly_grouped_hes_ae = read.csv(paste0(current_dir_data,'/Data/monthly_grouped_hes_ae.csv')) %>% mutate(freq="Monthly") %>% rename(date=date_m)
t.weekly_grouped_hes_ae = read.csv(paste0(current_dir_data,'/Data/weekly_grouped_hes_ae.csv')) %>% mutate(freq="Weekly") %>% rename(date=date_w)

test_dataset_static = t.monthly_grouped_gdppr_date %>%
  bind_rows(t.weekly_grouped_gdppr_date) %>%
  bind_rows(t.monthly_grouped_hes_ae) %>%
  bind_rows(t.weekly_grouped_hes_ae)
  


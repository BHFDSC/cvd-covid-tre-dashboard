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
#t.data_coverage = read_rds("Data/data_coverage")

t.data_coverage_source = read.csv('Data/export_dashboard_NHSD_20221102_data_coverage.csv')

t.data_coverage = t.data_coverage_source %>% # as.data.frame() %>% 
  mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
  #remove null dates
  filter(!is.na(date_ym)) %>%
  separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
  mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
  #remove future dates > this year + 1 (to reduce file size)
  filter(date_y <= (as.numeric(format(Sys.Date(), "%Y"))+1)) %>%
  #expand to include all dates in between where counts=0
  group_by(dataset) %>%
  expand(date_y=min(date_y):max(date_y),date_m=1:12) %>%
  ungroup() %>%
  mutate(date_ym = paste0(str_pad(date_y,width=4,pad=0,side="left"),
                          "-",
                          str_pad(date_m,width=2,pad=0,side="left"))) %>%
  left_join(t.data_coverage_source, by = c("date_ym","dataset")) %>%
  mutate(across(.cols = starts_with('n'),
                .fn = ~ replace_na(.,0))) %>%
  group_by(dataset) %>%
  arrange(dataset,date_y,date_m) %>%
  mutate(across(.cols = starts_with("n"),
                .names = "{.col}_cum",
                .fn = ~ cumsum(.))) %>%
  filter(!if_all(ends_with("cum"), ~ . == 0)) %>%
  select(!ends_with("cum")) %>%
  #date month names for plot annotation
  mutate(date_name = paste0(month.name[date_m]," ", date_y, ": ")) %>%
  mutate(date_name_season = paste0(date_y, ": ")) %>%
  mutate(date_m_name = paste0(month.name[date_m])) %>%
  pivot_longer(cols=starts_with("n"), names_to="Type",values_to="N") %>%
  mutate(date_format = as.Date(paste(date_ym, 1, sep="-"), "%Y-%m-%d"))

# Dataset Overview -------------------------------------------------------------
t.dataset_overview = read.csv('Data/export_dashboard_NHSD_20221108_date_overview.csv')

# Dataset Overview -------------------------------------------------------------
t.dataset_completeness = read.csv('Data/export_dashboard_NHSD_20221108_data_completeness.csv')







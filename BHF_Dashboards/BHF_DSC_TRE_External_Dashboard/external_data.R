#current_dir_data = dirname(rstudioapi::getSourceEditorContext()$path)
update_date = as.Date("2023-09-12")
#update_date_string = paste(toOrdinal::toOrdinal(lubridate::mday(update_date)),months(update_date),lubridate::year(update_date))
update_date_string = paste(months(update_date),lubridate::year(update_date))


# Current Dataset Names --------------------------------------------------------

#England
export_date_england = "2023-09-11"
completeness_dataset_name_england = "export_dashboard_NHSD_20230911_data_completeness"
coverage_dataset_name_england = "export_dashboard_NHSD_20230911_data_coverage"
overview_dataset_name_england = "export_dashboard_NHSD_20230911_data_overview"
substr(export_date_england,1,4)
substr(export_date_england,6,7)

#Scotland
export_date_scotland = "2023-08-11"
completeness_dataset_name_scotland = "export_dashboard_scotland_completeness20230811"
coverage_dataset_name_scotland = "export_dashboard_scotland_coverage20230811"
overview_dataset_name_scotland = "export_dashboard_scotland_overview20230811"

#Wales
export_date_wales = "2023-08-09"
completeness_dataset_name_wales = "export_dashboard_SAIL_20230809_data_completeness"
coverage_dataset_name_wales = "export_dashboard_SAIL_20230809_data_coverage"
overview_dataset_name_wales = "export_dashboard_SAIL_20230809_data_overview"



# TRE Dataset Provisioning Dashboard -------------------------------------------
nation_exports = data.frame(Nation=c("England","Scotland","Wales"),
                               exported=c(export_date_england,export_date_scotland,export_date_wales))
  
  
  
t.dataset_dashboard = read.csv('Data/TRE_dataset_link.csv')

datasets_available = t.dataset_dashboard %>%
  mutate(across(-c("Description"), .fn=~str_trim(.,side="both"))) %>%
  mutate(across(everything(), .fn=~na_if(.,""))) %>%
  filter(!is.na(Dataset)) %>%
  filter(!is.na(Title)) %>%
  filter(!Key=="Dataset requested") %>%
  left_join(nation_exports)

# TRE Data Dictionary ----------------------------------------------------------

#England------------------------------------------------------------------------
t.data_dictionaryEng = read_excel_allsheets('Data/TRE_DD_391419_j3w9t.xlsx',
                                       tibble = FALSE,
                                       sheets_to_remove = c("Home","Reference Data"),
                                       skip = 2) %>%
  mutate(table = str_replace(table, paste0("_", path),"")) %>%
  mutate(table = str_replace(table,"deaths" ,"death")) %>%
  mutate(table = str_replace(table,"_[{]fyear[}]" ,"")) %>%
  filter(!is.na(table)) %>%
  select(-1) %>%
  rename(`field` = display_name,
         `field name` = display_name_label,
         `field description` = field_description,
         `field type` = variable_type,
         `variable_type` = data_type
         #`x` = gdppr
  ) %>%
  mutate(database='dars_nic_391419_j3w9t') %>%
  mutate(field=ifelse(str_starts(table,"iapt_"),str_to_lower(field),field))




#Scotland------------------------------------------------------------------
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

# Merging 
t.data_dictionaryScot = t.data_dictionaryScot %>%
  dplyr:: bind_rows() 
  
# and removing dictionaries for not needed tables   
t.data_dictionaryScot = as.data.frame(t.data_dictionaryScot ) %>% 
  filter( (str_to_lower(t.data_dictionaryScot$table) %in% str_to_lower(datasets_available$table) ) ) %>% 
  filter( !is.na(Type)) %>% 
  select(where(not_all_na)) %>% 
  select( -"For Processing only? Y/N") %>% 
  rename(`field` =  "Source Variable Name",
         `field name` = "Variable Name Provided",
         `field description` = Description,
         `field type` = Type ) %>% 
  relocate( "field", .before = "field name") %>% 
  relocate( "field description", .before = "field type" ) %>% 
  relocate( "Derived" , .after = "Comments") %>%
  mutate(field=stringr::str_to_lower(field))


# Wales-------------------------------------------------------------------
# pathfornow = "C:/Users/LarsMurdock/Documents/Repo/BHF_DSC_HDS/BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Data/DD_Wales.xlsx"

t.data_dictionaryWales = read_excel_allsheets( # pathfornow, 
  "Data/DD_Wales.xlsx")

# Dataset Overview -------------------------------------------------------------
t.dataset_overview_eng = read.csv(paste0('Data/',overview_dataset_name_england,'.csv')) %>% mutate(dataset=ifelse(dataset=="deaths","death",dataset))
t.dataset_overview_wales = read.csv(paste0('Data/',overview_dataset_name_wales,'.csv'))
t.dataset_overview_scotland = read.csv(paste0('Data/',overview_dataset_name_scotland,'.csv')) %>%
  mutate(archived_on=as.Date(substr(archived_on,1,10)))


# Dataset Completeness -------------------------------------------------------------
t.dataset_completeness_eng = read.csv(paste0('Data/',completeness_dataset_name_england,'.csv')) %>% mutate(dataset=ifelse(dataset=="deaths","death",dataset)) %>%
  mutate(column_name_temp = str_to_lower(column_name))
t.dataset_completeness_wales = read.csv(paste0('Data/',completeness_dataset_name_wales,'.csv'))
t.dataset_completeness_scotland = read.csv(paste0('Data/',completeness_dataset_name_scotland,'.csv'))

#update DD for misaligned MSDS fieds
t.data_dictionaryEng = t.data_dictionaryEng %>%
  left_join((t.dataset_completeness_eng%>%select(-completeness)%>% 
               mutate(dataset=str_remove(dataset,"_all_years")))
            ,by=c("table"="dataset","field"="column_name_temp")) %>%
  mutate(field = ifelse(table%in%c("msds_care_activities","msds_demographics_booking_and_pregnancy","msds_hospital_provider_spell"),column_name,field)) %>%
  select(-column_name)

# # Data Coverage Pre Processed from data_preprocessing -------------------



# Data Coverage Pre Processed from data_preprocessing
#t.data_coverage = read_rds("Data/data_coverage")
#folderpath = "C:/Users/LarsMurdock/Documents/Repo/BHF_DSC_HDS/BHF_Dashboards/BHF_DSC_TRE_External_Dashboard"


t.dataset_coverage_eng = read.csv(paste0('Data/',coverage_dataset_name_england,'.csv')) %>% filter(date_ym!='null') %>% select(-archived_on) %>% 
  mutate(Nation2 = "England") %>% mutate(dataset=ifelse(dataset=="deaths","death",dataset))
t.dataset_coverage_wales = read.csv(paste0('Data/',coverage_dataset_name_wales,'.csv')) %>% rename(n_id_distinct =n_distinct ) %>% mutate(Nation2 = "Wales")
t.dataset_coverage_scotland = read.csv(paste0('Data/',coverage_dataset_name_scotland,'.csv')) %>% mutate(Nation2 = "Scotland")



t.data_coverage_source = t.dataset_coverage_eng %>%
  rbind(t.dataset_coverage_wales) %>%
  rbind(t.dataset_coverage_scotland) %>% 
  as.data.frame() %>%   
  mutate(date_ym_reformat = ifelse(str_detect(date_ym,"-"),1,ifelse(date_ym=="","",0))) %>%
  mutate(date_ym = ifelse(date_ym_reformat==0,str_pad(date_ym,6,side="left",pad=0),date_ym)) %>%
  mutate(date_ym = ifelse(date_ym_reformat==0,paste0(substr(date_ym,1,4),"-",substr(date_ym,5,6)),date_ym)) %>%
  select(-date_ym_reformat)

t.data_coverage = t.data_coverage_source %>%
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
  mutate(across(.cols = starts_with('n', ignore.case = FALSE),
                .fn = ~ replace_na(.,0))) %>%
  group_by(dataset) %>%
  arrange(dataset,date_y,date_m) %>%
  mutate(across(.cols = starts_with("n", ignore.case = FALSE),
                .names = "{.col}_cum",
                .fn = ~ cumsum(.))) %>% 
  filter(!if_all(ends_with("cum"), ~ . == 0)) %>% 
  select(!ends_with("cum")) %>%
  #date month names for plot annotation
  mutate(date_name = paste0(month.name[date_m]," ", date_y, ": ")) %>%
  mutate(date_name_season = paste0(date_y, ": ")) %>%
  mutate(date_m_name = paste0(month.name[date_m])) %>%
  pivot_longer(cols=starts_with("n", ignore.case = FALSE), names_to="Type",values_to="N") %>%
  mutate(date_format = as.Date(paste(date_ym, 1, sep="-"), "%Y-%m-%d"))





# Dataset Coverage Custom Messages -------------------------------------------------------------
coverage_render_messages = datasets_available %>%
  filter(coverage==1) %>%
  select(Dataset) %>%
  pull(Dataset)

# Dataset DD Custom Messages -------------------------------------------------------------
dd_render_messages = datasets_available %>%
  filter(dictionary==1) %>%
  select(Dataset) %>%
  pull(Dataset)


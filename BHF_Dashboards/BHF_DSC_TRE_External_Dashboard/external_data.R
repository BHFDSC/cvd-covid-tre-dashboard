#current_dir_data = dirname(rstudioapi::getSourceEditorContext()$path)

# Current Dataset Names --------------------------------------------------------

#England
export_date_england = "2022-11-29"
completeness_dataset_name = "export_dashboard_NHSD_20221108_data_completeness"
coverage_dataset_name = "export_dashboard_NHSD_20221102_data_coverage"
overview_dataset_name = "export_dashboard_NHSD_20221108_date_overview"

#Scotland
export_date_scotland = "2022-11-26"

#Wales
export_date_wales = "2022-11-21"


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
                                       except_sheet_no = 1,
                                       skip = 2) %>%
  mutate(table = str_replace(table, paste0("_", database),"")) %>%
  mutate(table = str_replace(table,"_[{]fyear[}]" ,"")) %>%
  filter(!is.na(table))

# just doing a super basic change of column names here until the extra column issue is solved
colnames(t.data_dictionaryEng) <- c("database", "table", "field", "field name", "field description", "field type",
                                    "data type", "units", "values", "notes", "links", "x")

# duplicating in case there are any downstream chunks depending on the name 'data_dictionary'
# data_dictionary <- t.data_dictionaryEng


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

# Merging and removing blank rows  
t.data_dictionaryScot = t.data_dictionaryScot %>% 
  dplyr:: bind_rows() %>% 
  filter( !is.na(Type))


# Wales-------------------------------------------------------------------
# pathfornow = "C:/Users/LarsMurdock/Documents/Repo/BHF_DSC_HDS/BHF_Dashboards/BHF_DSC_TRE_External_Dashboard/Data/DD_Wales.xlsx"

t.data_dictionaryWales = read_excel_allsheets( # pathfornow, 
  "Data/DD_Wales.xlsx")



# # Data Coverage Pre Processed from data_preprocessing -------------------



# Data Coverage Pre Processed from data_preprocessing
#t.data_coverage = read_rds("Data/data_coverage")

t.data_coverage_source = read.csv(paste0('Data/',coverage_dataset_name,'.csv'))

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
t.dataset_overview = read.csv(paste0('Data/',overview_dataset_name,'.csv'))

# Dataset Overview -------------------------------------------------------------
t.dataset_completeness = read.csv(paste0('Data/',completeness_dataset_name,'.csv'))

# Landing page static text ------------------------------------------------

Static_text <- read_excel("Data/Static text.xlsx", col_names = FALSE, sheet = "Landing")
landing_page_text <- as.character(Static_text[1,1])
landing_page_text <- landing_page_text %>% str_replace_all(. , "\n", " <br> ")

# Methodology static text ------------------------------------------------

Methodology_DD_Header1 <- as.character(
  read_excel(
    "Data/Static text.xlsx", col_names = FALSE, sheet = "Methodology_DD_Header1"
    )[1,1]
) %>% str_replace_all(. , "\r", "") %>% 
  str_replace_all(. , "\n", " <br> ")



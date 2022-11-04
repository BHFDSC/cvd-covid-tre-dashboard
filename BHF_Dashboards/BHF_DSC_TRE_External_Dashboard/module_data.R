# Module Server    
dataServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {

global_test_dataset_static =  reactive({
  t.data_coverage %>%
  filter(.data$dataset==dataset_summary()) %>%
  mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
  #remove null dates
  filter(!is.na(date_ym)) %>%
  separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
  mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
  #expand to include all dates in between where counts=0
  group_by(.data$dataset) %>%
  expand(date_y=min(date_y):max(date_y),date_m=1:12) %>%
  ungroup() %>%
  mutate(date_ym = paste0(str_pad(date_y,width=4,pad=0,side="left"),
                          "-",
                          str_pad(date_m,width=2,pad=0,side="left"))) %>%
  left_join(t.data_coverage, by = c("date_ym","dataset")) %>%
  mutate(across(.cols = starts_with('n'),
                .fn = ~ replace_na(.,0))) %>%
  group_by(.data$dataset) %>%
  arrange(dataset,date_y,date_m) %>%
  mutate(across(.cols = starts_with("n"),
                .names = "{.col}_cum",
                .fn = ~ cumsum(.))) %>%
  filter(!if_all(ends_with("cum"), ~ . == 0)) %>%
  #date month names for plot annotation
  mutate(date_name = paste0(month.name[date_m]," ", date_y, ": ")) %>%
  pivot_longer(cols=starts_with("n"), names_to="Type",values_to="N") %>%
  mutate(date_format = as.Date(paste(date_y, date_m, 1, sep="-"), "%Y-%m-%d"))})

return(global_test_dataset_static)

    }
)

}



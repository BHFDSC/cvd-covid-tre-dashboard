#Ref: https://stackoverflow.com/questions/32852388/jquery-datatables-no-data-available-in-table
#Sometimes data not rendering with no data available in table error - have invcluded JS in bhf_dsc_desgin.js to attempt a fix

dataDictionaryUI <- function(id){
  ns <- NS(id)
  tagList(
    
    #possible solution to the no data available - refresh
    # div(
    #     use_hover(),
    #     hover_action_button(
    #       inputId = "refresh_dd",
    #       label = "",
    #       icon = icon("refresh"),
    #       width='40px',
    #       icon_animation = "spin"
    #     )),
    
    fluidRow(column(12,
                    
    reactableOutput(ns("tbl")),
    
    downloadButton(ns("download_dd"),
                                   label="Export Data",
                                   icon = icon("file-excel"))
    ))
    
  )
}

dataDictionaryServer <- function(id, dataset_summary, nation_summary){
  moduleServer(
    id,
    function(input, output, session){
      
      grouped_datasets = datasets_available %>% filter(Dataset != dataset_dataset) %>%
        distinct(Dataset) %>%
        pull(Dataset)
      
## England and Scotland reactive  - designed for table format
      data_dict = reactive({
        
        
        validate(need(dataset_summary() ,
                      message = FALSE))
        
        if(nation_summary() == "Scotland"){
          t.data_dictionaryScot %>% 
            left_join(select(datasets_available, c("table","Dataset")), by=c("table")) %>%
            filter(Dataset == dataset_summary())  %>%
            select(-Dataset, -table)  %>% 
            select_if(~!(all(is.na(.)) | all(. == "")))
        }
        
        else if(nation_summary() == "Wales" ){
          t.data_dictionaryWales %>% 
            left_join(select(datasets_available, c("table","Dataset")), by=c("table"))  %>% 
            filter(Dataset == dataset_summary()) %>%
            select(-Dataset, -table) 
          
        }

        
        else if(nation_summary() == "England" ){
          t.data_dictionaryEng %>%
            select("table") %>%
            left_join(select(datasets_available, c("table","Dataset","Title","title_dataset","dataset_dataset")),
                      by=c("table")) %>%
            filter(Dataset == dataset_summary()) %>%
            select(-Dataset) %>%
            distinct() %>%
            mutate(Dataset = ifelse(Title==title_dataset, NA, title_dataset)) %>%
            select(-Title,-title_dataset) %>%
            select(where(not_all_na)) %>%
            left_join(t.data_dictionaryEng, by = "table") %>%
            select(-table,-database,-x,-dataset_dataset)
        }
        
      })
      
      

      data_dict_react = reactive({

        reactable(
          data = if(dataset_summary() %in% grouped_datasets){
            data_dict() %>%
              group_by(Dataset) %>%
              rename_with(str_to_title) %>%
              mutate(Position = row_number()) %>%
              ungroup() %>%
              relocate(Position)} else {
                data_dict() %>%
                  rename_with(str_to_title) %>%
                  mutate(Position = row_number()) %>%
                  relocate(Position)
              },
          
          groupBy = if(dataset_summary() %in% grouped_datasets){"Dataset"} else {NULL},
          paginateSubRows = TRUE,
          
          class = "my-tbl",
          columns = list(
            Position = colDef(style = list(whiteSpace = "nowrap", textOverflow = "unset")),
            Dataset = colDef(minWidth = 400),
            Field = colDef(minWidth = 200),   # 50% width, 200px minimum
            `Field Name` = colDef(minWidth = 200),   # 25% width, 100px minimum
            `Field Description` = colDef(minWidth = 200)  # 25% width, 100px minimum
          ),

      
          showSortable = TRUE,
          defaultColDef = colDef(
            align = "left",
            minWidth = 100,
            headerStyle = list(background = colour_bhf_darkred, height = 60, color="white", overflow = "visible")
          ),
          
    

          striped = TRUE,
          wrap = FALSE,
          searchable = TRUE,
          
          highlight = TRUE,
          
          minRows = 5,
          showPageSizeOptions = TRUE,
          defaultPageSize = 5,
          pageSizeOptions = c(5, 10, 20, nrow(data_dict())),
          #paginationType = "jump",
          onClick = "expand"
        )

      })
      
      
      output$tbl = renderReactable(data_dict_react())
      
      
      output$download_dd = downloadHandler(
        filename = function() {paste0("data_dictionary_",str_remove_all(Sys.Date(),"-"),".xlsx")},
        content = function(file) {writexl::write_xlsx(
          (data_dict() %>%
             rename_with(str_to_title) %>%
             mutate(dataset = dataset_summary()) %>%
             mutate(export_date = Sys.Date())),
          
          format_headers = FALSE,
          path=file)}
      )
      
    }
  )
}
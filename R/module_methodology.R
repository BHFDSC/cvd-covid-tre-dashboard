#Outputs
methodologyOutput <- function(id){
  ns <- NS(id)
  
  tagList(
    
      # fluidRow(
      # column(12,style=appendix_css,
      #  
      #  h4("Holding Text"),
      #  h5("Sub Title",style="padding-bottom:4px;"),
      #  p(span("Some text: ", style = "font-weight: bold;"),
      #    "as an example",
      #    style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
      #  p(span("blah blah", style = "font-weight: bold;"),
      #    "and blah",
      #    style=paste0("color:,",colour_bhf_darkred,";margin-bottom:2px;")),
      # ),
      # )
    
    wellPanel(style = "background: white; border-color: white;padding:50px;",
    
    tabsetPanel(
      # tabPanel(
      #   title = "Data Updates",
      #   value = "dup_meth",
      #   wellPanel(style = bhf_tab_panel_style,
      #             tags$h4("Header 1", style="margin-top:-0.1%;"),
      #             tags$p(
      #               "Some holding text."
      #             ),
      # 
      #   )),
      # tabPanel(
      #   title = "Data Dictionary",
      #   value = "dd_meth",
      #   id = "dd_css",
      #   wellPanel(style = bhf_tab_panel_style,
      #   tags$h4("Header 1", style="margin-top:-0.1%;"),
      #   tags$p(
      #     "Some holding text about curation of the data dictionary."
      #   ),
      #   tags$h4("Header 2"),
      #   tags$p(
      #     "Some more information.",
      #     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      #   ),
      # )),
      tabPanel(
        title = "Data Coverage",
        value = "dcov_meth",
        wellPanel(style = bhf_tab_panel_style,
        tags$h4("Date Field Selection", style="margin-top:2px;"),
        tags$p(
          "Datasets can contain multiple date fields. For each dataset we have derived monthly counts of the number of records, records with a PERSON ID, and Distinct PERSON ID, using the date field that is most complete, and that we believe best reflects the time-period covered by the dataset and is of most use and interest to researchers. For example, for our Primary Care datasets we have used the date field that relates to when an event occurred (DATE) rather than when it was recorded in the GP practice systems (RECORD_DATE)."
        ),
        tags$h4("Extreme Dates"),
        tags$p(
          "Datasets can contain extreme dates that are outside feasible ranges. For example, future dates, or historic dates prior to the known start of data coverage, arising from input error, system default dates (for unknown or missing dates) or other reasons.
          These dates have been included in the underlying data that feeds the dashboard. By default, extreme dates (dates < 1900 and those in the future) are not shown on the Data Coverage plot, but can be seen by selecting the “Show Extreme Dates” switch on the plot panel menu.
      "
        ),
        tags$h4("Suppression"),
        tags$p(
          "The following data suppression rules have been applied to the data:",
          tags$ul(
            tags$li("All numbers less than 10 have been set to 10."), 
            tags$li("All numbers greater than 10, have been rounded to the nearest 5.")
          ))
        

)),
      tabPanel(
        title = "Data Completeness",
        value = "dcom_meth",
        wellPanel(style = bhf_tab_panel_style,
        tags$h4("Definition", style="margin-top:2px;"),
        tags$p(HTML(
          
  "A record for a given variable is deemed to be complete if it contains a non-null and non-blank value. This is a definition that can be applied easily and consistently to all variables across datasets, and is intended to provide a quick overview of data completeness. For a complete understand of a variable’s completeness, quality and utility an in-depth analysis of the individual field would be required."
        )),
        tags$h4("Limitations"),
  tags$p(HTML(
    
    "
    There are some limitations of this definition as outlined below:
    <ul>
  <li>Variables that take text values such as “9. Unknown” will be classed as complete, which will result in the completeness plot showing a higher proportion of complete records than would be generally useable in research. Similarly, code terminology fields (ICD-10, SNOMED-CT,…) can contain codes that don’t provide meaningful information (e.g. ICD10 code: R69 – “Unknown and unspecified causes of morbidity”). An ICD10 code field populated with this code would be classed as complete.</li>
  <li>Some fields we would not expect to be 100% complete, as they are only eligible to be complete under certain circumstances. For example, for Year of Death in primary care data the completeness is calculated as a % of all records, not just records for deceased patients. Similarly, a field that can only be completed when an earlier field takes a specific value (e.g., in NICOR MINAP dataset, REFERRING_HOSPITAL will only be available if ADMISSION_METHOD takes value “4. Inter-hospital transfer for specific treatment”) may result in the completeness plot showing a much lower proportion of complete records for this particular field because completeness has been calculated with reference to the total number of records, rather than the subset of records that are applicable in this case. </li>

  </ul>

  It is worth noting that completeness is calculated at a record level, rather than patient level. It might be possible to obtain a higher proportion of completeness for a given variable at a patient level, by looking across all patient records in the dataset.
<br><br>
Similarly, completeness for an individual variable in a dataset might be lower than what can be achieved through the harmonisation and linkage of multiple datasets. For example, projects making use of linked data generally derive patient characteristics such as Age, Gender, and Ethnicity from multiple sources rather than an individual dataset to maximise completeness.

  
  "
  ))
        )),
    )
      
      
  )
  )
  
}


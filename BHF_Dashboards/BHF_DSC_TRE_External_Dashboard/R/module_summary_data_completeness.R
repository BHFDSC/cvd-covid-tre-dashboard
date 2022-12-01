dataCompletenessUI <- function(id){
  ns <- NS(id)
  tagList(
   
    fluidRow(

      # Inputs -----------------------------------------------------------------
      column(3,
             
             # div(id="complete_checkbox",class="complete_checkbox",
             # prettyRadioButtons(
             #   inputId = ns("order_complete"),
             #   shape = "curve",
             #   label = "Order:",
             #   selected = "value",
             #   choices = c("Alphabetically"="alpha", "Value"="value"))),

             radioButtons(
               inputId = ns("order_complete"),
               label = "Order:",
               selected = "value",
               choices = c("Alphabetically"="alpha", "Value"="value")),
             
             fluidRow(column(12,
             downloadButton(outputId = ns("download_summary_completeness_plot"), 
                                             label = "Download PNG",
                                             icon = icon("file-image")))),
             
             fluidRow(column(12,
             downloadButton(ns("download_coverage_data"), 
                            label="Export Data",
                            icon = icon("file-excel"))))
             ),
      # Outputs ----------------------------------------------------------------
      column(9,
             girafeOutput(ns("completeness_plot_girafe"), height='100%'))
             ))

}


   
dataCompletenessServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {
      
      completeness_title_download = reactive({paste("Data Completeness - ", pull(filter(t.dataset_dashboard,Dataset==dataset_summary()),Title))})

      # pull the variable names from a chosen dataset to use as test data
      completeness_test_data = reactive({t.dataset_completeness %>%
          filter(dataset == dataset_summary()) %>%
          mutate(column_name = trimws(column_name)) %>%
          mutate(completeness = round(completeness*100,2)) %>%
          mutate(completeness_tooltip = paste0(column_name, ": ",format(.data$completeness, nsmall=0, big.mark=",", trim=TRUE),"%")) %>%
          arrange(desc(completeness),column_name) %>%
          mutate(value_name_order = row_number()) %>%
          #for alpha order ensure numeric columns ordered correctly too
          mutate(column_name_rev = stringi::stri_reverse(column_name)) %>%
          separate(column_name_rev, into="num", remove=FALSE) %>%
          mutate(num = as.numeric(stringi::stri_reverse(num))) %>%
          mutate(column_name_order = ifelse(is.na(num),column_name,
                                            stringi::stri_reverse(split_occurrence(column_name_rev,sep="_",n=1,keep="rhs")))) %>%
          arrange(column_name_order,num) %>%
          mutate(column_alpha_order = row_number()) %>%
          #reset order for colour palette
          arrange(desc(completeness),column_name)
      })
      
      #colour gradient
      colorCompleteness = colorRampPalette(c("#94409F", "#BC366C", "#E1324C", "#F82D2E", "#FC7F47", "#FEB958"))
      
      colour_palette = reactive({completeness_test_data() %>% 
        distinct(completeness) %>% bind_cols(
          tibble(colours = colorCompleteness(nrow(completeness_test_data() %>% distinct(completeness))))) %>%
        left_join(select(completeness_test_data(),c(completeness,column_name)),by = "completeness")})
      
      colour_values = reactive({
        setNames(
          pull(select(colour_palette(),colours)),
          pull(select(colour_palette(),column_name))
        )
      })
      
      
      completeness_plot = reactive({ ggplot(data=completeness_test_data(),
                                                     aes(
                                                       if(input$order_complete=="alpha"){
                                                         #x=forcats::fct_rev(reorder(column_name,column_name))
                                                         x=forcats::fct_rev(reorder(column_name,column_alpha_order))
                                                         } else {x=reorder(column_name, desc(value_name_order))}, 
                                                     y=completeness,
                                                     fill = column_name,
                                                     tooltip = completeness_tooltip,
                                                     data_id = column_name)) +
          geom_bar_interactive(stat="identity"
                               , size = 0.35
                               , width=0.9
                               ) +
          coord_flip(clip = 'off')  +
          labs(x=""
               ,y=""
               ) +
          scale_fill_manual(values = alpha(colour_values(),0.9)) +
          scale_y_continuous(
                             labels = function(i) {return(paste0(i,"%"))}) +
        
          theme(
            text=element_text(family=family_lato),
            plot.subtitle = element_markdown(size = 11, lineheight = 1.2),
            legend.position = "none",
            plot.title.position = 'plot', #align to outer margin; applies to subtitle too
            #panel.grid.minor = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            axis.ticks.y = element_blank(),
            axis.text.x = element_text(size = 6, face = "bold"),
            axis.text.y = element_text(size = if(nrow(completeness_test_data())>=20){3.5}else{4.5}, hjust = 1),
            axis.ticks.x = element_blank(),
            plot.margin = margin(0,0,0,0)
          ) 
      })
      
  
      
      output$completeness_plot_girafe = renderGirafe({
        ggiraph::girafe(ggobj = completeness_plot(),
                        
                        options = list(opts_hover(css = ""), #want shape to inherit the underlying aes on hover whilst other shapes go inv
                                       opts_hover_inv(css = "opacity:0.3;"),
                                       opts_sizing(rescale = TRUE, width = 1),
                                       opts_tooltip(
                                         opacity = .95,
                                         css = "background-color:#EC2154;
            color:white;font-size:10pt;font-style:italic;
            padding:5px;border-radius:10px 10px 10px 10px;"
                                       ),
            opts_toolbar(saveaspng = FALSE),
            opts_selection(type="none")),
            
            height_svg = (
              if (nrow(completeness_test_data()) >= 150) {
                10
              }
              else if (nrow(completeness_test_data()) < 150 & nrow(completeness_test_data()) >= 120) {
                8
              }
              else if (nrow(completeness_test_data()) < 120 & nrow(completeness_test_data()) >= 100) {
                6
              }
              else if (nrow(completeness_test_data()) < 100 & nrow(completeness_test_data()) >= 80) {
                5
              }
              else if (nrow(completeness_test_data()) < 80 & nrow(completeness_test_data()) >= 20) {
                4
              }
              else if (nrow(completeness_test_data()) < 20 & nrow(completeness_test_data()) >= 15) {
                3.5
              }
              else if (nrow(completeness_test_data()) < 15 & nrow(completeness_test_data()) >= 10) {
                3
              }
              else if (nrow(completeness_test_data()) < 10 & nrow(completeness_test_data()) >= 5) {
                2
              }
              else if (nrow(completeness_test_data()) < 5 & nrow(completeness_test_data()) >= 3) {
                1.5
              }
              else {
                1.2
              }
            )
            #width_svg  = 9
            
            )
      })
      
  
      
      output$download_summary_completeness_plot = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".png")},
        content = function(file) {ggsave(file, 
                                         plot = (completeness_plot() +
                                           ggtitle(completeness_title_download()) +
                                            geom_text(aes(label = paste(.data$completeness,"%")),
                                                      vjust = 0.6, hjust = -0.3, size = if(nrow(completeness_test_data())>=20){4}else{5}, color="#4D4C4C") +
                                           theme(plot.margin = margin(20,50,20,50),
                                                 axis.text.x = element_text(size = 18, face = "bold"),
                                                 axis.text.y = element_text(size = if(nrow(completeness_test_data())>=20){12}else{18}, face = "bold"),
                                                 axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0),
                                                                             face = "bold", size=18, color="#4D4C4C"),
                                                 plot.title.position = "plot", #left align title
                                                 plot.title = element_text(color="#4D4C4C", size=28,
                                                                           face = "bold", margin = margin(t = 6, r = 0, b = 16, l = 0)
                                                                           )
                                                 )),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         #width = 9, 
                                         units = "in",
                                         bg = "transparent",
                                         height = (
                                           if (nrow(completeness_test_data()) >= 150) {
                                             10
                                           }
                                           else if (nrow(completeness_test_data()) < 150 & nrow(completeness_test_data()) >= 120) {
                                             8
                                           }
                                           else if (nrow(completeness_test_data()) < 120 & nrow(completeness_test_data()) >= 100) {
                                             6
                                           }
                                           else if (nrow(completeness_test_data()) < 100 & nrow(completeness_test_data()) >= 80) {
                                             5
                                           }
                                           else if (nrow(completeness_test_data()) < 80 & nrow(completeness_test_data()) >= 20) {
                                             4
                                           }
                                           else if (nrow(completeness_test_data()) < 20 & nrow(completeness_test_data()) >= 15) {
                                             3.5
                                           }
                                           else if (nrow(completeness_test_data()) < 15 & nrow(completeness_test_data()) >= 10) {
                                             3
                                           }
                                           else if (nrow(completeness_test_data()) < 10 & nrow(completeness_test_data()) >= 5) {
                                             2
                                           }
                                           else if (nrow(completeness_test_data()) < 5 & nrow(completeness_test_data()) >= 3) {
                                             1.5
                                           }
                                           else {
                                             1.2
                                           }
                                         ),
                                         dpi = 300, device = "png")}
      )
      

      output$download_coverage_data = downloadHandler(
        filename = function() {paste0("data_completeness_",str_remove_all(Sys.Date(),"-"),".xlsx")},
        content = function(file) {writexl::write_xlsx(
          (completeness_test_data() %>%
            arrange(column_name) %>%
            left_join(t.dataset_dashboard %>% select(dataset=Dataset,title=Title)) %>%
            select(dataset,title,column_name,completeness) %>%
             mutate(export_date = Sys.Date())),
          
          format_headers = FALSE,
          path=file)}
      )

      
     
      
    }
  )
}






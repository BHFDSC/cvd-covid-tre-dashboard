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
             
             downloadButton(outputId = ns("download_summary_completeness_plot"), 
                                             label = "Download PNG",
                                             icon = icon("file-image"))
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
                               #, width=0.9
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
            plot.title = element_markdown(size = 11, lineheight = 1.2),
            plot.subtitle = element_markdown(size = 11, lineheight = 1.2),
            legend.position = "none",
            plot.title.position = 'plot', #align to outer margin; applies to subtitle too
            #panel.grid.minor = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            axis.ticks.y = element_blank(),
            axis.text.x = element_text(size = 8, face = "bold"),
            axis.text.y = element_text(size = 6, hjust = 1),
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
            
            width_svg  = 9
            
            )
      })
      
  
      
      output$download_summary_completeness_plot = downloadHandler(
        filename = function() {paste(Sys.Date(), "completeness.png")},
        content = function(file) {ggsave(file, plot = (completeness_plot()) + theme(plot.margin = margin(20,50,20,50)),
                                         #ensure width and height are same as ggiraph
                                         #width_svg and height_svg to ensure png not cut off
                                         width = 9, units = "in",
                                         bg = "transparent",
                                         dpi = 300, device = "png")}
      )
      
      
      
    }
  )
}






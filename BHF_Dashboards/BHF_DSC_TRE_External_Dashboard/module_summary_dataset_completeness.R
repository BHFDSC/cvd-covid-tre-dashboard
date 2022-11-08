# Module UI
datasetCompletenessUI <- function(id){
  ns <- NS(id)
  tagList(
  
    fluidRow(

      #Inputs - Plots

      column(3,
             
             prettyRadioButtons(
               inputId = ns("order_complete"),
               shape = "curve",
               label = "Order:",
               selected = "value",
               choices = c("Alphabetically"="alpha", "Value"="value")),
             
             downloadButton(outputId = ns("download_summary_completeness_plot"), 
                                             label = "Download PNG",
                                             icon = icon("file-image"))
             ),
      #Outputs
      column(9,
             girafeOutput(ns("completeness_plot_girafe")))
             ))

}


# Module Server    
datasetCompletenessServer <- function(id, dataset_summary, nation_summary) {
  moduleServer(
    id,
    function(input, output, session) {

      
      set.seed(1)
      # pull the variable names from a chosen dataset to use as test data
      completeness_test_data = reactive({data_dictionary %>%
          left_join(linkage, by=c("table"="dict")) %>%
          filter(.data$dataset==dataset_summary()) %>%
          #this will be reactive and table names need aligned to input table names in addition to the table names used when data downloaded from TRE in aggreagate
          select(display_name_label) %>%
          mutate(display_name_label = trimws(display_name_label)) %>%
          mutate(completeness = round(runif(nrow(.))*100,2)) %>%
          mutate(completeness_tooltip = paste(completeness,"%")) %>%
          arrange(desc(completeness))
      })
      
      #colour gradient
      colorCompleteness = colorRampPalette(c("#94409F", "#BC366C", "#E1324C", "#F82D2E", "#FC7F47", "#FEB958"))
      colour_values = reactive({
        setNames(
        colorCompleteness(nrow(completeness_test_data())),
        (completeness_test_data() %>% select(display_name_label) %>% pull())
        )
      })
      
      
      completeness_plot = reactive({ ggplot(data=completeness_test_data(),
                                                     aes(
                                                       if(input$order_complete=="alpha"){
                                                         x=forcats::fct_rev(reorder(display_name_label,display_name_label))
                                                         } else {x=reorder(display_name_label, completeness)}, 
                                                     y=completeness,
                                                     fill = display_name_label,
                                                     tooltip = completeness_tooltip,
                                                     data_id = display_name_label)) +
          geom_bar_interactive(stat="identity", width=0.9) +
          coord_flip(clip = 'off')  +
          labs(x=""
               ,y=""
               ) +
          scale_fill_manual(values = alpha(colour_values(),0.9)) +
          scale_y_continuous(
                             labels = function(i) {return(paste0(i,"%"))}) +
        
          theme(
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
            axis.text.y = element_text(size = 6),
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






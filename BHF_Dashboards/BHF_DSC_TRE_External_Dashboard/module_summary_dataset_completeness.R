# Module UI
datasetCompletenessUI <- function(id){
  ns <- NS(id)
  tagList(
    
    fluidRow(
      
      #Inputs - Plots
      column(3,checkboxInput(ns("test"), "Test")),
      #Ouputs
      column(9,girafeOutput(ns("completeness_plot_girafe"), height = "45%"))
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
          filter(table=="gdppr_dars_nic_391419_j3w9t") %>%
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
                                                       x=forcats::fct_rev(reorder(display_name_label,display_name_label)),
                                                       #x=reorder(display_name_label, completeness), 
                                                     y=completeness,
                                                     fill = display_name_label,
                                                     tooltip = completeness_tooltip,
                                                     data_id = display_name_label)) +
          geom_bar_interactive(stat="identity", width=0.9) +
          coord_flip(clip = 'off')  +
          labs(x=""
               ,y=""
               ) +
          scale_fill_manual(values = colour_values()) +
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
            axis.text.x = element_blank(),
            axis.text.y = element_text(size = 6),
            axis.ticks.x = element_blank(),
            plot.margin = margin(0,30,0,0)
          )
      })
      
  
      
      output$completeness_plot_girafe = renderGirafe({
        ggiraph::girafe(ggobj = completeness_plot(),
                        
                        options = list(opts_hover(css = ""), #want shape to inherit the underlying aes on hover whilst other shapes go inv
                                       opts_hover_inv(css = "opacity:0.3;"),
                                       #opts_sizing(rescale = FALSE),
                                       opts_tooltip(
                                         opacity = .95,
                                         css = "background-color:#EC2154;
            color:white;font-size:10pt;font-style:italic;
            padding:5px;border-radius:10px 10px 10px 10px;"
                                       ),
            opts_toolbar(saveaspng = FALSE),
            opts_selection(type="none"))
            
            )
      })
      
      
      # location_barplot = reactive({
      #   ggplot(location_data() 
      #          #%>% mutate(Name=str_pad(Name, 28, "left", pad="0"))
      #          ,
      #          aes(x = reorder(Name, count), 
      #              y = count,
      #              fill = as.factor(count),
      #              tooltip = count,
      #              data_id = Name
      #          )) +
      #     geom_col_interactive(size = 0.2) +
      #     theme_minimal() +
      #     scale_y_continuous(breaks=c(0,max(location_data()$count)), limits = c(0,500)) +
      #     #scale_x_discrete(labels = function(i){str_pad(i, 25, "left")}) +
      #     #scale_x_discrete(labels = function(i){format(i, width = 25, justify = "right")}) +
      #     scale_fill_manual(values=map_colours()) +
      #     theme(
      #       aspect.ratio = 1.7,
      #       panel.grid = element_blank(),
      #       plot.margin = margin(0,0,0,0),
      #       plot.background = element_rect(color=NA),
      #       panel.background = element_rect(color = NA),
      #       axis.ticks = element_blank(),
      #       axis.text.y = element_text(size = 5),
      #       axis.text.x = element_text(size = 6),
      #       legend.position = "none"
      #     ) +
      #     ylab("") +
      #     xlab("") +
      #     coord_flip()
      # })
      
      #Join plots together
      # location_plots_merge_girafe = reactive({location_sf() + location_barplot()})
      # 
      # output$location_plots_merge = renderGirafe({
      #   ggiraph::girafe(ggobj = (location_plots_merge_girafe() + plot_layout(widths = c(2.0, 1))
      #   )) %>%
      #     girafe_options(opts_hover(css = ""), #want shape to inherit the underlying aes on hover whilst other shapes go inv
      #                    opts_hover_inv(css = "opacity:0.3;"),
      #                    opts_tooltip(
      #                      opacity = .95,
      #                      css = "background-color:#1D2F5D;
      #              color:white;font-size:10pt;font-style:italic;
      #              padding:5px;border-radius:10px 10px 10px 10px;"
      #                    ),
      #              opts_toolbar(saveaspng = FALSE),
      #              opts_selection(type="none"))
      # })     
      
      
      
      
      
      
    }
  )
}
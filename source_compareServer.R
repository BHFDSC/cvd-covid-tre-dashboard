observeEvent(input$add, {
  removeUI(
    selector = "#message_temp"
  )
})




input_counter <- reactiveVal(1) 

handlers <- reactiveVal(list()) #holds all reactives of the module
observers <- list() #create (and delete) observers for the kill switch

n <- 1
inputcounter <- reactiveVal(1)

get_event <- reactive({
  input$events
})

observeEvent(input$add, {
  id <- paste0("row_", n)
  n <<- n + 1
  
  insertUI("#Panels",
           "beforeEnd",
           datasetUI(id=id)
           
  )
  

  
  new_handler <- setNames(list(callModule(datasetServer,
                                          id,
                                          no=n,
                                          get_event)),
                          id)
  handler_list <- c(handlers(), new_handler)
  handlers(handler_list)
})


observe({
  hds <- handlers()
  req(length(hds) > 0)
  new <- setdiff(names(hds),
                 names(observers))
  
  obs <- setNames(lapply(new, function(n) {
    observeEvent(hds[[n]]$delete(), { #remove the handler from the lists and remove the corresponding html
      removeUI(paste0("#", n))
      hds <- handlers()
      hds[n] <- NULL
      handlers(hds)
      observers[n] <<- NULL
    }, ignoreInit = TRUE)
  }), new)
  
  observers <<- c(observers, obs)
})

table1 <- reactive({
  hds <- req(handlers())
  req(length(hds) > 0)
  tbl_list <- lapply(hds, function(h) {
    h$get_data()
  })
  do.call(rbind, tbl_list)
})


input_colours = data.frame(input_no = 2:1000) %>%
  add_column(colours = rep(compare_palette, length.out=nrow(.)))




#infinite recursion will occur as table2 depends on the previous colours which depends on table2
#thus use isolate function

# create a reactive value to store the current df
values <- reactiveValues()
observe({
  
  values$new_dataset = table1() %>% pull(dataset)
  values$new_nation = table1() %>% pull(nation)
  values$new_number = table1() %>% pull(number)
  values$new_colour = if(nrow(table1()>1)){
    setdiff(compare_palette[1:nrow(table1())],values$df$colours)[1]
  }
  
  if (counter$countervalue <=2) {
    # isolate is to make sure df is not updated when input changes
    values$df <- table1() %>% left_join(input_colours,by=c("number"="input_no"))

  }
  
  if (counter$countervalue > 2) {
    
    
    
    validate(need(nrow(table1()%>%filter(dataset==""))==0,message = FALSE))
    
    isolate({

      observeEvent(nrow(table1()%>%filter(dataset==""))==0,{
        req(nrow(table1()%>%filter(dataset==""))==0)
        if(nrow(table1()%>%filter(dataset==""))==0){
          values$df <- 
          data.frame(dataset=values$new_dataset,
                              nation=values$new_nation,
                              number=values$new_number) %>%
        left_join(values$df, by = c("dataset", "nation", "number")) %>%
        mutate(colours = ifelse(is.na(colours),values$new_colour,colours))}
      })

      
    })      
  }    
})


#output$test_output <- renderTable(values$df)

#table3 <- reactive({values$df})

compare_palette_values = reactive({setNames(values$df$colours,values$df$dataset)})

my_vars = reactive({values$df$dataset})


observe({
  #print(values$colours)
  #print(compare_palette_values())
  #print(values$df)
  })

compare_coverage_data_all_records_before =  reactive({
  t.data_coverage %>%
    left_join(datasets_available,by = c("dataset"="Dataset")) %>%
    
    #filter(.data$dataset %in% reactiveValuesToList(input)) %>%
    
    filter(.data$dataset %in% my_vars()) %>%
    
    #tooltips for plot
    mutate(N_tooltip = format(.data$N, nsmall=0, big.mark=",", trim=TRUE)) %>%
    mutate(N_tooltip_date = paste0(date_name,N_tooltip)) %>%
    mutate(N_tooltip_date_season = paste0(date_name_season,N_tooltip)) %>%
    filter(!is.na(N))
})
    
compare_coverage_data_all_records =  reactive({ 
  compare_coverage_data_all_records_before() %>%
    #filter(Type == input$type_compare) %>%
    ungroup()
})

compare_coverage_data_start_date =
  reactive({
    compare_coverage_data_all_records() %>%
      #filter date range
      mutate(start_date = as.Date(paste(start_date, 1, sep="-"), "%Y-%m-%d")) %>%
      #to ensure all datasets take the min start date of the greatest min
      mutate(start_date = min(start_date))%>%
      filter(!start_date >= date_format) %>%
      #using current month but this should be updated to use production ym in future
      mutate(current_date = as.Date("2024-01-01")) %>%  #as.Date(paste(format(Sys.Date(), "%Y-%m"), 1, sep="-"), "%Y-%m-%d")
      filter(date_format <= current_date) %>%
      ungroup()
  })

compare_coverage_data = reactive({
  if(input$all_records) {
    (compare_coverage_data_all_records())
  } else {
    (compare_coverage_data_start_date())
  }
})

#observe min and max years available for slider input
compare_date_range_coverage_extremum2 = reactive({
  compare_coverage_data() %>%
    summarise(min = min(.data$date_y),
              max = max(.data$date_y)) %>%
    pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
})

compare_date_range_coverage_min2 = reactive({compare_date_range_coverage_extremum2() %>% filter(.data$extremum=="min") %>% pull(year)})
compare_date_range_coverage_max2 = reactive({compare_date_range_coverage_extremum2() %>% filter(.data$extremum=="max") %>% pull(year)})

compare_date_range_coverage_extremum_start_date2 = reactive({
  compare_coverage_data_start_date() %>%
    summarise(min = min(.data$date_y),
              max = max(.data$date_y)) %>%
    pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
})

compare_date_range_coverage_min_start_date2 = reactive({compare_date_range_coverage_extremum_start_date2() %>% filter(.data$extremum=="min") %>% pull(year)})
compare_date_range_coverage_max_start_date2 = reactive({compare_date_range_coverage_extremum_start_date2() %>% filter(.data$extremum=="max") %>% pull(year)})




observe({
  updateSliderInput(session, "date_range_coverage2",
                    min = compare_date_range_coverage_min2(),
                    max = compare_date_range_coverage_max2(),
                    value = c(
                      compare_date_range_coverage_min_start_date2(),
                      compare_date_range_coverage_max_start_date2()
                    ),
                    step=1
  )})

observe({print(compare_coverage_data_start_date()%>%filter(N<10))})
# observe({print(compare_date_range_coverage_min2())})
# observe({print(compare_date_range_coverage_max2())})
# observe({print(compare_date_range_coverage_min_start_date2())})
# observe({print(compare_date_range_coverage_max_start_date2())})

#date filtered dataset
compare_coverage_data_filtered = reactive({
  
  #to stop error message flashing up on screen - ensure date range has updated before computing
  validate(
    need(input$date_range_coverage2, message = FALSE)
  )
  
  compare_coverage_data() %>%
    filter(.data$date_y>=input$date_range_coverage2[1] & .data$date_y<=input$date_range_coverage2[2]) %>%
    filter(Type == input$type_compare)
})


y_axis = reactive({paste((if(input$type_compare=="n_id_distinct"){"Monthly Distinct IDs"} else if (input$type_compare=="n_id"){"Monthly Valid IDs"} else {"Monthly Records"}),
                         ifelse(input$log_scale,"(Log Scale)","(Linear Scale)"))})

## Trend Plot ============================================================

validate_plots = reactive({compare_coverage_data_filtered() %>% distinct(dataset) %>% select(dataset)})



compare_coverage_plot = reactive({
  
  #dont render until have 2 datasets
  validate(
    need(nrow(validate_plots()) > 1, message = FALSE)
  )

  ggplot(
    data = compare_coverage_data_filtered(),
    aes(x = .data$date_format,
        if(input$log_scale){y=.data$N} else {y=.data$N},
        color = .data$dataset,
        data_id = .data$dataset,
        group = .data$dataset
    )
  ) +
    geom_line_interactive(size = 2.5,
              alpha = if(input$trend_line){1} else {1},
              aes(
                  data_id = .data$dataset
              )) +
    geom_point_interactive(
      aes(tooltip = .data$N_tooltip_date),
      alpha = if(input$trend_line){1} else {1},
      fill = "white",
      size = 2.5,
      stroke = 1.5,
      shape = 20) +
    
    {if(input$trend_line)geom_smooth_interactive(aes(fill = .data$dataset,
                                                     tooltip = .data$N_tooltip_date), method="auto", se=TRUE, fullrange=FALSE, level=0.95)} +
    
    #coord_trans(y="log10") +
    labs(x = NULL, y = y_axis()) +
    theme_minimal() +
    theme(
      text=element_text(family="Rubik"), #family_lato
      panel.grid = element_blank(),
      plot.margin = margin(10,50,0,0),
      plot.background = element_rect(fill='white',color='white'),
      panel.background = element_rect(fill='white',color='white'),
      axis.ticks = element_blank(),
      axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size = 12, color="#4D4C4C"),
      axis.text.x = element_text(size = 14, face = "bold"),
      axis.text.y = element_text(size = 13, face = "bold"),
      legend.position = "none"
    ) +
    
    scale_colour_manual(values=compare_palette_values(), name = "colour_compare") +
    scale_fill_manual(values=compare_palette_values(), name = "colour_compare")  +

    coord_cartesian(clip = "off") +

    scale_y_continuous(labels=scales::label_number(scale_cut = append(scales::cut_short_scale(), 1, 1)), #limits = c(0, NA),
                       trans=if(input$log_scale){scales::pseudo_log_trans(base = 10)} else {trend="identity"}
                       ) 
    
})



y_nudge = reactive({(
  #nudge up a 30th of difference between max and min
  (
    (
      (
        compare_coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
          compare_coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
    ) /30)
)})

y_nudge_log = reactive({(
  #nudge up a 30th of difference between max and min
  (
    (
      (
        log(compare_coverage_data_filtered() %>% mutate(N=log(N)) %>% filter(N == max(N)) %>% distinct(N) %>% pull(N))) - (
          log(compare_coverage_data_filtered() %>% mutate(N=log(N)) %>% filter(N == min(N)) %>% distinct(N) %>% pull(N)))
    ) /30)
)})

x_nudge = reactive({
  (
    as.numeric(
      (compare_coverage_data_filtered() %>% filter(date_format == max(date_format)) %>% distinct(date_format) %>% pull(date_format)) -
        (compare_coverage_data_filtered() %>% filter(date_format == min(date_format)) %>% distinct(date_format) %>% pull(date_format))
    )/10)
})






output$compare_coverage_plot_girafe = 

  renderGirafe({

    validate(
      need(nrow(validate_plots()) > 1, message = FALSE)
    )
    
    #validate(need(compare_coverage_plot(), "")) #attempt to only induce spinner once 2 inputs added
 

  girafe(ggobj = compare_coverage_plot() +
           
           (geom_text_repel_interactive(
             size = 7,
             fontface="bold",
             data = (
               compare_coverage_data_filtered() %>% 
                 filter(date_format == max(date_format))
             ),
             
             aes(
               x = .data$date_format + x_nudge(),
               y = if(input$log_scale){(.data$N) } else {.data$N + (
                 #nudge up a 30th of difference between max and min
                 (
                   (
                     (
                       compare_coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                         compare_coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                   ) /30)
               )},
               color = .data$dataset,
               label = .data$Shortname
             ),
             
             direction = "y",
             family=family_lato,
             segment.color = 'transparent'))
         
         ,
         width_svg = 16,
         height_svg = 9,
         options = list(
           opts_tooltip(
             opacity = 0.95, #opacity of the background box
             css = "background-color:#FF002E;
            color:white;font-size:10pt;font-style:italic;
            padding:5px;border-radius:10px 10px 10px 10px;"
           ),
           #to work - need data_id on
           opts_hover_inv(
             css = "opacity:0.2; transition-delay:0.2s;"#stroke-width:3; #delaying slightly so that when running over points doesnt look glitchy
           ),
           opts_hover(
             css = if(input$trend_line){"opacity: 1; transition-delay:0.2s;"} else {"opacity: 1; transition-delay:0.2s;"} 
           ),
           #turn off save as png as will put this as a shiny command to match excel download
           opts_toolbar(saveaspng = FALSE),
           opts_selection(type="none")
         )
  )

})



compare_coverage_data_selected_download = reactive({
  t.data_coverage_source %>%
    arrange(dataset,date_ym) %>%
    left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
    filter(.data$dataset %in% my_vars()) %>%
    ungroup() %>%
    mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
    filter(!is.na(date_ym)) %>%
    separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
    mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
    filter(.data$date_y>=input$date_range_coverage2[1] & .data$date_y<=input$date_range_coverage2[2]) %>%
    select(dataset,title, date_ym, any_of(input$type_compare)) %>%
    mutate(export_date = Sys.Date())
})

compare_coverage_data_full_download = reactive({
  t.data_coverage_source %>%
    arrange(dataset,date_ym) %>%
    left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
    filter(.data$dataset %in% my_vars()) %>%
    ungroup() %>%
    mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
    filter(!is.na(date_ym)) %>%
    select(dataset,title, date_ym, n, n_id, n_id_distinct) %>%
    mutate(export_date = Sys.Date())
})

# observeEvent(input$download_coverage_data, {
#   
#   shinyalert::shinyalert("Export Data:", 
#                          type = "info",
#                          size = "xs",
#                          html = TRUE,
#                          text = tagList(
#                            #textInput(inputId = "namere", label = NULL),
#                            selectInput(inputId = "download_choice_compare", choices=c("with selected plot input"="selected","in full"="full"), label=NULL),
#                            downloadButton("confName", "Confirm")
#                          ),
#                          closeOnEsc = TRUE,
#                          closeOnClickOutside = TRUE,
#                          showConfirmButton = FALSE,
#                          showCancelButton = FALSE,
#                          animation = TRUE
#   )
#   #this closes the shiny alert after download has been clicked
#   runjs("
#         var confName = document.getElementById('confName')
#         confName.onclick = function() {swal.close();}
#         ")
#   
# })

# output$confName = downloadHandler(
#   filename = function() {if(input$download_choice_compare=="selected"){
#     paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".xlsx")} else {
#       paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".xlsx")}
#   },
#   content = function(file) {writexl::write_xlsx(
#     
#     if(input$download_choice_compare=="selected"){
#       compare_coverage_data_selected_download()
#       } else {
#         compare_coverage_data_full_download()
#       },
#     format_headers = FALSE,
#     path=file)}
# )


output$compare_xlsx = downloadHandler(
  filename = function() {if(input$compare_download_type=="selected"){
    paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".xlsx")} else {
      paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".xlsx")}
  },
  content = function(file) {writexl::write_xlsx(
    
    if(input$compare_download_type=="selected"){
      compare_coverage_data_selected_download()
    } else {
      compare_coverage_data_full_download()
    },
    format_headers = FALSE,
    path=file)}
)

output$compare_csv = downloadHandler(
  filename = function() {if(input$compare_download_type=="selected"){
    paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".csv")} else {
      paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".csv")}
  },
  content = function(file) {write_csv(
    
    if(input$compare_download_type=="selected"){
      compare_coverage_data_selected_download()
    } else {
      compare_coverage_data_full_download()
    },
    path=file)}
)


output$compare_txt = downloadHandler(
  filename = function() {if(input$compare_download_type=="selected"){
    paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".txt")} else {
      paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".txt")}
  },
  content = function(file) {write_tsv(
    
    if(input$compare_download_type=="selected"){
      compare_coverage_data_selected_download()
    } else {
      compare_coverage_data_full_download()
    },
    path=file)}
)



compare_coverage_plot_download = reactive({(compare_coverage_plot()) +
  
  #add geom text layer separate for girafe object and download as different sizes needed
  (geom_text_repel_interactive(
    size = 12,
    data = (
      compare_coverage_data_filtered() %>% 
        filter(date_format == max(date_format))
    ),
    
    aes(
      x = .data$date_format + x_nudge(),
      y = if(input$log_scale){(.data$N) } else {.data$N + (
        #nudge up a 30th of difference between max and min
        (
          (
            (
              compare_coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                compare_coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
          ) /30)
      )},
      color = .data$dataset,
      label = .data$Shortname
    ),
    
    direction = "y",
    family=family_lato,
    segment.color = 'transparent')) +
  
  #custom theme for download
  theme(plot.margin = margin(20,50,20,50),
        axis.text.x = element_text(size = 34, face = "bold"),
        axis.text.y = element_text(size = 34, face = "bold"),
        axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=34, color="#4D4C4C")
  )
})


# output$download_compare_coverage_plot = downloadHandler(
#   filename = function() {paste0("compare_data_coverage_",str_remove_all(Sys.Date(),"-"),".png")},
#   content = function(file) {ggsave(file, plot = compare_coverage_plot_download(),,
#                                    #ensure width and height are same as ggiraph
#                                    #width_svg and height_svg to ensure png not cut off
#                                    width = 16, height = 9, units = "in",
#                                    bg = "transparent",
#                                    dpi = 300, device = "png")}
# )

output$compare_jpeg = downloadHandler(
  filename = function() {paste0("compare_data_coverage_",str_remove_all(Sys.Date(),"-"),".jpeg")},
  content = function(file) {ggsave(file, plot = compare_coverage_plot_download(),
                                   #ensure width and height are same as ggiraph
                                   #width_svg and height_svg to ensure not cut off
                                   width = 16, height = 9, units = "in",
                                   bg = "transparent",
                                   dpi = 300, device = "jpeg")}
)
output$compare_pdf = downloadHandler(
  filename = function() {paste0("compare_data_coverage_",str_remove_all(Sys.Date(),"-"),".pdf")},
  content = function(file) {ggsave(file, plot = compare_coverage_plot_download(),
                                   #ensure width and height are same as ggiraph
                                   #width_svg and height_svg to ensure not cut off
                                   width = 16, height = 9, units = "in",
                                   bg = "transparent",
                                   dpi = 300, device = "pdf")}
)
output$compare_png = downloadHandler(
  filename = function() {paste0("compare_data_coverage_",str_remove_all(Sys.Date(),"-"),".png")},
  content = function(file) {ggsave(file, plot = compare_coverage_plot_download(),
                                   #ensure width and height are same as ggiraph
                                   #width_svg and height_svg to ensure png not cut off
                                   width = 16, height = 9, units = "in",
                                   bg = "transparent",
                                   dpi = 300, device = "png")}
)


# disable the download button on page load
shinyjs::disable("compare_dropdown_image")
# enable when at least 2 unique datasets
observe({
  if (nrow(validate_plots()) >= 2) {
    shinyjs::enable("compare_dropdown_image")
  }
})
# disable the download button on page load
shinyjs::disable("compare_dropdown_data")
# enable when at least 2 unique datasets
observe({
  if (nrow(validate_plots()) >= 2) {
    shinyjs::enable("compare_dropdown_data")
  }
})

shinyjs::disable("date_range_coverage2")
observe({
  if (nrow(validate_plots()) >= 2) {
    shinyjs::enable("date_range_coverage2")
  }
})






#Objective: When one of the download options has been clicked: eg CSV,Excel or Txt
#want the dropdown to close at same time as download
#problem is there is no toggleoption to close dropdown
#additionally cannot observe the download button as there is no inputId part to it
#solution is to observe the clicks of the download button and assign this an input (rnd) - using JS
#then if this changes use JS again to simulate a click of the dropdown thus closing it


observe({
  if(is.null(input$rnd_jpeg)){
    runjs("
            var click = 0;
            Shiny.onInputChange('rnd_jpeg', click)
            var compare_jpeg = document.getElementById('compare_jpeg')
            compare_jpeg.onclick = function() {click += 1; Shiny.onInputChange('rnd_jpeg', click)};
            ")      
  }
})

observeEvent(input$rnd_jpeg, {
  shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                 session$sendCustomMessage("close_drop1_jpeg", ""))
})


observe({
  if(is.null(input$rnd_pdf)){
    runjs("
            var click = 0;
            Shiny.onInputChange('rnd_pdf', click)
            var compare_pdf = document.getElementById('compare_pdf')
            compare_pdf.onclick = function() {click += 1; Shiny.onInputChange('rnd_pdf', click)};
            ")      
  }
})

observeEvent(input$rnd_pdf, {
  shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                 session$sendCustomMessage("close_drop1_pdf", ""))
})


observe({
  if(is.null(input$rnd_png)){
    runjs("
            var click = 0;
            Shiny.onInputChange('rnd_png', click)
            var compare_png = document.getElementById('compare_png')
            compare_png.onclick = function() {click += 1; Shiny.onInputChange('rnd_png', click)};
            ")      
  }
})

observeEvent(input$rnd_png, {
  shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                 session$sendCustomMessage("close_drop1_png", ""))
})




observe({
  if(is.null(input$rnd_csv)){
    runjs("
            var click = 0;
            Shiny.onInputChange('rnd_csv', click)
            var compare_csv = document.getElementById('compare_csv')
            compare_csv.onclick = function() {click += 1; Shiny.onInputChange('rnd_csv', click)};
            ")      
  }
})

observeEvent(input$rnd_csv, {
  shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                 session$sendCustomMessage("close_drop2_csv", ""))
})


observe({
  if(is.null(input$rnd_excel)){
    runjs("
            var click = 0;
            Shiny.onInputChange('rnd_excel', click)
            var compare_xlsx = document.getElementById('compare_xlsx')
            compare_xlsx.onclick = function() {click += 1; Shiny.onInputChange('rnd_excel', click)};
            ")      
  }
})

observeEvent(input$rnd_excel, {
  shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                 session$sendCustomMessage("close_drop2_excel", ""))
})

observe({
  if(is.null(input$rnd_txt)){
    runjs("
            var click = 0;
            Shiny.onInputChange('rnd_txt', click)
            var compare_txt = document.getElementById('compare_txt')
            compare_txt.onclick = function() {click += 1; Shiny.onInputChange('rnd_txt', click)};
            ")      
  }
})

observeEvent(input$rnd_txt, {
  shinyjs::delay(100, #adding a delay so data downloaded first before dropdown closes
                 session$sendCustomMessage("close_drop2_txt", ""))
})









#Dropdown - will downloaded as soon as both input choices have been selected
#the input will then be reset AND the dropdown window will close automatically
# observeEvent(req(input$log_scale), {
#   updateRadioGroupButtons(inputId = "input$download_image_choice1", selected=character(0))
# })



# observeEvent(req(counter$countervalue>0, input$"row_1-delete"), {
#   insertUI(
#     selector = "#Panels",
#     where = "beforeBegin",
#     ui = div(id = paste0("txt", input$add),
#         h6("Click below to begin comparing datasets:"))
#   )
# })
# 
# 
# observeEvent(req(counter$countervalue > sum(input$"row_1-delete")), {
#   removeUI(
#     selector = "div:has(> #txt)"
#   )
# })

observe({
#print(names(input))
# print(counter$countervalue)
# print(values$df)
# print(table1())
# print(table1()%>%select(dataset)%>%distinct()%>%arrange(dataset)%>%pull())
# print(values$df%>%select(dataset)%>%distinct()%>%arrange(dataset)%>%pull())
# print(all((table1()%>%select(dataset)%>%distinct()%>%arrange(dataset)%>%pull())==(values$df%>%select(dataset)%>%distinct()%>%arrange(dataset)%>%pull())))
})


#Add Button click counter
counter <- reactiveValues(countervalue = 0)
observeEvent(req(input$add), {
  counter$countervalue <- counter$countervalue + 1
  })


# For info boxes in Count on Compare tab


output$compare_coverage_ex <- renderUI({
  
  tagList(
    radioButtons(inputId = "type_compare",
                       label = "Overall Count:", 
                       choices = c('<span class="count_options_cov">Records'='n',
                                   
                                   
                                   '<span class="count_options_cov">Records with a de-identified PERSON ID 


        <div class="pretty p-default p-switch p-fill"></div>
          <span "te" id="pretty_custom_icon" class="hint--left hint--error hint--medium hint--rounded hint--no-animate"
          aria-label="Number of records with
a de-identified person
identifier that are
potentially linkable
across datasets within
the respective TRE">
            <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
            </span></div></span>'='n_id',


'<span class="count_options_cov">Distinct de-identified PERSON ID 


        <div class="pretty p-default p-switch p-fill"></div>
          <span "te" id="pretty_custom_icon" class="hint--left hint--error hint--medium hint--rounded hint--no-animate"
          aria-label="The unique number of 
de-identified person 
identifiers in the dataset, 
excluding null values">
            <i class="fas fa-circle-info" role="presentation" aria-label="circle-info icon"></i>
            </span></div></span>'='n_id_distinct'
                       ),
selected = count_options_selected_season),

tags$script(
  "
        $('#compare_coverage_ex .radio span').map(function(choice){
            this.innerHTML = $(this).text();
        });
        "
)

  )
})


#important: the input type_compare is not available before the uiOutput renders so this is important
#as otherwise the app will fail when choosing Data before going onto Plot tab
outputOptions(output, "compare_coverage_ex", suspendWhenHidden = FALSE)

observe(print(input$navmain=="Dataset Comparison"))


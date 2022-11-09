#BHF Data Science Centre Health Data Science Shiny Theme

###############################################################################
#Colour Dictionary

colour_bhf_darkred = '#A0003C'
colour_bhf_lightred = '#FF001F'
colour_bhf_neonred = '#EC2154'


colour_global_options = colour_bhf_darkred
customValueBox_global_colour = '#F3F2F4'
customValueBox_border_colour = '#F3F2F4'

###############################################################################
#Boostrap and CSS Theme
library(bslib)

#The booststrap main theme uses flaty as a basis
bhf_dsc_hds_bootstrap_theme = bs_theme(version = 5, bootswatch = "flatly",
                                   #override some defaults
                                   primary = 'white',
                                   secondary='white',
                                   success = colour_bhf_lightred)

#line under navbar
bhf_navbar_line = hr(style=paste0("color:",colour_bhf_darkred,"!important;"))

#CSS External File that overrides flatly themes


bhf_dsc_hds_css = "

:root{
--colour_bhf_darkred:#A0003C;
--colour_bhf_lightred:#FF001F;
--colour_bhf_background_lightgrey:#F3F2F4;
--colour_bhf_neonred:#F51344;
--customValueBox_border_colour:#A95EF4;
}

/*DT Table*/
table.dataTable thead tr {
  background-color: var(--colour_bhf_darkred);
  color: white;
}



/* CSS for the checked checkboxes */
.pretty.p-default input:checked~.state label:after {
  background-color: #000000 !important;
}




/*The colour of nonactive tabs*/
.navbar .navbar-nav li > a{
  color: #474D5B !important;
}

/*The hover as go over tabs*/
.navbar .navbar-nav li > a:hover{
  color: var(--colour_bhf_darkred) !important;
  position: relative;
}

.label-primary{
background-color: #c110a0;
}

.selectize-input { word-wrap : break-word;}
.selectize-input { word-break: break-word;}
.selectize-dropdown {word-wrap : break-word;}

/*The hover as go over tabs line border that comes up under*/
.navbar .navbar-nav li > a:hover::after {
    background-color: var(--colour_bhf_darkred); 
    bottom: 0;
    content: '';
    display: block;
    height: 1.5px;
    left: 50%;
    position: absolute;
    transform: translate(-50%,0);
    width: 50%; /*Can be set width eg 10px or a%*/
}




/*The Active NarBar Tab*/
.navbar .nav-link.active,
.navbar .nav-item.show .nav-link {
 color:var(--colour_bhf_darkred) !important;
 background-color: transparent;
 border-color: transparent;
}

/*Nav Bar Font Size*/
.navbar {
font-size: 18px;
}

/*Nav Bar Height*/
.navbar {
max-height:40px !important;
margin-top:15px;
}

/*Prompter Tooltips*/
.hint--error:after {
          background: none var(--colour_bhf_neonred);
          opacity: 0.95 !important;
          color: #FFFFFF;
          text-shadow: none;
        }
        .hint--error.hint--bottom:before {
          border-bottom-color: var(--colour_bhf_neonred)
        }
        .hint--error.hint--left:before {
          border-left-color: var(--colour_bhf_neonred)
        }
        .hint--error.hint--top:before {
          border-top-color: var(--colour_bhf_neonred)
        }
        .hint--error.hint--right:before {
          border-right-color: var(--colour_bhf_neonred)
        }

/*Plot/Summary Active Tab*/
.nav-tabs .nav-link.active,
.nav-tabs .nav-item.show .nav-link {
 color:white;
 background-color: var(--colour_bhf_darkred);
 border-color: var(--colour_bhf_darkred);
}

/*Plot/Summary NonActive Tabs*/
.nav-tabs>li>a {
color: var(--colour_bhf_lightred);
background-color:white;
}

/*h3 headings*/
h3 { 
  color:var(--colour_bhf_darkred);
}

/*h4 headings*/
h4 { 
  color:var(--colour_bhf_darkred);
}

/*h5 headings*/
h5 { 
  color:var(--colour_bhf_darkred);
  /*font-weight: bold;*/
}

/*h6 headings*/
h6 { 
  color:var(--colour_bhf_darkred);
  /*font-weight: bold;*/
}

#version_css{
color:grey;
text-align:right;
}

/*dateRangeInput header text*/
.shiny-date-range-input{
font-size: 16px;
}

/*Dashboard Background*/
.dashboard_css{
background-color: white; /*var(--colour_bhf_background_lightgrey) or white*/
border-top-left-radius: 10px !important; /*Round Edges*/
border-bottom-left-radius: 10px !important; /*Round Edges*/
border-top-right-radius: 10px !important; /*Round Edges*/
border-bottom-right-radius: 10px !important; /*Round Edges*/
padding-bottom:20px;
}


/*Hover Colour on DT Rows*/
table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover {
background-color: var(--colour_bhf_background_lightgrey) !important;}



/*Datatabe Pagination Buttons*/


/*Current Button*/
.paginate_button.current {
background: linear-gradient(to top, #DCDCDC 0%, #FEFEFE 100%) !important;
border: 1px solid #979797!important
}

/*Current Button when Hovered*/
.paginate_button.current:hover{
background: linear-gradient(to top, #DCDCDC 0%, #FEFEFE 100%) !important;
border: 1px solid #979797!important;
}

/*Other buttons*/
.paginate_button:hover {
border: 1px solid #EBF0F1!important;
background: transparent!important;
}

/*Other buttons on hover*/
/*Ideally want color (font) Dark and hover background white with just a faint light grey border on hover*/
.paginate_button:hover {
border: 1px solid #EBF0F1!important;
background: transparent!important; 
color: red !important;
}


.paginate_button:not(.previous):not(.next){
}

/*Disabled buttons on hover - for example Previous is diabled when on page 1*/
.paginate_button.disabled:hover{
background: transparent;
border: 1px solid transparent !important;
}

.pagination.page-numbers:hover {
    background-color: red;
    color: yellow !important;
}


/*Slider Inputs*/
.irs-grid-pol.small {height: 0px;}.js-irs-0 
                         .irs-single, 
                         .js-irs-0 
                         .irs-bar-edge, 
                         .js-irs-0 .irs-bar {background: #FF001F;
                                             border-top: 1px solid #FF001F ;
                                             border-bottom: 1px solid #FF001F;}
                           .irs-from, .irs-to, .irs-single { background: #8C0032 !important }



/*SINGULAR INPUTS WITH IDS*/


#dataset_css .selectize-input {
  height:38px;
}

#nation_css .selectize-input {
  height:38px;
}

/*Volunteer Pathway Option Portal: All in Bold*/  
.nation_css .option:first-child{
    font-weight:bold;
}

#nation_css .selectize-input {
  height:38px;
}

#eda_survey_css .selectize-input {
  color:var(--colour_bhf_lightred);
}




#hour_cutoff {
    border-color:#BFBFBF !important;
  }





/*REFRESH*/
#refresh_sourceData{
background-color:var(--colour_bhf_darkred);
border-color:var(--colour_bhf_darkred);
color:white;
outline: none !important;
box-shadow: none;
horizontal-align:right;
margin-top:10px;
margin-bottom:10px;
font-size: 18px; /*size of icon*/
}

/*REFRESH HOVER*/
#refresh_sourceData:hover{
background-color:var(--colour_bhf_darkred);
border-color:var(--colour_bhf_darkred);
color:var(--colour_bhf_neonred);
outline: none !important;
box-shadow: none;
horizontal-align:right;
margin-top:10px;
margin-bottom:10px;
font-size: 18px;
}

/*RESET*/
#reset_allInputs{
background-color:var(--colour_bhf_darkred);
border-color:var(--colour_bhf_darkred);
color:white;
outline: none !important;
box-shadow: none;
horizontal-align:right;
margin-top:10px;
margin-bottom:10px;
font-size: 15px;
}

/*RESET HOVER*/
#reset_allInputs:hover{
background-color:var(--colour_bhf_darkred);
border-color:var(--colour_bhf_darkred);
color:var(--colour_bhf_neonred);
outline: none !important;
box-shadow: none;
horizontal-align:right;
margin-top:10px;
margin-bottom:10px;
font-size: 15px;
}




/*Css Tags in Modules access - downloads*/
#data_coverage_module-download_summary_coverage_plot:hover{
background-color:white;
border-color:white;
color:var(--colour_bhf_neonred);
outline: none !important;
box-shadow: none;
margin-left:-4%;
}

#data_coverage_module-download_summary_coverage_plot{
background-color:white;
border-color:white;
color:#3C3C3C;
outline: none !important;
box-shadow: none;
margin-left:-4%;
}


#data_completeness_module-download_summary_completeness_plot:hover{
background-color:white;
border-color:white;
color:var(--colour_bhf_neonred);
outline: none !important;
box-shadow: none;
margin-left:-4%;
}

#data_completeness_module-download_summary_completeness_plot{
background-color:white;
border-color:white;
color:#3C3C3C;
outline: none !important;
box-shadow: none;
margin-left:-4%;
}

"


#Global Options FluidRow
wellpanel_style = "background: white; border-color: white;margin-top:-1%;"
bhf_global_options_style = "
background: linear-gradient(to right, #e30020, #ed1f54);
border-top-left-radius: 10px !important; /*Round Edges*/
border-bottom-left-radius: 10px !important; /*Round Edges*/
border-top-right-radius: 10px !important; /*Round Edges*/
border-bottom-right-radius: 10px !important; /*Round Edges*/
"


global_options_row_height = "110px"

global_row_header = FALSE #change to TRUE if want a "Global Options" header
global_row_header_styling = fluidRow(column(12,titlePanel(h6(id='global_heading',"Global Options")),
                                            tags$style(HTML("#global_heading{color:#1D2F5D;margin-top:-20px;}"))))

bhf_global_options_column_style_left = paste("background-color:",colour_global_options,";",
                                             "border-color:","green",";",
                                             "border-width: thick;",
                                             "height:",global_options_row_height,";",
                                             "border:",global_options_row_height,";",
                                              "border-top-left-radius: 10px !important; /*Round Edges*/
                                               border-bottom-left-radius: 10px !important; /*Round Edges*/")



bhf_global_options_column_style_middle = paste("background-color:",colour_global_options,";",
                                               "border-color:","green",";",
                                               "border-width: thick;",
                                               "height:",global_options_row_height,";",
                                               "border:",global_options_row_height,";")



bhf_global_options_column_style_right = paste("background-color:",colour_global_options,";",
                                                  "height:",global_options_row_height,";",
                                            "border:",global_options_row_height,"; /*Round Edges*/
                                            border-top-right-radius: 10px !important; /*Round Edges*/
                                            border-bottom-right-radius: 10px !important; /*Round Edges*/")

# If using the dateRangeInput across mutliple tab panels assign arguments globally here
# pass in arguments to function and use do.call to execute
bhf_global_options_dateRangeInput_style = list(
  label=shiny::HTML("<p></p><span style='color: white'>Date Range:</span>"),
  start='2022-02-03',
  format='dd/mm/yyyy',
  separator = "to",
  min='2022-02-03') #access using input$date_range_demographics[1] and input$date_range_demographics[2]



# Appendix Container

appendix_css = paste0("color: ", colour_bhf_darkred,
                      "; background-color: ", customValueBox_global_colour,
                      ";", "
                  border-top-left-radius: 10px !important; /*Round Edges*/
                  border-bottom-left-radius: 10px !important; /*Round Edges*/
                  border-top-right-radius: 10px !important; /*Round Edges*/
                  border-bottom-right-radius: 10px !important; /*Round Edges*/
                  padding-left:10px; 
                  padding-bottom:5px;
                  padding-right:10px;
                  margin-top:20px;
                  border-style: solid; border-width: 1px; border-color: ", customValueBox_border_colour, ";")



###############################################################################
#Custom built

customValueBox <- function (value, title, subtitle, icon = NULL, color, background, border, width = 4, href = NULL){
  
  style = paste0("color: ", color,
                 "; background-color: ", background,
                 ";", "
                  border-top-left-radius: 10px !important; /*Round Edges*/
                  border-bottom-left-radius: 10px !important; /*Round Edges*/
                  border-top-right-radius: 10px !important; /*Round Edges*/
                  border-bottom-right-radius: 10px !important; /*Round Edges*/
                  padding-left:10px; 
                  padding-bottom:5px;
                  padding-right:10px;
                  margin-top:20px;
                  border-style: solid; border-width: 1px; border-color: ", border, ";")
  
  boxContent = div(class = "small-box", 
                   style = style,
                   if (!is.null(icon))
                   div(class = "icon-large", h4(icon,title), style=""),
                   div(class = "inner", 
                       h6(value, style="line-height: 150%;"), 
                       p(subtitle,style="font-size: 25px;"), 
                       style="margin-top:20px;"))
  
  if (!is.null(href))
    boxContent = a(href = href, boxContent)
  div(class = if (!is.null(width))
    paste0("col-sm-", width), boxContent)
}



input_ui = function(input_id, input_element, help, margin = 4) {
  div(style = 'display: inline-block; vertical-align: bottom; min-width: 100%;',
      column(12, style = 'padding-left: 0',
             input_element
      ),
      column(1, style = paste0('margin-top: ', margin, 'px; margin-left: -14px;'),
             br(),
             actionButton(paste0(input_id, '_help'), NULL, icon = icon('question', lib = 'font-awesome')),
             bsPopover(paste0(input_id, '_help'), placement = 'right', trigger = 'focus', title = NULL,
                       content = help)
      )
  )
}
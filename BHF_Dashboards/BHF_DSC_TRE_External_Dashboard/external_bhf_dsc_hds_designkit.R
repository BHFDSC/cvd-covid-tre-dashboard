#BHF Data Science Centre Health Data Science Shiny Theme

###############################################################################
#Colour Dictionary

colour_bhf_darkred = '#A0003C'
colour_bhf_lightred = '#FF001F'
colour_bhf_neonred = '#EC2154'


colour_global_options = colour_bhf_darkred
customValueBox_global_colour = '#F3F2F4'
customValueBox_border_colour = '#F3F2F4'

colour_stepped_palette = c(
  #purple
  "#a37cd6",
  "#b388eb",
  "#d59bf2",
  "#e6a5f5",
  "#f7aef8",
  #orange
  "#f25c54",
  "#f27059",
  "#f4845f",
  "#f79d65",
  "#f7b267",
  #turquoise
  "#07beb8",
  "#3dccc7",
  "#68d8d6",
  "#9ceaef",
  "#c4fff9",
  #red
  "#c42348",
  "#d91e36",
  "#da344d",
  "#ec5766",
  "#ef7674",
  #blue
  "#3D7CD9",
  "#4B90F1",
  "#63A0F3",
  "#8DBCFF",
  "#BDD6F6",
  #pink
  "#F9007F",
  "#FE47A5",
  "#FD6EB9",
  "#FFA8D5",
  "#FFD3FB"
)


compare_palette = c(
  "#b388eb",
  "#9F54A8",
  "#F5484A",
  "#FFC16A",
  "#FDA361"
)

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

#Google fonts for ggplots - in order of preference from flatly theme
font_add_google("Lato", "lato")
font_add_google("Noto Sans", "segoe_ui")
font_add_google("Roboto", "helvetica_neue")
showtext_auto()
family_lato = "lato"
family_segoe = "segoe_ui"
family_helvetica = "helvetica_neue"




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


/*.paginate_button:not(.previous):not(.next){background-color: var(--colour_bhf_darkred);color: var(--colour_bhf_darkred);}*/


/*Compare - Add more data and trash*/
#add {  color:white!important;
  background-color:var(--colour_bhf_darkred)!important;
}
#add:hover {  color:white!important;
  background-color:var(--colour_bhf_neonred)!important;
}








/* CSS for the checked checkboxes */
.pretty.p-default input:checked~.state label:after {
  background-color: #000000 !important;
}


/*Radio and Checkbox buttons*/
.form-check-input, .shiny-input-container .checkbox input, .shiny-input-container .checkbox-inline input, .shiny-input-container .radio input, .shiny-input-container .radio-inline input
{color: yellow !important; background-color: white !important; border:1px solid #C9C9C9 !important;}


/*the highlight colour around inputs when you click on box*/
.selectize-input.focus {
    border:1px solid #B774FF !important;
}


/* unvisited link */
a:link {
  color: var(--colour_bhf_lightred);
}

/* visited link */
a:visited {
  color: var(--colour_bhf_lightred);
}

/* mouse over link */
a:hover {
  color: #9F54A8;
}

/* selected link */
a:active {
  color: #9F54A8;
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
          transition-duration: width 2s, height 2s, transform 2s;
          transition-timing-function: ease-in; 
          transition-delay: 0.5s !important;
}
/*little arrow tooltip*/
.hint--error:before { 
          opacity: 0.95 !important;
          color: #FFFFFF;
          text-shadow: none;
          transition-duration: width 2s, height 2s, transform 2s;
          transition-timing-function: ease-in;
          transition-delay: 0.5s !important;
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


/*Compare Tab input tab panels in module_compare.R*/






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


.overview_css{
display: flex;
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


.dataTables_wrapper:after{
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


/*Slider Inputs - eg for Date pickers*/
.irs-grid-pol.small {height: 0px;}.js-irs-0 
                         .irs-single, 
                         .js-irs-0 
                         .irs-bar-edge, 
                         .js-irs-0 .irs-bar {background: #FF001F !important;
                                             border-top: 1px solid #FF001F !important;
                                             border-bottom: 1px solid #FF001F !important;}
                           .irs-from, .irs-to, .irs-single {background: #8C0032 !important;}



.irs--shiny .irs-bar {background: var(--colour_bhf_lightred) !important; color: var(--colour_bhf_lightred) !important;
border: 1px solid var(--colour_bhf_lightred) !important;
}



/*SINGULAR INPUTS WITH IDS*/


#dataset_css .selectize-input {
  height:38px;
}

#nation_css .selectize-input {
  height:38px;
}

/*Select Input: All in Bold
.nation_css .option:first-child{
    font-weight:bold;
}*/

#nation_css .selectize-input {
  height:38px;
}

#eda_survey_css .selectize-input {
  color:var(--colour_bhf_lightred);
}




#hour_cutoff {
    border-color:#BFBFBF !important;
  }


/*COMPARE TAB - Nation and Dataset Inputs*/
#compare_module-compare-nation_compare-label{
  color:var(--colour_bhf_darkred) !important;
}
#compare_module-compare-dataset_compare-label{
  color:var(--colour_bhf_darkred) !important;
}
#compare_module-add{
  color:white!important;
  background-color:var(--colour_bhf_darkred)!important;
}
#compare_module-add:hover{
  color:white!important;
  background-color:var(--colour_bhf_neonred)!important;
}
#compare_module-remove{
  color:white!important;
  background-color:var(--colour_bhf_darkred)!important;
}
#compare_module-remove:hover{
  color:white!important;
  background-color:var(--colour_bhf_neonred)!important;
}

#selectize_div_all{
  color:var(--colour_bhf_darkred) !important;
}
#compare_module-nation_compare_initial-label{
  color:var(--colour_bhf_darkred) !important;
}
#compare_module-dataset_compare_initial-label{
  color:var(--colour_bhf_darkred) !important;
}
#compare_module-nation_compare_initial2-label{
  color:var(--colour_bhf_darkred) !important;
}
#compare_module-dataset_compare_initial2-label{
  color:var(--colour_bhf_darkred) !important;
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




/*Compare Tab Action Buttons take the default*/
.btn-secondary, .btn-default:not(.btn-primary):not(.btn-info):not(.btn-success):not(.btn-warning):not(.btn-danger):not(.btn-dark):not(.btn-outline-primary):not(.btn-outline-info):not(.btn-outline-success):not(.btn-outline-warning):not(.btn-outline-danger):not(.btn-outline-dark){
color:var(--colour_bhf_darkred);
background-color:#F3F2F4;
border-color:#F3F2F4;
}

.btn-secondary:hover, .btn-default:hover:not(.btn-primary):not(.btn-info):not(.btn-success):not(.btn-warning):not(.btn-danger):not(.btn-dark):not(.btn-outline-primary):not(.btn-outline-info):not(.btn-outline-success):not(.btn-outline-warning):not(.btn-outline-danger):not(.btn-outline-dark){
color:var(--colour_bhf_neonred);
background-color:#F3F2F4;
border-color:#F3F2F4;
}

/*Css Tags in Modules access - downloads*/
#summary_module-data_coverage_module-download_summary_coverage_plot:hover{
background-color:white !important;
border-color:white !important;
color:var(--colour_bhf_neonred) !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}


#summary_module-data_coverage_module-download_summary_coverage_plot{ /*#data_coverage_module-download_summary_coverage_plot*/
background-color:white !important;
border-color:white !important;
color:#3C3C3C !important;
outline: none !important !important;
box-shadow: none !important;
margin-left:-4% !important;
}

#summary_module-data_coverage_module-download_summary_coverage_season_plot:hover{
background-color:white !important;
border-color:white !important;
color:var(--colour_bhf_neonred) !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}


#summary_module-data_coverage_module-download_summary_coverage_season_plot{ /*#data_coverage_module-download_summary_coverage_plot*/
background-color:white !important;
border-color:white !important;
color:#3C3C3C !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}


#summary_module-data_completeness_module-download_summary_completeness_plot:hover{
background-color:white !important;
border-color:white !important;
color:var(--colour_bhf_neonred) !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}

#summary_module-data_completeness_module-download_summary_completeness_plot{
background-color:white !important;
border-color:white !important;
color:#3C3C3C !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}


/*pretty switch*/
/*
.state {color: white !important;}
.state :not([class]){color: white !important;}
.state::before{background-color: #5A656B !important; color: #5A656B !important;}
.pretty.p-switch .state label:after{background-color: #FFFFFF !important; color: #FFFFFF !important}
*/






/*FOOTER CSS*/

.footer {
  position: relative;
  width: 100%;
  background: var(--colour_bhf_darkred);
  min-height: 100px;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.social-icon,
.menu {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 10px 0;
  flex-wrap: wrap;

}

.social-icon__item,
.menu__item {
  list-style: none;

}

.social-icon__link {
  font-size: 2rem;
  color: #fff !important;
  margin: 0 10px;
  display: inline-block;
  transition: 0.5s;

}
.social-icon__link:hover {
  transform: translateY(-10px);
  color: white !important
}

.menu__link {
  font-size: 1.2rem;
  color: #fff;
  margin: 0 10px;
  display: inline-block;
  transition: 0.5s;
  text-decoration: none;
  opacity: 0.75;
  font-weight: 300;

}

.menu__link:hover {
  opacity: 1;

}

.footer p {
  color: #fff;
  margin: 15px 0 10px 0;
  font-size: 1rem;
  font-weight: 300;
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

bhf_tab_panel_style = "
min-height: 70vh; height: 70vh; overflow-y: scroll;
background: var(--colour_bhf_background_lightgrey);
border: var(--colour_bhf_background_lightgrey);
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
"
#overflow-y: scroll;


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



tabset_panel_compare_styling = '

ul.nav-pills{
 background-color: transparent !important;
}
.nav-pills .nav-link.active {
color: #FF001F !important;
background-color:#F3F2F4 !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link.active:hover {
color: #FF001F !important;
background-color:#F3F2F4 !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link {
color: #FF001F;
background-color:white;
border: 1px solid white!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link:hover {
color: #A0003C !important;
background-color:white !important;
border: 1px solid #F3F2F4!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}'


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
                  height:100%;
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
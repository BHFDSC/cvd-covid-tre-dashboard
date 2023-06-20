#BHF Data Science Centre Health Data Science Shiny Theme

###############################################################################
#Colour Dictionary

colour_bhf_darkred = '#A0003C'
colour_bhf_lightred = '#FF002E'
colour_bhf_neonred = '#FF002E'

colour_bhf_darkred_old = '#A0003C'
colour_bhf_lightred_old = '#FF001F'
colour_bhf_neonred_old = '#EC2154'
      

colour_global_options = colour_bhf_darkred
customValueBox_global_colour = '#F3F2F4'
customValueBox_border_colour = '#F3F2F4'

colour_stepped_palette_old = c(
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


colour_stepped_palette = c(
           "#7044CB",
           "#38AF89",
           "#ff4f00",
           "#ff0030",
           "#ffcc1a",
           "#475ca6",
           "#8c0033"
)

compare_palette_old = c(
  "#b388eb",
  "#9F54A8",
  "#F5484A",
  "#F88350",
  "#DD002D",
  "#FFC16A",
  "#00DEBE"

)

compare_palette = c(
  "#7044CB",
  "#38AF89",
  "#ff4f00",
  "#ff0030",
  "#ffcc1a",
  "#475ca6",
  "#8c0033"
  )

compare_colours_old=c("#94409F", "#BC366C", "#E1324C", "#F82D2E", "#FC7F47", "#FEB958")
compare_colours=c("#7044CB","#465DA7", "#38AF89", "#ABDFE7")

summary_coverage_palette = c(
"n"="#ffcc1a",
"n_id"="#7044CB", 
"n_id_distinct"="#38AF89"
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
#bhf_navbar_line = hr(style=paste0("color:","#000000","!important;"))

#Google fonts for ggplots - in order of preference from flatly theme
font_add_google("Rubik", "rb")
font_add_google("Noto Sans", "segoe_ui")
font_add_google("Roboto", "helvetica_neue")
showtext_auto()
family_lato = "rb"
family_segoe = "segoe_ui"
family_helvetica = "helvetica_neue"




#CSS External File that overrides flatly themes
bhf_dsc_hds_css = "


#summary_module-data_coverage_module-summary_coverage_plot_render{
color:#3db08c;
text-align:center;
align-items: center;
margin-top:20%;
}

#summary_module-data_coverage_module-summary_coverage_season_plot_render{
color:#3db08c;
text-align:center;
align-items: center;
margin-top:20%;
}

html {
  box-sizing: border-box;
}
* {box-sizing: inherit;}

.attribution { 
  font-size: 18px; text-align: center; 
letter-spacing:1px;
  padding: 8px 0 5px;
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  width: 100%;
}


.acknowledge{
background:#7044CB;
height:1000px;
}

.acknowledge_title{
    padding-left: 3%;
    padding-right: 3%;
    padding-top: 3%;
    letter-spacing:1px;font-size:34px;text-align:left;
font-weight: bold;
color:white;
    margin-left:65px;
}

.acknowledge_body{
    padding-left: 3%;
    padding-right: 3%;
    letter-spacing:1px;font-size:17px;text-align:left;
    margin-left:65px;
    margin-right:15px;
color:#FFC335;
}

.acknowledge_body_wrangler{
    padding-left: 3%;
    padding-right: 3%;
    letter-spacing:1px;font-size:19px;text-align:left;
    margin-left:65px;
    margin-right:15px;
color:white;
font-weight: bold;
}


/* global */
/*================================================*/

.faq-title{
display: flex;

letter-spacing:1px;font-size:34px;text-align:left;
}

.card-wrapper {
  min-height: 60vh;
  padding-bottom: 50px; /* footer fixed */
  padding-top: 25px;
}

p {
  margin: 0 0 18px;
  line-height: 1.5;
}

h2 {
  margin: 18px 0;
}


/* generics */
/*================================================*/

.content-cc{
  display: flex;
  justify-content: center;/*still goes up but gets rid of bottom space*/
  align-items: start; /*doesnt go up but has big bottom part*/

marign-top:-100px;
row-gap: 200px;
}

/* FAQ card */
/*================================================*/

.faq-card {

  background-color: #E2F9FB;
  border-radius: 20px;

  max-width: 80%;

  
}


/* FAQ card: main */
/*================================================*/

.faq-content {
  padding: 9px 25px 3rem; 
}

.faq-content h1 {
  font-size: 32px;
  text-align: center;
  color: #7044CB;
}

.faq-accordion {

  padding: 8px 0;
  border-bottom: 1px solid hsl(240, 5%, 91%);
}


/* FAQ card: main title */
/*================================================*/

/* checkbox tgg-title*/
input.tgg-title {
  appearance: unset;
  all:unset;
}

.faq-accordion-title label{
  display: flex;
  align-items: center;
  cursor: pointer;
}

.faq-accordion-title h2{
letter-spacing:1px;
  font-size: 18px /*var(--font-size)*/;
  font-weight: 700;
  color: #7044CB;
}

.faq-accordion-title span{
  margin-left: auto;
  transition: transform .4s ease-in-out;
}


/* FAQ card: main content */
/*================================================*/

.faq-accordion-content {
  color: #474D5B;
  overflow: hidden;
  max-height: 0;
  transition: max-height .4s ease-in-out;
  font-size: 18px;
}


/* Effects */
/*================================================*/

/* main title, accordion title effects */

.faq-accordion-title:hover h2{
  color: #7044CB
}

/* onclick */
.faq-accordion .tgg-title:checked + div>label>h2 {
  font-weight: 700;
}

.faq-accordion .tgg-title:checked + div>label>span {
  will-change: transform;
  transform: rotate(180deg);
}

/* main content, acordion text effect */

.faq-accordion .tgg-title:checked ~ .faq-accordion-content{
  will-change: max-height;
  max-height: 1000px;
}



#navmain .nav-item{padding-right:30px;}
.navbar{margin-top:-20px;padding-top:-20px;border-top:-20px;background:white;z-index:2147483647 !important;font-size: 18px;
padding-top:2%;}
.navbar.navbar-default{background:white;z-index:2147483647 !important;}


#pretty_custom_icon{
color:#7044CB; /*#A052A7*/
align:left;
transition-duration: width 2s, height 2s, transform 2s;
transition-timing-function: ease-in; 
transition-delay: 0.5s !important;
margin-left:0% !important;
font-size: 100%;
position: absolute
}




#pretty_custom_icon:hover{
color:#FF002E;
align:left;
transition-duration: width 2s, height 2s, transform 2s;
transition-timing-function: ease-in; 
transition-delay: 0.5s !important;
margin-left:0% !important;
font-size: 100%;
position: absolute
}

hr {
   border: 0;
   border-top: 3px solid #413C45;;
   opacity: .1;
}

body{padding-top: 70px;background:white;max-width: 100%;
    overflow-x: hidden;}
/*.container-fluid{margin-top:;margin-bottom:-20px;padding-bottom:-20px;border-bottom:-20px;background:white;border-color:transparent;}*/

.container-fluid {
   padding: 0px;
}

/*SWITCH FOR NAVBAR colour when on About tab only*/
.navbar.normaltab {
background:white!important;
}
.navbar.abouttab {
  background:#EEE8FF!important;
}
.normaltab {
background:white!important;
}
.abouttab {
  background:#EEE8FF!important;
}

.navbar {
  background:#EEE8FF!important;
}
.navbar.aboutdefault {
  background:#EEE8FF!important;
}
#aboutdefault {
  background:#EEE8FF!important;
}

@import url('https://fonts.googleapis.com/css2?family=Rubik&display=swap');
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Rubik', sans-serif;
}

/* cyrillic-ext */
@font-face {
  font-family: 'Rubik';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/s/rubik/v26/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-B4iFWkUzdYPFkZVOA6w.woff) format('woff');
  unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;
}
/* cyrillic */
@font-face {
  font-family: 'Rubik';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/s/rubik/v26/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-B4iFU0UzdYPFkZVOA6w.woff) format('woff');
  unicode-range: U+0301, U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}
/* hebrew */
@font-face {
  font-family: 'Rubik';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/s/rubik/v26/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-B4iFVUUzdYPFkZVOA6w.woff) format('woff');
  unicode-range: U+0590-05FF, U+200C-2010, U+20AA, U+25CC, U+FB1D-FB4F;
}
/* latin-ext */
@font-face {
  font-family: 'Rubik';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/s/rubik/v26/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-B4iFWUUzdYPFkZVOA6w.woff) format('woff');
  unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}
/* latin */
@font-face {
  font-family: 'Rubik';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/s/rubik/v26/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-B4iFV0UzdYPFkZVO.woff) format('woff');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}


/*ABOUT PAGE*/

/*
section{
  min-height: 5vh;
  justify-content: center;
  align-items: center;

}
section:nth-child(1){
  color: black;
justify-content: center;
  align-items: center;
  text-align: center;
  }
section:nth-child(2){
  color: black;
justify-content: center;
  align-items: center;
  text-align: center;
} 
section:nth-child(3){
  color: black;
justify-content: center;
  align-items: center;
  text-align: center;
}
section:nth-child(4){
  color: black;
justify-content: center;
  align-items: center;
  text-align: center;
}
section .container{

  margin-bottom: 100px;
}
section h1{
  text-align:center;
  font-size: 3rem;
    justify-content: center;
  align-items: center;
}
section h2{
  font-size: 40px;
  text-align: center;
    justify-content: center;
  align-items: center;
}
section .text-container{
   display: flex;
    justify-content: center;
  align-items: center;
}
section .text-container .text-box{
letter-spacing:1px;font-size:18px;
  background: transparent;
  
}
section .text-container .text-box h3{

  text-align: center;

  margin-bottom: 10px;

}

@media (max-width: 500px){
  section h1{
    font-size: 2rem;
    text-align: center;
  }
  section .text-container{
    flex-direction: column;
  }
}

.reveal{
  position: relative;
  transform: translateY(150px);
  opacity: 0;
  transition: 1s all ease;

}

.reveal.active{
  transform: translateY(0);
  opacity: 1;
}
*/

.aboutpage{background:#B0E1E8;overflow:auto;}
/*.aboutcontainer{margin-left:-50px;margin-right:-50px;height:100px;}*/
.rowwelcome{z-index:1!important;}
.div1welcome{position:relative;width:100%;z-index:1;background:#EEE8FF;}

/*Old Code - styling now defined in module_about for image*/
/*.image{background-image:url('beating_heart_test.png');
  height:10px!important;
width:10px!important;
  object-fit:contain;
  margin-left:-35px;margin-right:-35px;
  background-size: 100%;
  background-position: center center;
  background-repeat: no-repeat;
  text-align:center;
  padding:0;
  z-index:4000!important;
position: relative;

}*/

.containeraccordioncenter{
  position:relative;
background:#B0E1E8;z-index:1!important;

  align-items: center;margin-top:-100px;}

.div2welcome{

}



:root{
--colour_bhf_darkred:#A0003C;
--colour_bhf_lightred:#FF001F;
--colour_bhf_background_lightgrey: #DDF6F2 /*#F3F2F4;*/
--colour_bhf_neonred:#F51344;
--customValueBox_border_colour:#A95EF4;
}

/*DT Table*/
table.dataTable thead tr {
  background-color: var(--colour_bhf_darkred);
  color: white;
}


/*
@keyframes glowing {
         0% { background-color: #fcfcfc; box-shadow: 0 0 5px #A307AB; }
         50% { background-color: #F8E8FC; box-shadow: 0 0 20px #D143C8; }
         100% { background-color: #fcfcfc; box-shadow: 0 0 5px #A907AB; }
}
*/


#overview_counts{color:green;}

/*carousel*/
.columnleft {
    width: 50%;
    padding: 1%;
    text-align: center;

}
.columnright {
    width: 50%;
    margin-top:15px;
}
.rowtest{margin-right:0px;}


.columnleftwelcome {
    width: 60%;
    padding: 1%;
    
    margin-left:65px;
    margin-bottom:65px;
}

.columnrightwelcome {
    width: 40%;
}





@keyframes scroll{

  0% {
    
    transform: translateX(0);
  }
  100% {
   
    transform: translateX(calc(-250px * 3));
  }
}
.slider {

  transition: transform 0.6s ease;
  width: 100%;

  height: 80px;
  overflow:hidden;
  float: right;
  position: relative;

  margin-bottom:30px;
  margin-top:10px;

}
.slider-wrap {

    animation: scroll 24s linear infinite;
    animation-play-state: running;
    display: flex;
    width: calc(250px * 6);
    height:100%;
}

.slide-image{
  width:100%;
  height:100%;
  object-fit:fit;
  padding:10px;
  transition: all .9s;

}
.slide{
  width:150px;
  height:100%;
  border-left:20px;
  border-right:20px;
  text-align:center;

}




.slide-image:hover{
transform: scale(1.3);

}



.slider-wrap:hover{animation-play-state: paused;}


#section_heading_hyper{margin-top:-3px;}
#section_heading_hyper a:link{color:#7345cc!important;text-decoration: none; }
#section_heading_hyper a:visited{color:#7345cc!important;text-decoration: none; }
#section_heading_hyper a:hover{color:#FF002E!important;text-decoration: none; }
#section_heading_hyper a:active{color:#FF002E!important;text-decoration: none; }



/*############################################################################*/
/*All this section is for the export dropdowns but css is also controlled from the modules themselves*/
/*also see the class assigned to dropdown .btn-myClass*/


#compare_dropdown_data:active{
border-color: transparent;
color:var(--colour_bhf_neonred);
}

#compare_dropdown_image:active{
border-color: transparent;
color:var(--colour_bhf_neonred);
}

#compare_dropdown_data:disabled{
color:#6B6C6F !important;
border:none!important;
}

#compare_dropdown_image:disabled{
color:#6B6C6F !important;
border:none!important;
}



#summary_module-data_coverage_module-download_coverage_data{
background-color:white !important;
color:#6B6C6F !important;
border:none!important;
}


.sw-dropdown-in{
width:200px;
font-size:85%;

}

#compare_dropdown_data.sw-dropdown-in{

}

#compare_download_type{
margin:1%;
}





#testid{font-weight: 510;padding-top:15px;width:15%;min-height:50px;
color:#000000!important;background-color:#ABDFE7!important;border-radius: 30px;text-decoration: none !important;
z-index:100;margin-bottom:20px;margin-top:-200px;}
#testid a:link{color:#000000!important;text-decoration: none; }
#testid  a:visited{color:#000000!important;text-decoration: none; }
#testid  a:hover{color:#7044CB!important;text-decoration: none; }
#testid  a:active{color:#7044CB!important;text-decoration: none; }


a.aboutMail:link{color:#A0003C;text-decoration: none;}
a.aboutMail:hover{color:#ff0030;text-decoration: none;}
a.aboutMail:visited{color:#A0003C;text-decoration: none;}
a.aboutMail:active{color:#ff0030;text-decoration: none;}


.aboutFund:visited{color:#FFC335;}
.aboutFund:hover{color:#ff0030!important;}
.aboutFund:link{color:#FFC335;}
.aboutFund:active{color:#ff0030!important;}


/*############################################################################*/


/*Export Image Dropdown Compare - ensure border radius aligns with order of options*/
#compare_jpeg{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#compare_jpeg:hover{color:white;background-color:var(--colour_bhf_darkred);}
#compare_jpeg:active{color:white;background-color:var(--colour_bhf_darkred);}
#compare_jpeg:focus{color:white;background-color:var(--colour_bhf_darkred);}
#compare_pdf{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#compare_pdf:hover{color:white;background-color:var(--colour_bhf_darkred);}
#compare_pdf:active{color:white;background-color:var(--colour_bhf_darkred);}
#compare_pdf:focus{color:white;background-color:var(--colour_bhf_darkred);}
#compare_png{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#compare_png:hover{color:white;background-color:var(--colour_bhf_darkred);}
#compare_png:active{color:white;background-color:var(--colour_bhf_darkred);}
#compare_png:focus{color:white;background-color:var(--colour_bhf_darkred);}

#summary_module-data_coverage_module-download_summary_coverage_season_plot_jpeg{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_jpeg:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_jpeg:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_jpeg:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_pdf{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_pdf:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_pdf:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_pdf:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_png{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_png:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_png:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_season_plot_png:focus{color:white;background-color:var(--colour_bhf_darkred);}


#summary_module-data_coverage_module-download_summary_coverage_plot_jpeg{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_coverage_module-download_summary_coverage_plot_jpeg:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_jpeg:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_jpeg:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_pdf{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_coverage_module-download_summary_coverage_plot_pdf:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_pdf:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_pdf:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_png{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#summary_module-data_coverage_module-download_summary_coverage_plot_png:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_png:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_summary_coverage_plot_png:focus{color:white;background-color:var(--colour_bhf_darkred);}


#summary_module-data_completeness_module-download_summary_completeness_plot_jpeg{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_completeness_module-download_summary_completeness_plot_jpeg:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_jpeg:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_jpeg:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_pdf{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_completeness_module-download_summary_completeness_plot_pdf:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_pdf:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_pdf:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_png{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#summary_module-data_completeness_module-download_summary_completeness_plot_png:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_png:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_summary_completeness_plot_png:focus{color:white;background-color:var(--colour_bhf_darkred);}


/*Export Data Dropdown Compare - ensure border radius aligns with order of options*/
#compare_csv{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#compare_csv:hover{color:white;background-color:var(--colour_bhf_darkred);}
#compare_csv:active{color:white;background-color:var(--colour_bhf_darkred);}
#compare_csv:focus{color:white;background-color:var(--colour_bhf_darkred);}
#compare_xlsx{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#compare_xlsx:hover{color:white;background-color:var(--colour_bhf_darkred);}
#compare_xlsx:active{color:white;background-color:var(--colour_bhf_darkred);}
#compare_xlsx:focus{color:white;background-color:var(--colour_bhf_darkred);}
#compare_txt{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#compare_txt:hover{color:white;background-color:var(--colour_bhf_darkred);}
#compare_txt:active{color:white;background-color:var(--colour_bhf_darkred);}
#compare_txt:focus{color:white;background-color:var(--colour_bhf_darkred);}


#download_summary_coverage_season_plot_jpeg{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#download_summary_coverage_season_plot_jpeg:hover{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_jpeg:active{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_jpeg:focus{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_pdf{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#download_summary_coverage_season_plot_pdf:hover{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_pdf:active{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_pdf:focus{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_png{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#download_summary_coverage_season_plot_png:hover{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_png:active{color:white;background-color:var(--colour_bhf_darkred);}
#download_summary_coverage_season_plot_png:focus{color:white;background-color:var(--colour_bhf_darkred);}


#summary_module-data_coverage_module-download_coverage_data_csv{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_coverage_module-download_coverage_data_csv:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_csv:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_csv:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_xlsx{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_coverage_module-download_coverage_data_xlsx:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_xlsx:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_xlsx:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_txt{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#summary_module-data_coverage_module-download_coverage_data_txt:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_txt:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_coverage_module-download_coverage_data_txt:focus{color:white;background-color:var(--colour_bhf_darkred);}



#summary_module-data_completeness_module-download_completeness_data_csv{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_completeness_module-download_completeness_data_csv:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_csv:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_csv:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_xlsx{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_completeness_module-download_completeness_data_xlsx:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_xlsx:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_xlsx:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_txt{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#summary_module-data_completeness_module-download_completeness_data_txt:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_txt:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_completeness_module-download_completeness_data_txt:focus{color:white;background-color:var(--colour_bhf_darkred);}


#summary_module-data_dictionary_module-download_dd_csv{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_dictionary_module-download_dd_csv:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_csv:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_csv:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_xlsx{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 0px !important;
}
#summary_module-data_dictionary_module-download_dd_xlsx:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_xlsx:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_xlsx:focus{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_txt{color:#3D3C3C;background-color:white;border-color:#BEC3C6;font-size:100%;
padding-left:5%;
border-top:none;
border-top-left-radius: 0px !important;
border-bottom-left-radius: 10px !important;
border-top-right-radius: 0px !important;
border-bottom-right-radius: 10px !important;
}
#summary_module-data_dictionary_module-download_dd_txt:hover{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_txt:active{color:white;background-color:var(--colour_bhf_darkred);}
#summary_module-data_dictionary_module-download_dd_txt:focus{color:white;background-color:var(--colour_bhf_darkred);}



#ab1{padding:4px; font-size:80%; margin-bottom:-50%;margin-top:-50%;color:white;background-color:#7044CB!important;border-color:#7044CB!important;

} /*animation:glowing 1300ms infinite;*/

#ab1:hover{padding:4px; font-size:80%; margin-bottom:-50%;margin-top:-50%;background-color:#F9022F!important;border-color:#F9022F!important}

.bttn-unite.bttn-success:after{background:#F9022F!important;
text-decoration:none;}
.bttn-unite.bttn-success:focus, .bttn-unite.bttn-success:hover{background:#F9022F!important;
text-decoration:none;}
.bttn-unite.bttn-success:before{background:#F9022F!important;
text-decoration:none;}


/*.paginate_button:not(.previous):not(.next){background-color: var(--colour_bhf_darkred);color: var(--colour_bhf_darkred);}*/


#info4 { color:var(--colour_bhf_darkred) !important;

         margin: 0px;
         }




#body{color:red;background-color:blue;}

tooltip .tooltip-inner {display:inline;color:red;background-color:blue;}

.popover { visibility: hidden; background-color: blue; }
                    .tooltip:hover .tooltiptext { visibility: visible; color:red;background-color:blue;}



/*Compare - Add more data and trash*/
#add{  color:white!important;
  background-color:var(--colour_bhf_darkred)!important;
}
#add:hover{  color:white!important;
  background-color:#FF002E!important;
}


/*############################################################################*/

/*DT Information Show number label*/

/*
#DataTables_Table_1_info {
margin-top: !important;
}
#DataTables_length {
margin-left: !important; margin-top: 30% !important;
} /*length moves wrt to info*/

#DataTables_Table_1_filter {
margin-bottom: -2% !important;
}
*/

/*DataTables_Table_1_filter DataTables_Table_2_filter etc works but targets each individually - need to target whole class but dont know how*/

/*NOT WORKING
#DataTables_Table_1_length [value='10'] {
color:#FF002E!important;background-color:blue;margin-left:-14.3% !important; margin-top: -3% !important;
} /*length moves wrt to info*/ */

/*removed the outline focus col for now but for accessibility would be better to keep but replace blue with purple to fit theme*/
.dataTables_length select:focus {
        border-color: rgba(126, 220, 104, 0.8);
        box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(126, 239, 104, 0.6);
        outline: 0 none;
}

/*#DataTables_Table_1_paginate.paginate_button current{color:#FF002E !important; background-color:blue!important;}
#DataTables_Table_1_previous{color:#FF002E !important; background-color:blue!important;}*/
/*#DataTables_Table_1_paginate{margin-top:0.5% !important;}*/


/*############################################################################*/


/*reactable*/

.rt-page-size-select{
outline: 0 
}
.rt-page-info{
margin-left:-2% !important;
}
.rt-page-size{

}

.rt-pagination{background: white;}
.rt-search{background: white;}


.ReactTable .rt-tr:hover .rt-td {
    background: #EEE8FF
}

.Reactable{background: white;}

.rt-tr-group{background:white;}



/*Col names and up and down arrows*/
table.dataTable thead .sorting:after {
  color : white !important;
  opacity: 1 !important;
}

table.dataTable thead .sorting {
  color : white !important;
  opacity: 1 !important;
}

table.dataTable thead .sorting:before {
  color : white !important;
  opacity: 1 !important;
}

table.dataTable thead .sorting_asc:after {
  color : white !important;
  opacity: 1 !important;
}

table.dataTable thead .sorting_desc:after {
  color : white !important;
  opacity: 1 !important;
}




.sweet-alert h2{color: !important;font-size:20px !important;}
.sweet-alert .sa-icon.sa-info{border-color:var(--colour_bhf_lightred)!important;}
.sweet-alert .sa-icon.sa-info::before{background-color:var(--colour_bhf_lightred)!important;}
.sweet-alert .sa-icon.sa-info::after{background-color:var(--colour_bhf_lightred)!important;}


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
  color: #7345cc; text-decoration:none;
}

/* visited link */
a:visited {
  color: #7345cc; text-decoration:none;
}

/* mouse over link */
a:hover {
  color: #F9022F; display:float; text-decoration:none;
}

/* selected link */
a:active {
  color: #F9022F; text-decoration:none;
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
    /*background-color: var(--colour_bhf_darkred); 
    bottom: 0;
    content: '';
    display: block;
    height: 1.5px;
    left: 50%;
    position: absolute;
    transform: translate(-50%,0);
    width: 50%; /*Can be set width eg 10px or a%*/ */ /*LEAVE THE ELEMENT BLANK FOR NO UNDERLINE*/
}





/*The Active NarBar Tab*/
.navbar .nav-link.active,
.navbar .nav-item.show .nav-link {
 color:var(--colour_bhf_darkred) !important;
 background-color: transparent;
 border-color: transparent;
}





/*Prompter Tooltips*/
.hint--error:after {
          background: #FF002E;
          opacity: 0.95 !important;
          color: #FFFFFF;
          text-shadow: none;
          box-shadow: none;
          transition-duration: width 2s, height 2s, transform 2s;
          transition-timing-function: ease-in; 
          transition-delay: 0.5s !important;
z-index:999999 !important;
}
/*little arrow tooltip*/
.hint--error:before { 
          opacity: 0.95 !important;
          text-shadow: none;
          transition-duration: width 2s, height 2s, transform 2s;
          transition-timing-function: ease-in;
          transition-delay: 0.5s !important;
z-index:999999 !important;

}

.hint--error.hint--bottom:before {
border-bottom-color: #FF002E!important;
z-index:999999 !important;
}
.hint--error.hint--left:before {
border-left-color: #FF002E!important;
z-index:999999 !important;
}
.hint--error.hint--top:before {
border-top-color: #FF002E!important;
z-index:999999!important;
}
.hint--error.hint--right:before {
 border-right-color: #FF002E!important;
z-index:999999 !important;
}


/*bottom right arrow color*/
.hint--error.hint--bottom-left:before, .hint--error.hint--bottom-right:before, .hint--error.hint--bottom:before{
border-bottom-color:#FF002E;
}




.hint--error.hint--bottom-right:before {
 border-bottom-right-color: #FF002E!important;
z-index:999999 !important;
}






.hint--info:after {
          background: #F7F7F7;
          opacity: 0.95 !important;
          color: #6B6B6B;
          text-shadow: none;
          box-shadow: none;
          transition-duration: width 2s, height 2s, transform 2s;
          transition-timing-function: ease-in; 
          transition-delay: 0.5s !important;
}



#summary_module-data_completeness_module-order_complete-label{margin-bottom:4% !important;}



/*Plot/Summary Active Tab*/
.nav-tabs .nav-link.active,
.nav-tabs .nav-item.show .nav-link {
 color:white;
 background-color: var(--colour_bhf_darkred);
 border-color: var(--colour_bhf_darkred);
}

/*Plot/Summary NonActive Tabs*/
.nav-tabs>li>a {
color: var(--colour_bhf_darkred);
background-color:none;
border-color: none !important;
}

.nav-tabs>li>a:hover {
color: var(--colour_bhf_lightred);
background-color:none;
border-color: #E3DAFB !important; 
}


/*Tabs using data-values (not pills class)*/
/*Each data-value has an Active section, Active on hover, Non-Active Hover section then a Non-Active section*/

/*Active Tabs*/
.nav-tabs .nav-link.active[data-value='dd_meth'],
.nav-tabs[data-value='dd_meth'] .nav-item.show[data-value='dd_meth'] .nav-link[data-value='dd_meth']{
 color:var(--colour_bhf_lightred);
 background-color: #DDF6F2 !important;
 border-color: #DDF6F2!important;
}
/*Active Tabs on hover*/
.nav-link.active:hover[data-value='dd_meth']{
 color:var(--colour_bhf_darkred) !important;
 background-color: #DDF6F2 !important;
 border-color: #DDF6F2!important;
}
/*NonActive on hover Tabs*/
.nav-tabs>li>a:hover[data-value='dd_meth']{
color: var(--colour_bhf_lightred)!important;
}
/*NonActive Tabs*/
.nav-tabs>li>a[data-value='dd_meth']{
color: var(--colour_bhf_darkred)!important;
background-color:white!important;
}


/*Active Tabs*/
.nav-tabs .nav-link.active[data-value='dcom_meth'],
.nav-tabs[data-value='dcom_meth'] .nav-item.show[data-value='dcom_meth'] .nav-link[data-value='dcom_meth']{
 color:var(--colour_bhf_darkred);
 background-color: #EEE8FF !important;
 border-color: #EEE8FF!important;
}
/*Active Tabs on hover*/
.nav-link.active:hover[data-value='dcom_meth']{
 color:var(--colour_bhf_darkred) !important;
 background-color: #EEE8FF !important;
 border-color: #EEE8FF!important;
}
/*NonActive on hover Tabs*/
.nav-tabs>li>a:hover[data-value='dcom_meth']{
color: var(--colour_bhf_lightred)!important;

border-color: #E3DAFB !important;
}
/*NonActive Tabs*/
.nav-tabs>li>a[data-value='dcom_meth']{
color: var(--colour_bhf_darkred);
background-color:none;
border-color: none !important;
}
/*Active Tabs*/
.nav-tabs .nav-link.active[data-value='dcov_meth'],
.nav-tabs[data-value='dcov_meth'] .nav-item.show[data-value='dcov_meth'] .nav-link[data-value='dcov_meth']{
 color:var(--colour_bhf_darkred);
 background-color: #EEE8FF !important;
 border-color: #EEE8FF!important;
}
/*Active Tabs on hover*/
.nav-link.active:hover[data-value='dcov_meth']{
 color:var(--colour_bhf_darkred) !important;
 background-color: #EEE8FF !important;
 border-color: #EEE8FF!important;
}
/*NonActive on hover Tabs*/
.nav-tabs>li>a:hover[data-value='dcov_meth']{
color: var(--colour_bhf_lightred)!important;
border-color: #E3DAFB !important;
}
/*NonActive Tabs*/
.nav-tabs>li>a[data-value='dcov_meth']{
color: var(--colour_bhf_darkred);
background-color:none;
border-color: none !important;
}


/*Active Tabs*/
.nav-tabs .nav-link.active[data-value='dup_meth'],
.nav-tabs[data-value='dup_meth'] .nav-item.show[data-value='dup_meth'] .nav-link[data-value='dup_meth']{
 color:var(--colour_bhf_lightred);
 background-color: #EEE8FF !important;
 border-color: #EEE8FF!important;
}
/*Active Tabs on hover*/
.nav-link.active:hover[data-value='dup_meth']{
 color:var(--colour_bhf_darkred) !important;
 background-color: #EEE8FF !important;
 border-color: #EEE8FF!important;
}
/*NonActive on hover Tabs*/
.nav-tabs>li>a:hover[data-value='dup_meth']{
color: var(--colour_bhf_lightred)!important;
border-color: #E3DAFB !important;
}
/*NonActive Tabs*/
.nav-tabs>li>a[data-value='dup_meth']{
color: var(--colour_bhf_darkred);
background-color:none;
border-color: none!important;
}


/*Compare Tab input tab panels in module_compare.R*/






/*h3 headings*/
h3 { 
  color:#413C45;
}

/*h4 headings*/
h4 { 
  color:#7345cc;
}

/*h5 headings*/
h5 { 
  color:var(--colour_bhf_darkred);
  /*font-weight: bold;*/
}

/*h6 headings*/
h6 { 
  color:#413C45;
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
                         .js-irs-0 .irs-bar {background: var(--colour_bhf_darkred)  !important;
                                             border-top: 1px solid var(--colour_bhf_darkred)  !important;
                                             border-bottom: 1px solid var(--colour_bhf_darkred)  !important;}
                           .irs-from, .irs-to, .irs-single {background: #8C0032 !important;}



.irs--shiny .irs-bar {background: var(--colour_bhf_darkred)  !important; color: var(--colour_bhf_darkred) !important;
border: 1px solid var(--colour_bhf_darkred)  !important;
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




/*Compare Tab Action Buttons take the default - trash*/
.btn-secondary, .btn-default:not(.btn-primary):not(.btn-info):not(.btn-success):not(.btn-warning):not(.btn-danger):not(.btn-dark):not(.btn-outline-primary):not(.btn-outline-info):not(.btn-outline-success):not(.btn-outline-warning):not(.btn-outline-danger):not(.btn-outline-dark){
color:var(--colour_bhf_darkred);
background-color:#EEE8FF;
border-color:#EEE8FF;
}

.btn-secondary:hover, .btn-default:hover:not(.btn-primary):not(.btn-info):not(.btn-success):not(.btn-warning):not(.btn-danger):not(.btn-dark):not(.btn-outline-primary):not(.btn-outline-info):not(.btn-outline-success):not(.btn-outline-warning):not(.btn-outline-danger):not(.btn-outline-dark){
color:#FF002E;
background-color:#EEE8FF;
border-color:#EEE8FF;
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


#summary_module-data_coverage_module-download_coverage_data:hover{
background-color:white !important;
border-color:white !important;
color:var(--colour_bhf_neonred) !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}


#summary_module-data_coverage_module-download_coverage_data{ /*#data_coverage_module-download_summary_coverage_plot*/
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


#summary_module-data_completeness_module-download_coverage_data:hover{
background-color:white !important;
border-color:white !important;
color:var(--colour_bhf_neonred) !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}


#summary_module-data_completeness_module-download_coverage_data{ /*#data_coverage_module-download_summary_coverage_plot*/
background-color:white !important;
border-color:white !important;
color:#3C3C3C !important;
outline: none !important !important;
box-shadow: none !important;
margin-left:-4% !important;
}




#summary_module-data_dictionary_module-download_dd{

}


#summary_module-data_dictionary_module-download_dd:hover{

}


/*radioGroupButtons no longer used in dropdown*/
/*indents all download buttons*/
.sw-dropdown{
margin-left:-4% !important;
}
btn btn-default btn-xs action-button shiny-bound-input{
color:#3D3C3C !important;
}
.btn-myClass { color: #3D3C3C;}
.btn-myClass:hover { color: #FF002E;}
.btn-myClass:active { color: #FF002E;border-color:transparent!important;}
.glyphicon.glyphicon-triangle-top::before{color:transparent;}
.glyphicon.glyphicon-triangle-top{color:transparent;}
.sw-dropdown-content.animated.sw-dropup-content.sw-show{
/*box-shadow: none !important;*/
background-color:white;
z-index:999999;
}
.sw-dropdown-in{
/*box-shadow: none !important;*/
background-color:white;
z-index:999999;
}
.btn-check:checked+.btn-outline-primary, .btn-check:active+.btn-outline-primary, .btn-outline-primary:active, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show, .dropdown-toggle.in{
background-color:var(--colour_bhf_darkred);
color:white;
}
.btn-check:checked+.btn-outline-primary, .btn-check:active+.btn-outline-primary, .btn-outline-primary:active, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show, .dropdown-toggle.in{
border-color:#BEC3C6;
}
.btn-outline-primary{
font-size: 80%;
border-color:#BEC3C6;
color:#484D5B;
}
.btn-outline-primary:hover{
border-color:#BEC3C6;
color:var(--colour_bhf_neonred);
}


#sw-drop-download_dd{
margin-left:-1%!important;

}


#download_compare_coverage_plot:hover{
background-color:var(--colour_bhf_background_lightgrey) !important;
border-color:var(--colour_bhf_background_lightgrey) !important;
color:var(--colour_bhf_neonred) !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}


#download_compare_coverage_plot{
background-color:var(--colour_bhf_background_lightgrey) !important;
border-color:var(--colour_bhf_background_lightgrey) !important;
color:#3C3C3C !important;
outline: none !important;
box-shadow: none !important;
margin-left:-4% !important;
}

#download_coverage_data:hover{
background-color:white !important;
border-color:none !important;
color:#FF002E !important;
outline: none !important;
box-shadow: none !important;
margin-left:0% !important;
}


#download_coverage_data{
background-color:#white !important;
border-color:none !important;
color:#3C3C3C !important;
outline: none !important;
box-shadow: none !important;
margin-left:0% !important;
}







/*pretty switch*/
/*
.state {color: white !important;margin-right:0% !important;}
.state :not([class]){color: white !important;margin-right:0% !important;}
.state::before{background-color: #5A656B !important; color: #5A656B !important;margin-right:0% !important;}
.pretty.p-switch .state label:after{background-color: #FFFFFF !important; color: #FFFFFF !importantmargin-right:0% !important;}
*/






/*FOOTER CSS*/

.footer {
  position: relative;
  width: 100%;
  background: #252426;
  min-height: 100px;
z-index:999999 !important;
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
  margin-left:0;
  margin-right:0;
  margin-top:10px;
  margin-bottom:5px;
  padding:0;
  flex-wrap: wrap;

}

.social-icon__item,
.menu__item {
  list-style: none;

}

.social-icon__link {
  font-size: 2rem;
  color: #fff !important;
  margin-left: 7px;
  margin-right: 7px;
  margin-top:10px;
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
  /*margin: 15px 0 10px 0;*/
  font-size: 1rem;
  font-weight: 300;
}

.copyright-text{margin-left:1%;}


#count_heading{color:#212529!important}

/*enforce marging so info box can go beside*/
.pretty {margin-right:0% !important;}


[class*=hint--][aria-label]:after {
   white-space: pre;
}





#refresh_dd{
background-color:white !important;
border: none;
color:#7044CB !important;
outline: none !important;
box-shadow: none !important;
margin-left:-1% !important;
margin-bottom:-1.2% !important;
padding-top:-50% !important;
z-index:999999 !important
}

#refresh_dd:hover{
background-color:white !important;
border: none;
color:var(--colour_bhf_neonred) !important;
outline: none !important;
box-shadow: none !important;
margin-left:-1% !important;
margin-bottom:-1.2% !important;
padding-top:-50% !important;
}



#custom_spinner{
color:var(--colour_bhf_lightred);
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
}








.hint--error:after{position:absolute;}

#compare_coverage_plot_girafe{padding-left:12px;}

"


#Global Options FluidRow
wellpanel_style = "background: white; border-color: transparent;padding:50px;"
bhf_global_options_style = "
background: #A0003C; /*linear-gradient(to right, #8C0031, #CC0131)*/
border-top-left-radius: 10px !important; /*Round Edges*/
border-bottom-left-radius: 10px !important; /*Round Edges*/
border-top-right-radius: 10px !important; /*Round Edges*/
border-bottom-right-radius: 10px !important; /*Round Edges*/
"

bhf_tab_panel_style = "

z-index:1;
min-height: 70vh; height: 70vh; overflow-y: scroll;
background: #EEE8FF;
border-color: #EEE8FF !important;
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
                                             "border-color:","#FF002E",";",
                                             "border-width: thick;",
                                             "height:",global_options_row_height,";",
                                             "border:",global_options_row_height,";",
                                             "border-top-left-radius: 10px !important; /*Round Edges*/
                                               border-bottom-left-radius: 10px !important; /*Round Edges*/")



bhf_global_options_column_style_middle = paste("background-color:",colour_global_options,";",
                                               "border-color:","#FF002E",";",
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
color: #A0003C !important;
background-color:#EEE8FF !important;
border: 1px solid #EEE8FF!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link.active:hover {
color: #A0003C !important;
background-color:#EEE8FF !important;
border: 1px solid #EEE8FF!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link {
color: #A0003C;
background-color:white;
border: 1px solid white!important;
border-top-left-radius: 10px !important;
border-bottom-left-radius: 0px !important;
border-top-right-radius: 10px !important;
border-bottom-right-radius: 0px !important;
}
.nav-pills .nav-link:hover {
color: #FF002E !important;
background-color:white !important;
border: 1px solid #EEE8FF!important;
border-top-left-radius: 10px !important;
border-bottom-leftf-radius: 0px !important;
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



# shinyWidgets pretty switch hack ==============================================
#https://github.com/dreamRs/shinyWidgets/blob/master/R/input-pretty.R

#dependencies
attachShinyWidgetsDep <- function(tag, widget = NULL, extra_deps = NULL) {
  dependencies <- html_dependency_shinyWidgets()
  if (!is.null(widget)) {
    if (widget == "picker") {
      dependencies <- list(
        dependencies,
        # htmltools::htmlDependencies(shiny::fluidPage())[[1]],
        html_dependency_picker()
      )
    } else if (widget == "awesome") {
      dependencies <- list(
        dependencies,
        html_dependency_awesome(),
        htmltools::findDependencies(shiny::icon("rebel"))[[1]]
      )
    } else if (widget == "bsswitch") {
      dependencies <- c(
        list(dependencies),
        html_dependency_bsswitch()
      )
    } else if (widget == "multi") {
      dependencies <- list(
        dependencies,
        html_dependency_multi()
      )
    } else if (widget == "jquery-knob") {
      dependencies <- list(
        dependencies,
        html_dependency_knob()
      )
    } else if (widget == "dropdown") {
      dependencies <- list(
        dependencies,
        htmltools::htmlDependency(
          name = "dropdown-patch",
          version = packageVersion("shinyWidgets"),
          src = c(href = "shinyWidgets/dropdown"),
          script = "dropdown-click.js"
        )
      )
    } else if (widget == "sw-dropdown") {
      dependencies <- list(
        dependencies,
        htmltools::htmlDependency(
          name = "sw-dropdown",
          version = packageVersion("shinyWidgets"),
          src = c(href = "shinyWidgets/sw-dropdown"),
          script = "sw-dropdown.js",
          stylesheet = "sw-dropdown.css"
        )
      )
    } else if (widget == "animate") {
      dependencies <- list(
        dependencies,
        html_dependency_animate()
      )
    } else if (widget == "bttn") {
      dependencies <- list(
        dependencies,
        html_dependency_bttn()
      )
    } else if (widget == "spectrum") {
      dependencies <- list(
        dependencies,
        html_dependency_spectrum()
      )
    } else if (widget == "pretty") {
      dependencies <- list(
        dependencies,
        html_dependency_pretty()
      )
    } else if (widget == "nouislider") {
      dependencies <- list(
        dependencies,
        html_dependency_nouislider()
      )
    } else if (widget == "airdatepicker") {
      dependencies <- list(
        dependencies,
        html_dependency_airdatepicker()
      )
    }
    dependencies <- c(dependencies, extra_deps)
  } else {
    dependencies <- c(list(dependencies), extra_deps)
  }
  htmltools::attachDependencies(
    x = tag,
    value = dependencies,
    append = TRUE
  )
}


html_dependency_shinyWidgets <- function() {
  htmltools::htmlDependency(
    name = "shinyWidgets",
    version = packageVersion("shinyWidgets"),
    src = c(href = "shinyWidgets", file = "assets"),
    package = "shinyWidgets",
    script = "shinyWidgets-bindings.min.js",
    stylesheet = "shinyWidgets.min.css",
    all_files = FALSE
  )
}

#custom switch
prettySwitchCustom <- function(inputId,
                         label,
                         value = FALSE,
                         status = "default",
                         slim = FALSE,
                         fill = FALSE,
                         bigger = FALSE,
                         inline = FALSE,
                         width = NULL,
                         info = TRUE,
                         my_message,
                         arrow = TRUE,
                         prompt_size = "small",
                         prompt_position = "right",
                         spaces = 0 #no of spaces want between label and info icon
                         ) {
  value <- shiny::restoreInput(id = inputId, default = value)
  status <- match.arg(status, c("default", "primary", "success",
                                "info", "danger", "warning"))
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  if (fill & slim)
    message("slim = TRUE & fill = TRUE don't work well together.")
  switchTag <- tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width))  paste0("width: ", validateCssUnit(width), ";"),
    class = if (inline) "shiny-input-container-inline",
    style = if (inline) "display: inline-block; margin-right: 10px;",
    tags$div(
      class="pretty p-default p-switch", inputTag,
      class=if(bigger) "p-bigger",
      class=if(fill) "p-fill", class=if(slim) "p-slim",
      tags$div(
        class="state",
        class=if(status != "default") paste0("p-", status),
        tags$label(tags$span(paste0(label,stringi::stri_dup(intToUtf8(160),spaces)), id = "pretty_custom_label"))
      )
    ) , if (info) {tags$span(icon("info-circle"), id = "pretty_custom_icon") %>% add_prompt(
      arrow = arrow,
      message = my_message,
      position = prompt_position, type = "error",
      size = prompt_size, rounded = TRUE,
      bounce=FALSE,animate=FALSE)}
  )
  attachShinyWidgetsDep(switchTag, "pretty")
}




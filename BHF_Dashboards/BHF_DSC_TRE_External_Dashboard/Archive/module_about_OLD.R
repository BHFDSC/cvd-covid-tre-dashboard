aboutOutput <- function(id){
  ns <- NS(id)
  
  #<img src="beating_heart.png" alt="BHF Beating Heart of Data" style="margin-top:-14.5%;margin-bottom:0px !important;margin-left:0px !important;margin-right:0px !important;padding:0px!important;border:0px!important;">
  tagList(
    
    tabPanel("About",
         
         HTML('
              <div class="aboutcontainer">
            
              <div class="rowwelcome">
              <div class="columnleftwelcome" >
              <span style="letter-spacing:1px;font-size:38px;text-align: left;">Welcome to the <br><b>CVD-COVID-UK/COVID-IMPACT</b><br>TRE Dashboard</span>
              </div>
              <div class="columnrightwelcome" >
              </div>
              </div>
              
              
              <div class="aboutall">
              <div class="image_container">
              
              <section>
              <div class="container reveal fade-bottom">
              <span style="font-size:38px;"><h2>What is the purpose of this dashboard?</h2></span>
              <span style="font-size:20px;font-weight: 200;">
              <br>Explore the datasets currently available in the BHF Data Science Centre <b>Trusted Research Environments (TREs)</b>,
              <br> provided by NHS England for England, the National Data Safe Haven for Scotland and the SAIL Databank for Wales.
              <br><br>Our TREs provide linked, <b>de-identified</b> health records from primary and secondary care, COVID lab tests and vaccinations,<br> deaths, critical care, prescribing/dispensing, cardiovascular and stroke audits, maternity services and mental health.  
              <br><br>Use the dashboard to <b>discover</b> the size and coverage of these datasets and browse the variables available with their corresponding completeness and data dictionaries. Use our compare tool to <b>explore</b> how coverage changes between datasets.
              </span>
              </div>
              </section>
              
              <section>
              <div class="container reveal fade-bottom">
              <span style="font-size:38px;"><h2>Who is this dashboard for?</h2></span>
              <span style="font-size:20px;font-weight: 200;">
              <br>Our dashboard is primarily aimed at <b>researchers</b> interested in finding out more about the datasets available<br>within the BHF Data Science Centre TREs. 
              <br><br>You may use the dashboard as a data source <b>scoping tool</b> to aid your project proposals.<br>If we have the data your project requires and you are interested in becoming a member of the consortium,
              <br>please <a href="mailto:someone@yoursite.com" class="aboutMail"><b>email</b></a> us for more details.
              <br><br>If you have further questions relating to the datasets available,
              <br>please <a href="mailto:someone@yoursite.com" class="aboutMail"><b>email</b></a> the <b>health data science</b> team and we would be happy to help.
              </span>
              </div>
              </section>
              
              <section>
              <div class="container reveal fade-bottom">
              <span style="font-size:38px;"><h2>Using the dashboard</h2></span>
              <span style="font-size:20px;font-weight: 200;">
              <br>Start by using our <b>Summary</b> dashboard to get to know the data your project could have access to at a population level.<br>Browse the catalogue of datasets available to consortium members by respective nations and learn the nature of the collected records.<br>Data dictionaries are provided by the NHS Digital Data Wrangler team allowing you to visualise the structure of the raw data. Coverage plots provide the number of records available over time and completeness plots give an insight into the quality of variables that are captured in each set.
              <br><br>In the likely event that many datasets are of interest to you and your project, you may wish to use our <b>Compare</b> dashboard to compare record availability over time and by dataset. You may note that coverage across datasets can vary wildly, and this may affect the research dataset that you may put together.
              <br><br>We encourage you to reference the <b>Methodology</b> library as you use the dashboard to help you understand<br>how the aggregate data was put together and the limitations that follow.
              </span>
              </div>
              </section>
              
             
              </div>
              </div>
              </div>
 '),
         div(
           id = "loading_page",
           
           fluidRow(column(12,
                           
                           fixedRow(column(12,div(id="testid",shinyLink(to = "summary", label = "Begin Exploring")),align = "center",style="margin:0px;padding-bottom:30px;border:0px;"))
           )),
           



         ))


  )
}
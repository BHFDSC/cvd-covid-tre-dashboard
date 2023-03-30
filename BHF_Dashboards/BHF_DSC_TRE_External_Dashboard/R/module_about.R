aboutUI<- function(id){
  ns <- NS(id)

  
  #<img src="beating_heart.png" alt="BHF Beating Heart of Data" style="margin-top:-14.5%;margin-bottom:0px !important;margin-left:0px !important;margin-right:0px !important;padding:0px!important;border:0px!important;">
  tagList(
    

    
    tabPanel("About",
         
         HTML('
              
          <div aboutpage>
              <div class="div1welcome">  
  
                  
                  <div class="columnleftwelcome" >
                  <span style="letter-spacing:1px;font-size:34px;text-align:left;">
                  <br>Welcome to the<br>
                  <a href="https://www.hdruk.ac.uk/projects/cvd-covid-uk-project/">CVD-COVID-UK/COVID-IMPACT</a> <br>
                  Dataset Summary Dashboard<br>


          
                  </span>
                  <span style="letter-spacing:1px;font-size:18px;text-align:left;">
                  provided by <span style="color:;">BHF Data Science Centre </span>
                  led by <span style="color:;">Health Data Research UK</span><br>
                  in partnership with NHS England, SAIL Databank, and Public Health Scotland</span>

                  </div>
                  <div class="columnrightwelcome" >
                  </div>
               
  
                  <div class="image">
                   <img src="beating_heart_test.png" alt="BHF Beating Heart of Data" style="width:100%;height:100vh;">
                  </div>
              </div>
              
           <div class="div2welcome">
           <section>


<div class="containeraccordioncenter">
<div class="containeraccordion">
  <h2>Frequently Asked Questions</h2>
  <div class="accordion">
    <div class="accordion-item">
      <button id="accordion-button-1" aria-expanded="false"><span class="accordion-title">What is the purpose of this dashboard?</span><span class="icon" aria-hidden="true"></span></button>
      <div class="accordion-content">
        <p>The dashboard provides an overview and interactive summaries of the datasets currently available through CVD-COVID-UK/COVID-IMPACT within the secure Trusted Research Environments (TREs) provided by NHS England for England, the National Data Safe Haven for Scotland and the SAIL databank for Wales. 
        CVD-COVID-UK aims to understand the relationship between COVID-19 and cardiovascular diseases such as heart attack, heart failure, stroke, and blood clots in the lungs through analyses of de-identified, linked, nationally collated healthcare datasets across the four nations of the UK. 
        COVID-IMPACT is an expansion of this approach to address research questions looking at the impact of COVID-19 on other health conditions and their related risk factors. 
        The dashboard can be used to explore the data dictionaries, data coverage and data completeness for each of the datasets provisioned in England, Scotland, and Wales. 
        The datasets include those from primary and secondary care, COVID lab tests and vaccinations, deaths, critical care, prescribing/dispensing, cardiovascular and stroke audits, maternity services and mental health.</p>
      </div>
    </div>
    <div class="accordion-item">
      <button id="accordion-button-2" aria-expanded="false"><span class="accordion-title">Who is this dashboard for?</span><span class="icon" aria-hidden="true"></span></button>
      <div class="accordion-content">
        <p>The dashboard is primarily aimed at researchers interested in finding out more about the datasets available through CVD-COVID-UK/COVID-IMPACT. 
    Researchers preparing a project proposal may find this a useful tool to help plan their project and assess feasibility without having access to the data. 
    Please contact the <a href="bhfdsc_hds@hdruk.ac.uk" class="aboutMail"><b>BHF DSC Health Data Science Team</b></a> if you would like to discuss the scope and feasibility of a potential project in more detail. 
    For any enquiries about the application process for accessing data in the TREs please contact the <a href="bhfdsc@hdruk.ac.uk." class="aboutMail"><b>BHF DSC</b></a>. 
    The dashboard may also be useful for the members of approved project teams that are not accessing data but are actively contributing to the research process.</p>
      </div>
    </div>
    <div class="accordion-item">
      <button id="accordion-button-5" aria-expanded="false"><span class="accordion-title">Using the dashboard</span><span class="icon" aria-hidden="true"></span></button>
      <div class="accordion-content">
        <p>For each of the datasets available, the dashboard provides: a basic description; links to further sources of more information (e.g., Health Data Research Innovation Gateway); the data dictionary; overall number of records; the data coverage over time; and the completeness of each variable. 
              Datasets are presented individually on the <b>Dataset Summary</b> dashboard, but users additionally have the option of comparing the data coverage over time for datasets, both within and between nations, on the <b>Dataset Comparison</b> dashboard. Please reference the <b>Methodology</b> library which provides descriptions of how the data has been generated, definitions of the terminology used within the different components of the dashboard, and guidance for the interpretation of the information presented. 
              For further information about the dashboard please contact the <a href="bhfdsc_hds@hdruk.ac.uk" class="aboutMail"><b>BHF DSC Health Data Science Team</b></a>. For any enquiries about the application process for accessing data in the TREs please contact the <a href="bhfdsc@hdruk.ac.uk." class="aboutMail"><b>BHF DSC</b></a>.
              <br><br>
              Please note that only aggregated data is provided through this dashboard, all of which has had the appropriate disclosure control applied and been approved for export from the each respective TRE by trained output checkers.
              <br><br>
              This dataset summary dashboard will be updated on a monthly basis for each nation.</p>
      </div>
    </div>
  </div>
</div>
</div>
             </section>


</div>
</div>



 '),
         div(
           id = "loading_page", #id = "loading_page"
           
           fluidRow(column(12,
                           
                           fixedRow(column(12,div(id="testid",shinyLink(to = "summary", label = "Begin Exploring")),align = "center",style=""))
           )),
           



         ))


  )
}


aboutServer <- function(id, dataset_summary, nation_summary, coverage_data) {
  moduleServer(
    id,
    function(input, output, session) {
      
      #JS for the accordion RAN IN THE MODULE to save confusions with namespaces
      runjs("const items = document.querySelectorAll('.accordion button');

function toggleAccordion() {
  const itemToggle = this.getAttribute('aria-expanded');
  
  for (i = 0; i < items.length; i++) {
    items[i].setAttribute('aria-expanded', 'false');
  }
  
  if (itemToggle == 'false') {
    this.setAttribute('aria-expanded', 'true');
  }
}

items.forEach(item => item.addEventListener('click', toggleAccordion));")
      
    }
    
  )
  
}

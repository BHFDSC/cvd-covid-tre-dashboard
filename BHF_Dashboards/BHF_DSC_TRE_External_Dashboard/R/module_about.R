aboutUI<- function(id){
  ns <- NS(id)

  
  #<img src="beating_heart.png" alt="BHF Beating Heart of Data" style="margin-top:-14.5%;margin-bottom:0px !important;margin-left:0px !important;margin-right:0px !important;padding:0px!important;border:0px!important;">
  tagList(
    

    
    tabPanel("About",
         
         HTML('
              
          <div class="aboutpage">
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
                   <img src="beating_heart_test.png" alt="BHF Beating Heart of Data" style="width:100%;height:60vh;z-index:10000!important;">
                  </div>
              </div>
              
           <div class="div2welcome">
           

<div class="containeraccordioncenter">
<section>
<div class="card-wrapper  | content-cc">

  <div class="faq-card">


    <main class="faq-content">

          <div class="faq-title"><p>Frequently Asked Questions</p></div>

      <div class="faq-articles">

        <article class="faq-accordion">

          <input type="checkbox" class="tgg-title" id="tgg-title-1">

          <div class="faq-accordion-title">
            <label for="tgg-title-1">
              <h2>What is the purpose of this dashboard?</h2>
              <span class="arrow-icon">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>

          <div class="faq-accordion-content">
            <p>The dashboard provides an overview and interactive summaries of the datasets currently available through CVD-COVID-UK/COVID-IMPACT within the secure Trusted Research Environments (TREs) provided by NHS England for England, the National Data Safe Haven for Scotland and the SAIL databank for Wales. 
        <br><br>CVD-COVID-UK aims to understand the relationship between COVID-19 and cardiovascular diseases such as heart attack, heart failure, stroke, and blood clots in the lungs through analyses of de-identified, linked, nationally collated healthcare datasets across the four nations of the UK. 
        COVID-IMPACT is an expansion of this approach to address research questions looking at the impact of COVID-19 on other health conditions and their related risk factors. 
        <br><br>The dashboard can be used to explore the data dictionaries, data coverage and data completeness for each of the datasets provisioned in England, Scotland, and Wales. 
        The datasets include those from primary and secondary care, COVID lab tests and vaccinations, deaths, critical care, prescribing/dispensing, cardiovascular and stroke audits, maternity services and mental health.</p>
          </div>

        </article> <!-- faq accordion -->

        

        <article class="faq-accordion">

          <input class="tgg-title" type="checkbox" id="tgg-title-4">

          <div class="faq-accordion-title">
            <label for="tgg-title-4">
              <h2>
                Who is this dashboard for?
              </h2>
              <span class="arrow-icon">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>

          <div class="faq-accordion-content">
            <p>The dashboard is primarily aimed at researchers interested in finding out more about the datasets available through CVD-COVID-UK/COVID-IMPACT. 
    Researchers preparing a project proposal may find this a useful tool to help plan their project and assess feasibility without having access to the data. 
    <br><br>Please contact the <a href="bhfdsc_hds@hdruk.ac.uk" class="aboutMail"><b>BHF DSC Health Data Science Team</b></a> if you would like to discuss the scope and feasibility of a potential project in more detail. 
    <br><br>For any enquiries about the application process for accessing data in the TREs please contact the <a href="bhfdsc@hdruk.ac.uk." class="aboutMail"><b>BHF DSC</b></a>. 
    <br><br>The dashboard may also be useful for the members of approved project teams that are not accessing data but are actively contributing to the research process.</p>
          </div>

        </article> <!-- faq accordion -->

        <article class="faq-accordion">

          <input class="tgg-title" type="checkbox" id="tgg-title-5">

          <div class="faq-accordion-title">
            <label for="tgg-title-5">
              <h2>
                How should the dashboard be used?
              </h2>
              <span class="arrow-icon">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>

          <div class="faq-accordion-content">
            <p>For each of the datasets available, the dashboard provides: a basic description; links to further sources of more information (e.g., Health Data Research Innovation Gateway); the data dictionary; overall number of records; the data coverage over time; and the completeness of each variable. 
              <br><br>Datasets are presented individually on the <span style="font-weight:bold">Dataset Summary</span> dashboard, but users additionally have the option of comparing the data coverage over time for datasets, both within and between nations, on the <b>Dataset Comparison</b> dashboard. Please reference the <b>Methodology</b> library which provides descriptions of how the data has been generated, definitions of the terminology used within the different components of the dashboard, and guidance for the interpretation of the information presented. 
              <br><br>For further information about the dashboard please contact the <a href="bhfdsc_hds@hdruk.ac.uk" class="aboutMail"><b>BHF DSC Health Data Science Team</b></a>. For any enquiries about the application process for accessing data in the TREs please contact the <a href="bhfdsc@hdruk.ac.uk." class="aboutMail"><b>BHF DSC</b></a>.
              <br><br>
              Please note that only aggregated data is provided through this dashboard, all of which has had the appropriate disclosure control applied and been approved for export from the each respective TRE by trained output checkers.
              <br><br>
              This dataset summary dashboard will be updated on a monthly basis for each nation.</p>
          </div>

        </article> <!-- faq accordion -->



      </div> <!-- faq articles -->

    </main> <!-- faq -->

  </div> <!-- faq card -->

</div> <!-- card wrapper -->

             </section>

</div>
</div>










</div>



 ')
,
         div(
           id = "loading_page", #id = "loading_page"

           fluidRow(column(12,

                           fixedRow(column(12,div(id="testid",shinyLink(to = "summary", label = "Begin Exploring")),align = "center",style=""))
           )),




         )
)


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

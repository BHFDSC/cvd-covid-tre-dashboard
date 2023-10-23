aboutUI<- function(id){
  ns <- NS(id)

  
  #<img src="beating_heart.png" alt="BHF Beating Heart of Data" style="margin-top:-14.5%;margin-bottom:0px !important;margin-left:0px !important;margin-right:0px !important;padding:0px!important;border:0px!important;">
  tagList(
    

    
    
         
         HTML('
              
          <div class="aboutpage">
              <div class="div1welcome">  
  
                  
                  <div class="columnleftwelcome" >
                  <span style="letter-spacing:1px;font-size:34px;text-align:left;">
                  <br>Welcome to the<br>
                  <a href="https://bhfdatasciencecentre.org/areas/cvd-covid-uk-covid-impact/" target = "_blank" >CVD-COVID-UK/COVID-IMPACT</a> <br>
                  Dataset Insight Resource<br>


          
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
    <br><br>Please contact the <a href="mailto:bhfdsc_hds@hdruk.ac.uk" class="aboutMail"><b>BHF Data Science Centre Health Data Science Team</b></a> if you would like to discuss the scope and feasibility of a potential project in more detail. 
    <br><br>For any enquiries about the application process for accessing data in the TREs please contact the <a href="mailto:bhfdsc@hdruk.ac.uk." class="aboutMail"><b>BHF Data Science Centre</b></a>. 
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
              <br><br>For further information about the dashboard please contact the <a href="mailto:bhfdsc_hds@hdruk.ac.uk" class="aboutMail"><b>BHF Data Science Centre Health Data Science Team</b></a>. For any enquiries about the application process for accessing data in the TREs please contact the <a href="mailto:bhfdsc@hdruk.ac.uk." class="aboutMail"><b>BHF Data Science Centre</b></a>.
              <br><br>
              Please note that only aggregated data is provided through this dashboard, all of which has had the appropriate disclosure control applied and been approved for export from the each respective TRE by trained output checkers.
              <br><br>
              This dataset summary dashboard will be updated on a monthly basis for each nation.</p>
          </div>


        </article> <!-- faq accordion -->








        <article class="faq-accordion">

          <input class="tgg-title" type="checkbox" id="tgg-title-6">

          <div class="faq-accordion-title">
            <label for="tgg-title-6">
              <h2>
                How can I cite the dashboard?
              </h2>
              <span class="arrow-icon">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>

          <div class="faq-accordion-content">
            <p>Please share, cite or link the Dataset Summary Dashboard using our DOI: <br> <a href="https://zenodo.org/badge/latestdoi/693238306" target = "_blank"><img src="https://zenodo.org/badge/693238306.svg" alt="DOI"></a></p>
          </div>


        </article> <!-- faq accordion -->



        <article class="faq-accordion">

          <input class="tgg-title" type="checkbox" id="tgg-title-7">

          <div class="faq-accordion-title">
            <label for="tgg-title-7">
              <h2>
                Can I access the code that made this dashboard?
              </h2>
              <span class="arrow-icon">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>



          <div class="faq-accordion-content">
            <p>Yes! We are committed to producing open source, transparent and reproducible research. Please find our repository at <a href="https://github.com/BHFDSC/cvd-covid-tre-dashboard" class="aboutFund" target = "_blank">BHFDSC GitHub</a>.</p>
          </div>


        </article> <!-- faq accordion -->




        <article class="faq-accordion">

          <input class="tgg-title" type="checkbox" id="tgg-title-8">

          <div class="faq-accordion-title">
            <label for="tgg-title-8">
              <h2>
                How do I access the data used in this dashboard?
              </h2>
              <span class="arrow-icon">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>



          <div class="faq-accordion-content">
            <p>To access the <b>summary data</b>, such as those used to create the visualisations in this dashboard, 
           you will find a <b>Download Data</b> option beside each plot, specific to your chosen dataset. 
          You can also find this data in our source code.

        To access patient-level data in the described datasets, 
      you will need to follow an approvals process with the relevant data provider. 
     If you would like to do this via the consortium, please <a href="mailto:bhfdsc@hdruk.ac.uk." class="aboutMail"><b>get in touch</b></a>,
   for advice and support.</p>
          </div>


        </article> <!-- faq accordion -->




      </div> <!-- faq articles -->

    </main> <!-- faq -->

  </div> <!-- faq card -->

</div> <!-- card wrapper -->



             </section>






<div class="containeraccordioncenterfunding">
<section>

<div class="card-wrapperfunding  | content-cc">

  <div class="faq-cardfunding">


    <main class="faq-contentfunding">

          <div class="faq-titlefunding"><p>Funding & Acknowledgements </p></div>

      <div class="faq-articlesfunding">

        <article class="faq-accordionfunding">

          <input type="checkbox" class="tgg-titlefunding" id="tgg-title-1funding">

          <div class="faq-accordionfunding-title">
            <label for="tgg-title-1funding">
              <h2>Funding</h2>
              <span class="arrow-iconfundingfunding">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>

          <div class="faq-accordionfunding-content">
            <p>The British Heart Foundation Data Science Centre (grant No SP/19/3/34678, awarded to Health Data Research (HDR) UK) funded co-development (with NHS England) of the Secure Data Environment service for England, provision of linked datasets, data access, user software licences, computational usage, and data management and wrangling support, with additional contributions from the HDR UK Data and Connectivity component of the UK Government Chief Scientific Adviser’s National Core Studies programme to coordinate national COVID-19 priority research. Consortium partner organisations funded the time of contributing data analysts, biostatisticians, epidemiologists, and clinicians.

<br><br>This research is part of the Data and Connectivity National Core Study, led by Health Data Research UK in partnership with the Office for National Statistics and funded by UK Research and Innovation (grant ref MC_PC_20058). This work was also supported by The Alan Turing Institute via ‘Towards Turing 2.0’ EPSRC Grant Funding.

<br><br>This work was supported by the Con-COV team funded by the Medical Research Council (grant number: MR/V028367/1), HDR UK (HDR-9006) and the ADR Wales programme of work, part of the Economic and Social Research Council (part of UK Research and Innovation) funded ADR UK (grant ES/S007393/1).

<br><br>This work was supported by Health Data Research UK, which receives its funding from HDR UK Ltd (HDR-9006) funded by the UK Medical Research Council, Engineering and Physical Sciences Research Council, Economic and Social Research Council, Department of Health and Social Care (England), Chief Scientist Office of the Scottish Government Health and Social Care Directorates, Health and Social Care Research and Development Division (Welsh Government), Public Health Agency (Northern Ireland), British Heart Foundation (BHF) and the Wellcome Trust.

<br><br>This work was supported by the Wales COVID-19 Evidence Centre, funded by Health and Care Research Wales.</p>
          </div>

        </article> <!-- faq accordion -->

        

        <article class="faq-accordionfunding">

          <input class="tgg-titlefunding" type="checkbox" id="tgg-title-4funding">

          <div class="faq-accordionfunding-title">
            <label for="tgg-title-4funding">
              <h2>
                Acknowledgements
              </h2>
              <span class="arrow-iconfunding">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>

          <div class="faq-accordionfunding-content">
            <p>This work is carried out with the support of the BHF Data Science Centre led by HDR UK (BHF Grant no. SP/19/3/34678). This study makes use of de-identified data held in NHS England’s Secure Data Environment service for England, the SAIL Databank and the Scottish National Data Safe Haven and made available via the BHF Data Science Centre’s CVD-COVID-UK/COVID-IMPACT consortium. This work uses data provided by patients and collected by the NHS as part of their care and support. We would also like to acknowledge all data providers who make health relevant data available for research.

<br><br>The study makes use of anonymised data held in the Scottish National Safe Haven. The authors would like to acknowledge the support of the eDRIS Team (Public Health Scotland) for their involvement in obtaining approvals, provisioning and linking data and the use of the secure analytical platform within the National Safe Haven.

<br><br>This study makes use of anonymised data held in the Secure Anonymised Information Linkage (SAIL) Databank. This work uses data provided by patients and collected by the NHS as part of their care and support. We would also like to acknowledge all data providers who make anonymised data available for research. We wish to acknowledge the collaborative partnership that enabled acquisition and access to the de-identified data, which led to this output. The collaboration was led by the Swansea University Health Data Research UK team under the direction of the Welsh Government Technical Advisory Cell (TAC) and includes the following groups and organisations: the SAIL Databank, Administrative Data Research (ADR) Wales, Digital Health and Care Wales (DHCW), Public Health Wales, NHS Shared Services Partnership (NWSSP) and the Welsh Ambulance Service Trust (WAST). All research conducted has been completed under the permission and approval of the SAIL independent Information Governance Review Panel (IGRP) project number 0911.

<br><br><b>
Finally, we would like to thank the NHS England Data Wrangler team for producing the data summaries for England and collaborating with the BHF Data Science Centre Health Data Science team.
</b></p>

</p>
          </div>

        </article> <!-- faq accordion -->


        <article class="faq-accordionfunding">

          <input class="tgg-titlefunding" type="checkbox" id="tgg-title-5funding">

          <div class="faq-accordion-title">
            <label for="tgg-title-5funding">
              <h2>
                Ethical approval and data availability
              </h2>
              <span class="arrow-iconfunding">
                <img src="https://raw.githubusercontent.com/Romerof/FAQ-accordion-card/main/images/icon-arrow-down.svg">
              </span>
            </label>
          </div>

          <div class="faq-accordionfunding-content">
            <p>The North East - Newcastle and North Tyneside 2 research ethics committee provided ethical approval for the CVD-COVID-UK/COVID-IMPACT research programme (REC No 20/NE/0161) to access, within secure trusted research environments, unconsented, whole-population, de-identified data from electronic health records collected as part of patients’ routine healthcare.

<br><br>The data used in this study are available in NHS England’s <a href="https://digital.nhs.uk/services/secure-data-environment-service" class="aboutFund" target = "_blank">Secure Data Environment (SDE)</a> service for England, but as restrictions apply they are not publicly available.
The CVD-COVID-UK/COVID-IMPACT programme, led by the <a href="https://bhfdatasciencecentre.org/" class="aboutFund" target = "_blank">BHF Data Science Centre</a>, received approval to access data in NHS England’s SDE service for England from the 
<a href="https://digital.nhs.uk/about-nhs-digital/corporate-information-and-documents/independent-group-advising-on-the-release-of-data" class="aboutFund" target = "_blank">Independent Group Advising on the Release of Data (IGARD)</a> via an application made in the 
<a href="https://digital.nhs.uk/services/data-access-request-service-dars/dars-products-and-services" class="aboutFund" target = "_blank">Data Access Request Service (DARS)</a> Online system (ref. DARS-NIC-381078-Y9C5K). 
The <a href="https://bhfdatasciencecentre.org/areas/cvd-covid-uk-covid-impact/" class="aboutFund" target = "_blank">CVD-COVID-UK/COVID-IMPACT</a> Approvals & Oversight Board subsequently granted approval to this project to access the data within NHS England’s SDE service for England, the Scottish National Safe Haven and the Secure Anonymised Information Linkage (SAIL) Databank.
The de-identified data used in this study were made available to accredited researchers only.  
Those wishing to gain access to the data should contact the <a href="mailto:bhfdsc@hdruk.ac.uk." class="aboutMail"><b>BHF Data Science Centre</b></a> in the first instance.

<br><br>Data used in this study are available in the Scottish National Safe Haven (Project Number: 2021-0102), but as restrictions apply they are not publicly available.
Access to data may be granted on application to, and subject to approval by, the 
<a href="https://www.informationgovernance.scot.nhs.uk/pbpphsc/" class="aboutFund" target = "_blank">Public Benefit and Privacy Panel for Health and Social Care (PBPP)</a>. 
Applications are co-ordinated by <a href="https://www.isdscotland.org/Products-and-services/Edris/" class="aboutFund" target = "_blank">eDRIS (electronic Data Research and Innovation Service)</a>. 
The anonymised data used in this study was made available to accredited researchers only through the Public Health Scotland (PHS) <a href="https://www.isdscotland.org/Products-and-services/Edris/_docs/eDRIS-User-Agreement-v16.pdf" class="aboutFund" target = "_blank">eDRIS User Agreement</a>.

<br><br>The data used in this study are available in the SAIL Databank at Swansea University, Swansea, UK, but as restrictions apply they are not publicly available. 
All proposals to use SAIL data are subject to review by an independent Information Governance Review Panel (IGRP). Before any data can be accessed, approval must be given by the IGRP. 
The IGRP gives careful consideration to each project to ensure proper and appropriate use of SAIL data. When access has been granted, it is gained through a privacy protecting safe haven and remote access system referred to as the SAIL Gateway. 
All research conducted has been completed under the permission and approval of the SAIL independent Information Governance Review Panel (IGRP) project number 0911. 
SAIL has established an application process to be followed by anyone who would like to access data via <a href="https://www.saildatabank.com/application-process" class="aboutFund" target = "_blank">SAIL</a>.</p>
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










</div>



 ')
# ,
#          div(
#            id = "loading_page", #id = "loading_page"
#            
#            fluidRow(column(12,
#                            
#                            fixedRow(column(12,div(id="testid",shinyLink(to = "summary", label = "Begin Exploring")),align = "center",style=""))
#            )),
#            
# 
# 
# 
#          )



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

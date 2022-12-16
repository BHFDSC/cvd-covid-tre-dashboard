library(tidyverse)
library(readxl)

dataset_dashboard_list = function(nation,key="Dataset available"){
  
  nation_datasets = datasets_available %>%
    filter(Key==key & Nation==nation) %>%
    select(Group,Title,Dataset) %>%
    distinct()
  
  nation_datasets_list = list()
  
  groups = pull(distinct(nation_datasets,Group))
  
  for(i in 1:length(groups)){
    nation_datasets_list[[i]]=
      setNames(
        pull(filter(nation_datasets,Group==groups[i]),Dataset),
        pull(filter(nation_datasets,Group==groups[i]),Title)
      )
  }
  
  names(nation_datasets_list) = groups
  
  return(nation_datasets_list)
  
}



read_excel_allsheets <- function(filename, tibble = FALSE, except_sheet_no = NA, skip = 0, collate = TRUE) {
  # reading all the names of the sheets
  sheets <- readxl::excel_sheets(filename)
  # applying any exceptions eg cover sheets  
  if (!sum(is.na(except_sheet_no))){
    sheets <- sheets[-except_sheet_no]
  }
  
  
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X, skip = skip))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  if (collate){
    x <- dplyr::  bind_rows(x)
  }
  x
}


shhh = function(x){suppressWarnings(suppressMessages(x))}


split_occurrence = function(x, sep, n, keep = "lhs") {
  # Split by sep
  split_all = str_split(x, sep)
  # Take 1 to nth output on lhs and remaining on rhs
  lhs = lapply(split_all, function(y) {y[1:n]})
  rhs = lapply(split_all, function(y) {y[(n+1):length(y)]})
  # Collapse
  lhs_collapse = lapply(lhs, function(y) {paste(y, collapse = sep)})
  rhs_collapse = lapply(rhs, function(y) {paste(y, collapse = sep)})
  # Return unlisted
  if (keep == "lhs") {
    return(unlist(lhs_collapse))
  } else if (keep == "rhs") {
    return(unlist(rhs_collapse))
  } else {
    return(as.character(NA))
  }
}


footer_template <- function(export_date,email_link,twitter_link,youtube_link) {
  glue::glue(
    '<html>
           <body>
  <footer class="footer">
    <ul class="social-icon">
      <li class="social-icon__item"><a class="social-icon__link" 
      href={email_link} target="_blank">
          <ion-icon name="mail-outline"></ion-icon>
        </a></li>
      <li class="social-icon__item"><a class="social-icon__link" 
      href={twitter_link} target="_blank">
          <ion-icon name="logo-twitter"></ion-icon>
        </a></li>
      <li class="social-icon__item"><a class="social-icon__link" 
      href={youtube_link} target="_blank">
          <ion-icon name="logo-youtube"></ion-icon>
        </a></li>
    </ul>

</div>
<hr>
</div>
 <p class="copyright-text">This dashboard is updated on a monthly basis by nation.
</p>
        
  </footer>
  <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>'
  )
}


#' Shiny Link
#'
#' Create a link to an internal tab panel
#'
#' @param to page to navigate to
#' @param label text that describes the link
#'
#' @importFrom shiny tags
#' @export
shinyLink <- function(to, label) {
  tags$a(
    class = "shiny__link",
    href = to, #receive value of the page (i.e., tab panel) that you would like to navigate to
    label #description of the link: if you want to render the value for label as HTML, then wrap label in the HTML()
  )
}


not_all_na <- function(x) any(!is.na(x))



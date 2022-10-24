library(tidyverse)

dataset_dashboard_list = function(nation,key="Dataset available"){
  
  nation_datasets = datasets_available %>%
    filter(Key==key & Nation==nation)
  
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




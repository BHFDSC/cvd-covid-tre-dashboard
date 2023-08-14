GDPPR SNOMED-CT Dashboard
README containing contextual information for the SNOMED Dashboard.

## Description
This project contains a exploratory dashboard that provides researchers with information on the Systemized Nomenclature of Medicine - Clinical Terms (SNOMED CT) codes and clusters in the General Practice Extraction Service (GPES) Data for Pandemic Planning and Research (GDPPR).

The dashboard currently covers the top 10 codes (top 9 and a category for others) for 16 clusters. The underlying data is pulled from the Secure Data Environment (SDE) and an update to include all codes would be required.

##Tables and Data Sets
full_df.csv: includes the cluster code, description, and category for 16 code clusters in GDPPR as well as provides the monthly number of records per cluster and concept. 

data dictionary.xlsx: Derived from full_df contains meta data information on the variables used in the dashboard. Would require updating when new variables are added into full_df.

second_import.csv: Includes aggregate cluster information, currently has information on cluster category, date(year and month), records in the month, distinct records in the month, records in the category, distinct records in the category, percentage of occurrences before 1990 and the number of clusters in the category.  Would require updating to include all clusters in the GDPPR dataset.


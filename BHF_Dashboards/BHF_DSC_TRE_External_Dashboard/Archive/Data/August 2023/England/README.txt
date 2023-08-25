My request today included the following 3 tables:
 
Note that the tables do not contain any individual-level data (aggregate-level data only).
 
Data completeness (export_dashboard_NHSD_20230803_data_completeness)

This table contains approximately 3980 rows and 3 columns. This table provides the percentage of non-missing data (column name: “completeness”) for each data field (“column_name”) within each dataset (“dataset”). For disclosure control, the “completeness” column has been rounded to 3 decimal places to ensure that percentages corresponding to counts less than 10 have been suppressed for small datasets.
 
Data summary (export_dashboard_NHSD_20230803_data_overview)

This table contains 50 rows and 6 columns. This table provide overall counts of the number of records (column name: “n”), records with an identifier (“n_id”), and distinct identifiers (“n_id_distinct”) for each dataset (“dataset”), in addition to the “BatchID” and “archived_on” date for record keeping purposes. The following disclosure control has been applied to the three count columns: 
Counts greater than or equal to 1 and less than 10 have been set to 10
Counts greater than or equal to 10 have been rounded to the nearest 5
Counts equal to zero have been retained 
 
Data coverage (export_dashboard_NHSD_20230803_data_coverage)
This table contains approximately 6308 rows, which covers 40 datasets. This table table provides counts of the number of records (column name: “n”), records with an identifier (“n_id”), and distinct identifiers (“n_id_distinct”) for each month (“date_ym”) within each dataset (“dataset”). Disclosure control has been applied as above. 
    
 
Additional context – we have output this data previously and going forward this will likely become a monthly export.
 
Thanks for your help!
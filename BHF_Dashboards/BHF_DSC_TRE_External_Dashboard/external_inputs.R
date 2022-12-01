nations_options = c("England","Scotland","Wales")

count_options = c("Records"="n","Valid IDs"="n_id","Distinct IDs"="n_id_distinct")
count_options_selected = c("n","n_id","n_id_distinct")
count_options_selected_season = "n"

frequency_options = c("Monthly","Weekly")


extreme_dates_text = c(paste0("Expand the Date Range\nto include:\n● all historical records &\n● future dates ≤ ",
                              (as.numeric(format(Sys.Date(), "%Y"))+1)))

type_text = paste("Records with a Valid ID\nhave a non-null NHS\npatient identifier.\nDistinct Valid IDs are\nnon-duplicate.")

log_text = c("Some holding text for log description")

trend_text = c("Overlay smoothed\nconditional means\nwith confidence interval.")



ReadMe
======

How to read the tidy data set into R.
======================================
tidy_data <- read.table("tidy_data.txt", header=TRUE)

Generate tidy_data.txt
======================
source(run_analysis.R) will generate the  file tidy_data.txt

Why this data is tidy
=====================
Refer http://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html
The data follows principles of tidy data -

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.


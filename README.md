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

How all of the scripts work and how they are connected.  
=======================================================
1. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

2. Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

3. The following files from the original data set are used in creating the tidy_data-

test\subject_test.txt
test\y_test.txt
test\X_test.txt
train\subject_train.txt
train\y_train.txt
train\X_train.txt
features.txt
activity_labels.txt

4. The following are the submission files -

a. run_analysis.R - R script used to create tidy data
b. README.md - this file
c. CodeBook.md - a code book that describes the variables, the data, and any transformations or work that performed to clean up the data 
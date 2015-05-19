1. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

2. Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


3. The following files are used in this project. 
subject_test.txt
y_test.txt
X_test.txt
subject_train.txt
y_train.txt
X_train.txt
features.txt
activity_labels.txt

4. The assignment steps are carried out in the order which makes it easiest to create tidy data. 
So Step-1, then Step-4 and then Step-1 again, then Step-2, 3 and finally Step-5

5. Step-1 - Merges the training and the test sets to create one data set.
	1. read X_train.txt using read.table
	2. read X_test.txt using read.table
	3. Create a merged dataset using rbind
	library(dplyr)
	train <- read.table("train\\X_train.txt")
	test <- read.table("test\\X_test.txt")
	data <- rbind(train, test)

6. Step-4 - Appropriately labels the data set with descriptive variable names. 
	1. features <- read.table("features.txt")
	2. names(data) <- features$V2

7. Step-1 (contd).
	1. activity_train = read.table("train\\y_train.txt")
	2. activity_test = read.table("test\\y_test.txt")
	3. activity <- rbind(activity_train, activity_test)
	4. subject_train = read.table("train\\subject_train.txt")
	5. subject_test = read.table("train\\subject_test.txt")
	6. subject <- rbind(subject_train, subject_test)
	7. names(activity)[names(activity) == 'V1'] <- 'activity'
	8. names(subject)[names(subject) == 'V1'] <- 'subject'
	9. df <- cbind(subject, activity, data)

8. Step-3: Uses descriptive activity names to name the activities in the data set
	1. activity_labels <- read.table("activity_labels.txt")
	2. df$activity <- activity_labels[,2][match(df$activity, activity_labels[,1])]

9. Step-2: Extracts only the measurements on the mean and standard deviation for each measurement.
	1. #cols <- as.vector(grep("subject|activity|mean|std|Mean", names(df)))
	2. cols <- as.vector(grep("subject|activity|mean\\(\\)|std\\(\\)", names(df)))
	3. dft <- tbl_df(df[cols])


10. Step-5: From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.
	1. tidy_data <- dft %>% group_by(subject, activity) %>% summarise_each(funs(mean))
	2. write.table(tidy_data, "tidy_data.txt", row.name=FALSE)


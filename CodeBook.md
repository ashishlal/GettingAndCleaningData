The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The following files are used in this project. 
subject_test.txt
y_test.txt
X_test.txt
subject_train.txt
y_train.txt
X_train.txt
features.txt
activity_labels.txt

The assignment steps are carried out in the order which makes it easiest to create tidy data. 
So Step-1, then Step-4 and then Step-1 again, then Step-2, 3 and finally Step-5

Step-1 - Merges the training and the test sets to create one data set.
=====================================================================
	1. read X_train.txt using read.table
	2. read X_test.txt using read.table
	3. Create a merged dataset using rbind
	library(dplyr)
	train <- read.table("train\\X_train.txt")
	test <- read.table("test\\X_test.txt")
	data <- rbind(train, test)
> dim(data)
[1] 10299   561

Step-4 - Appropriately labels the data set with descriptive variable names. 
=====================================================================
	1. features <- read.table("features.txt")
	2. names(data) <- features$V2

Step-1 (contd).
=====================================================================
	1. activity_train = read.table("train\\y_train.txt")
	2. activity_test = read.table("test\\y_test.txt")
	3. activity <- rbind(activity_train, activity_test)
	4. subject_train = read.table("train\\subject_train.txt")
	5. subject_test = read.table("test\\subject_test.txt")
	6. subject <- rbind(subject_train, subject_test)
	7. names(activity)[names(activity) == 'V1'] <- 'activity'
	8. names(subject)[names(subject) == 'V1'] <- 'subject'
	9. df <- cbind(subject, activity, data)
> dim(df)
[1] 10299   563
      
Step-3: Uses descriptive activity names to name the activities in the data set
==============================================================================
	1. activity_labels <- read.table("activity_labels.txt")
	2. df$activity <- activity_labels[,2][match(df$activity, activity_labels[,1])]

Step-2: Extracts only the measurements on the mean and standard deviation for each measurement.
================================================================================================
	1. #cols <- as.vector(grep("subject|activity|mean|std|Mean", names(df)))
	2. cols <- as.vector(grep("subject|activity|mean\\(\\)|std\\(\\)", names(df)))
	3. dft <- tbl_df(df[cols])
> dim(dft)
[1] 10299    68
> names(dft)
 [1] "subject"                     "activity"                    "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
 [6] "tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"            "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
[11] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"         "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"         "tBodyAccJerk-mean()-X"      
[16] "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"        "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
[21] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"           "tBodyGyro-std()-Y"          
[26] "tBodyGyro-std()-Z"           "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
[31] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"       "tBodyAccMag-mean()"          "tBodyAccMag-std()"           "tGravityAccMag-mean()"      
[36] "tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"       "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
[41] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"      "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"           "fBodyAcc-mean()-Z"          
[46] "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
[51] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"        "fBodyGyro-mean()-X"         
[56] "fBodyGyro-mean()-Y"          "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
[61] "fBodyAccMag-mean()"          "fBodyAccMag-std()"           "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"    
[66] "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 
> 

Step-5: From the data set in step 4, creates a second, independent tidy data set
==================================================================================
with the average of each variable for each activity and each subject.
	1. tidy_data <- dft %>% group_by(subject, activity) %>% summarise_each(funs(mean))
	2. write.table(tidy_data, "tidy_data.txt", row.name=FALSE)

> head(tidy_data)
Source: local data frame [6 x 68]
Groups: subject

  subject           activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z tGravityAcc-mean()-X
1       1             LAYING         0.2215982      -0.040513953        -0.1132036      -0.92805647     -0.836827406      -0.82606140           -0.2488818
2       1            SITTING         0.2612376      -0.001308288        -0.1045442      -0.97722901     -0.922618642      -0.93958629            0.8315099
3       1           STANDING         0.2789176      -0.016137590        -0.1106018      -0.99575990     -0.973190056      -0.97977588            0.9429520
4       1            WALKING         0.2773308      -0.017383819        -0.1111481      -0.28374026      0.114461337      -0.26002790            0.9352232
5       1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662       0.03003534     -0.031935943      -0.23043421            0.9318744
6       1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020      -0.35470803     -0.002320265      -0.01947924            0.8933511
Variables not shown: tGravityAcc-mean()-Y (dbl), tGravityAcc-mean()-Z (dbl), tGravityAcc-std()-X (dbl), tGravityAcc-std()-Y (dbl), tGravityAcc-std()-Z (dbl),
  tBodyAccJerk-mean()-X (dbl), tBodyAccJerk-mean()-Y (dbl), tBodyAccJerk-mean()-Z (dbl), tBodyAccJerk-std()-X (dbl), tBodyAccJerk-std()-Y (dbl), tBodyAccJerk-std()-Z
  (dbl), tBodyGyro-mean()-X (dbl), tBodyGyro-mean()-Y (dbl), tBodyGyro-mean()-Z (dbl), tBodyGyro-std()-X (dbl), tBodyGyro-std()-Y (dbl), tBodyGyro-std()-Z (dbl),
  tBodyGyroJerk-mean()-X (dbl), tBodyGyroJerk-mean()-Y (dbl), tBodyGyroJerk-mean()-Z (dbl), tBodyGyroJerk-std()-X (dbl), tBodyGyroJerk-std()-Y (dbl),
  tBodyGyroJerk-std()-Z (dbl), tBodyAccMag-mean() (dbl), tBodyAccMag-std() (dbl), tGravityAccMag-mean() (dbl), tGravityAccMag-std() (dbl), tBodyAccJerkMag-mean() (dbl),
  tBodyAccJerkMag-std() (dbl), tBodyGyroMag-mean() (dbl), tBodyGyroMag-std() (dbl), tBodyGyroJerkMag-mean() (dbl), tBodyGyroJerkMag-std() (dbl), fBodyAcc-mean()-X (dbl),
  fBodyAcc-mean()-Y (dbl), fBodyAcc-mean()-Z (dbl), fBodyAcc-std()-X (dbl), fBodyAcc-std()-Y (dbl), fBodyAcc-std()-Z (dbl), fBodyAccJerk-mean()-X (dbl),
  fBodyAccJerk-mean()-Y (dbl), fBodyAccJerk-mean()-Z (dbl), fBodyAccJerk-std()-X (dbl), fBodyAccJerk-std()-Y (dbl), fBodyAccJerk-std()-Z (dbl), fBodyGyro-mean()-X (dbl),
  fBodyGyro-mean()-Y (dbl), fBodyGyro-mean()-Z (dbl), fBodyGyro-std()-X (dbl), fBodyGyro-std()-Y (dbl), fBodyGyro-std()-Z (dbl), fBodyAccMag-mean() (dbl),
  fBodyAccMag-std() (dbl), fBodyBodyAccJerkMag-mean() (dbl), fBodyBodyAccJerkMag-std() (dbl), fBodyBodyGyroMag-mean() (dbl), fBodyBodyGyroMag-std() (dbl),
  fBodyBodyGyroJerkMag-mean() (dbl), fBodyBodyGyroJerkMag-std() (dbl)
> 
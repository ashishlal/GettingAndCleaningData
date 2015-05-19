# NOTE: The project requires the following 5 steps to be completed.
# But they have not been implemented in the order that was asked
# As per the postings on the discussion forum by the course TA
# this is not a problem
# Assignment: You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


library(dplyr)
#Step-1
#Merges the training and the test sets to create one data set.
train <- read.table("train\\X_train.txt")
test <- read.table("test\\X_test.txt")
data <- rbind(train, test)

#Step-4
#Appropriately labels the data set with descriptive variable names. 
features <- read.table("features.txt")
names(data) <- features$V2

#Step-1 (contd).
#Add activity and subject columns to the data set
activity_train = read.table("train\\y_train.txt")
activity_test = read.table("test\\y_test.txt")
activity <- rbind(activity_train, activity_test)
subject_train = read.table("train\\subject_train.txt")
subject_test = read.table("test\\subject_test.txt")
subject <- rbind(subject_train, subject_test)
names(activity)[names(activity) == 'V1'] <- 'activity'
names(subject)[names(subject) == 'V1'] <- 'subject'
df <- cbind(subject, activity, data)

#Step-3
#Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt")
df$activity <- activity_labels[,2][match(df$activity, activity_labels[,1])]

#Step-2
#Extracts only the measurements on the mean and standard deviation for each measurement.
#cols <- as.vector(grep("subject|activity|mean|std|Mean", names(df)))
cols <- as.vector(grep("subject|activity|mean\\(\\)|std\\(\\)", names(df)))
dft <- tbl_df(df[cols])


#Step-5
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- dft %>% group_by(subject, activity) %>% summarise_each(funs(mean))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
#by_subject_activity <- group_by(dft, subject, activity)
#tidy_data <- summarise_each(by_subject_activity,funs(mean))

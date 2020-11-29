#Getting and Cleaning Data Course Project
#Liz Garcia

#You should create one R script called run_analysis.R that does the following.


#1.Merges the training and the test sets to create one data set.

library(tidyverse)
#Downloading the zip file with the dataset

file01 <- "DSP_Final.zip"

if (!file.exists(file01)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, file01, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(file01) 
}

#Assigning names to the files

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

class(features)
#the files are now dataframes


X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject_tt <- rbind(subject_train, subject_test)
merged_01 <- cbind(subject_tt, Y, X)
str(merged_01)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

mean_sd <- merged_01 %>% 
  select(subject, code, contains("mean"), contains("std"))
mean_sd

#3.Uses descriptive activity names to name the activities in the data set

mean_sd$code <- activities[mean_sd$code, 2]

#4.Appropriately labels the data set with descriptive variable names.

names(mean_sd)[2] = "activity"
names(mean_sd)<-gsub("Acc", "Accelerometer", names(mean_sd))
names(mean_sd)<-gsub("Gyro", "Gyroscope", names(mean_sd))
names(mean_sd)<-gsub("BodyBody", "Body", names(mean_sd))
names(mean_sd)<-gsub("Mag", "Magnitude", names(mean_sd))
names(mean_sd)<-gsub("^t", "Time", names(mean_sd))
names(mean_sd)<-gsub("^f", "Frequency", names(mean_sd))
names(mean_sd)<-gsub("tBody", "TimeBody", names(mean_sd))
names(mean_sd)<-gsub("-mean()", "Mean", names(mean_sd), ignore.case = TRUE)
names(mean_sd)<-gsub("-std()", "STD", names(mean_sd), ignore.case = TRUE)
names(mean_sd)<-gsub("-freq()", "Frequency", names(mean_sd), ignore.case = TRUE)
names(mean_sd)<-gsub("angle", "Angle", names(mean_sd))
names(mean_sd)<-gsub("gravity", "Gravity", names(mean_sd))
View(mean_sd)

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- mean_sd %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidy_data, "TidyData.txt", row.name=FALSE)

getwd()


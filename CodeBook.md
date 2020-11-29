The repository has the run_analysis.R script as requested in the Getting and Cleaning Data Course Project instructions

The script follows the following steps
1. Download, and name the data
Extract the data in the folder UCI HAR Dataset
Assign the files using the function read.table()

features 
activities
subject_test
x_test
y_test
subject_train
x_train
y_train
We now have 8 dataframes


2.Merges the training and the test sets to create one data set
X is created by merging x_train and x_test using the function rbind()
Y  is created by merging y_train and y_test using the function rbind() 
subject_tt is created by merging subject_train and subject_test using the function rbind() 
merged_01 is created by merging subject_tt, Y and X using the function cbind()

3.Extracts only the measurements on the mean and standard deviation for each measurement
mean_sd is created by using the function select() and subsetting merged_01 

4.Uses descriptive activity names to name the activities in the data set
Numbers in the code column of mean_sd where replaced with names taken from second column activities

5.Appropriately labels the data set with descriptive variable names
code column in mean_sd renamed into activities
Acc replaced by Accelerometer
Gyro replaced by Gyroscope
BodyBody replaced by Body
Mag replaced by Magnitude
Characters starting with f in column’s name replaced with Frequency
Characters starting with t in column’s name replaced with Time

6.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data is created by usin the group_by and summarise_all functions with the mean_sd dataframe

7. Creating a txt file
TidyData.txt is created using the function write.table() 

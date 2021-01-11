# This is a solution to Week 4 Programming assignment in Getting and Cleaning Data course
# Data Science Specialization  - John Hopkins University - Coursera
# Completed by Pavel Kliuiev
# See README.md and codebook.md for more info

############################
# Download and read data
############################
#
# import libraries
library(dplyr)
#
# set working directory
setwd("C:/Users/Paul/Documents/coursera/get_clean_data")
#
# download data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "dataset.zip"
if (!file.exists(filename)){
  download.file(url, destfile = filename, mode='wb')
}
#
# unzip the archive
datapath <- "./UCI HAR Dataset"
if (!file.exists(datapath)){
  unzip(filename)
}
#
# read training data
trainsubject <- read.table(file.path(datapath, "train", "subject_train.txt"), header = FALSE)
trainset <- read.table(file.path(datapath, "train", "X_train.txt"), header = FALSE)
trainlabel <- read.table(file.path(datapath, "train", "y_train.txt"), header = FALSE)
#
# read testing data
testsubject <- read.table(file.path(datapath, "test", "subject_test.txt"), header = FALSE)
testset <- read.table(file.path(datapath, "test", "X_test.txt"), header = FALSE)
testlabel <- read.table(file.path(datapath, "test", "y_test.txt"), header = FALSE)
#
# read activity labels and features
activitylabels <- read.table(file.path(datapath, "activity_labels.txt"), header = FALSE)
features <- read.table(file.path(datapath, "features.txt"), header = FALSE)
#
###############################################################
# TASK 1 
# Merge the training and test datasets to create one dataset
###############################################################
#
# combine individual train and test datasets by rows
subjects <- rbind(trainsubject, testsubject)
datasets <- rbind(traindata, testdata)
labels <- rbind(trainlabel, testlabel)
#
# merge all three sets listed above into a single big dataset
#
# extract the datasets' column names from the features' second column
colnames(datasets) <- t(features[2])
#
# combine subjects, datasets and labels by columns
colnames(labels) <- "Activity"
colnames(subjects) <- "Subject"
fulldata <- cbind(datasets, labels, subjects)
# 
###############################################################
# TASK 2 
# Out of all measured features, extract only 
# the number of columns with mean and std for each measurement
###############################################################
#
# get the indicies of columns with mean ans std only (set value = FALSE to get not the values, but the indices)
selectedcols <- grep(".*Mean.*|.*Std.*", names(fulldata), ignore.case = TRUE, value = FALSE)
# append the indicies of the last and the pre-last columns containing mean and std data
# (we merged them by columns in the previous step) 
selectedcols <- c(selectedcols, length(names(fulldata))-1, length(names(fulldata)))
# extract the required  data from the full dataset
selecteddata <- fulldata[, selectedcols]

####################################################################################
# TASK 3
# Use descriptive activity names to name activities in the data set
####################################################################################
#
# turn numeric type into character type
# reference Activity column directly by the column's name set earlier
selecteddata$Activity <- as.character(selecteddata$Activity)

# replace numerical labels with the names
for (ii in 1:length(activitylabels[,2])){
selecteddata$Activity[selecteddata$Activity == ii] <- as.character(activitylabels[ii,2])
}

###############################################################
# TASK 4
# Label the data set with descriptive variable names 
###############################################################
#
print("Names of the variable before editing:\n")
print(names(selecteddata))
#
# printing variable names with names(selecteddata) suggests the following replacements:
# in the following, ^ symbol is used to remove a character at the start of the string
names(selecteddata) <- gsub("Acc", "Accelerometer", names(selecteddata))
names(selecteddata) <- gsub("angle", "Angle", names(selecteddata))
names(selecteddata) <- gsub("BodyBody", "Body", names(selecteddata))
names(selecteddata) <- gsub("^f", "Frequency", names(selecteddata))
names(selecteddata) <- gsub("-freq()", "Frequency", names(selecteddata))
names(selecteddata) <- gsub("gravity", "Gravity", names(selecteddata))
names(selecteddata) <- gsub("Gyro", "Gyroscope", names(selecteddata))
names(selecteddata) <- gsub("Mag", "Magnitude", names(selecteddata))
names(selecteddata) <- gsub("-mean", "Mean", names(selecteddata))
names(selecteddata) <- gsub("-std()", "Std", names(selecteddata))
names(selecteddata) <- gsub("^t", "Time", names(selecteddata))
#
print("Names of the variable after editing:")
print(names(selecteddata))
#
##############################################################################
# TASK 5 - From the data in step 4 create a second independent tidy data set
# with the average of each variable for each activity and each subject
##############################################################################
#
# use aggregate function to compute mean of the elements  grouped by subject and activity
selecteddatamean <- aggregate(. ~ Subject + Activity, selecteddata, function(x) mean=mean(x))
write.table(selecteddatamean, file = "tidy_data.txt", row.names = FALSE, col.names = TRUE)
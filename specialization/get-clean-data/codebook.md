# Codebook for run_analysys.R

The code starts with downloading and reading data

## TASK 1 - Merge the training and test datasets to create one dataset

* combine individual train and test datasets by rows
* merge all three sets listed above into a single big dataset
* extract the datasets' column names from the features' second column
* combine subjects, datasets and labels by columns
 

## TASK 2 - Out of all measured features, extract only the number of columns with mean and std for each measurement

* get the indicies of columns with mean ans std only (set value = FALSE to get not the values, but the indices)
* append the indicies of the last and the pre-last columns containing mean and std data (we merged them by columns in the previous step) 
* extract the required  data from the full dataset

## TASK 3 -  Use descriptive activity names to name activities in the data set

* turn numeric type into character type
* reference Activity column directly by the column's name set earlier
* replace numerical labels with the names

## TASK 4 - Label the data set with descriptive variable names 

* printing variable names with names(selecteddata) suggests the following replacements: 
* ^ symbol is used to remove a character at the start of the string

## TASK 5 - From the data in step 4 create a second independent tidy data set with the average of each variable for each activity and each subject

* use aggregate function to compute mean of the elements  grouped by subject and activity
* save data as a table

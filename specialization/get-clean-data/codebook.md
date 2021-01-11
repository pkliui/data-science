# Codebook for run_analysis.R

# Code description

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
* save data as a table to 'tidy_data.txt' file

# The dataset includes the following files

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


# Code Book for Getting and Cleaning Data Course Project

This code book that describes the variables, the data, and any transformations or work that you performed to clean up the data. The original data can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and its description can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


* Step 1: Merges the training and the test sets to create one data set.  
- X train with X test: 10299 x 561 data frame
- Y train with Y test: 10299 x 1 data frame (only the activies)
- S train with S test: 10299 x 1 data frame (subject IDs)



There is a total of 30 subjects, from 1 to 30.

* Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.  
The data frame extracted contains only 66 columns, the only columns measured as mean or standard deviation.

* Step 3: Uses descriptive activity names to name the activities in the data set.

Activies can be:
* Walking
* Walking Upstairs
* Walking Downstairs
* Sitting
* Standing
* Laying

We read them from activity_labels.txt file and replace their ID in the data frame by their respective names.

* Step 4: Appropriately labels the data set with descriptive activity names.  

Merge the intermediate data frames described in the *Step 1* setting the columns as "subject", "activity", the mean and std columns from X.

* Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The result is a 180x68 data frame, where:
* The first column is the subject id (30)
* The second column is the activity he was performing (6)
* The others 66 columns are the mean of the means and standard deviations measured in the original files.
* Thus, we have 30 * 6 = 180 rows
The run_analysis.R script (as included in this repository) fulfils the requirements of the course project of Coursera Getting and Cleaning Data module. In particular, the script works on the data collected from the accelerometers from the Samsung Galaxy S smartphone and carries out the following:

1)Merges the training and the test sets to create one data set.
2)Extracts only the measurements on the mean and standard deviation for each measurement.
3)Uses descriptive activity names to name the activities in the data set
4)Appropriately labels the data set with descriptive variable names.
5)From the data set in step 4, creates a second, independent tidy data set with the average 
of each variable for each activity and each subject.

Arguments to the script: None

Input files - the script expects the below input files in the current working directory:
- 'X_train.txt': Training set with 561 variables, fixed width
- 'X_test.txt': Test set with 561 variables, fixed width
- 'y_train.txt': Training labels, single column.
- 'y_test.txt': Test labels, single column.
- 'features.txt': Lists all features, space delimited
- 'activity_labels.txt': Links the class labels with their activity name, space delimited
- 'subject_train.txt': Identifies the subjects in the train data set (X_train.txt), single column
- 'subject_test.txt': Identifies the subjects in the test data set (X_test.txt), single column

Output: A tiday data set (text file) called 'X_tidy.txt' created in the current directory.

Please also refer to the Code Book for a complete description of the variables in the 'X_tidy.txt' file

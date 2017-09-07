##Coursera Getting and Cleaning Data project - run_analysis.R
##The script does the following:
## 1)Merges the training and the test sets to create one data set.
## 2)Extracts only the measurements on the mean and standard deviation for each measurement.
## 3)Uses descriptive activity names to name the activities in the data set
## 4)Appropriately labels the data set with descriptive variable names.
## 5)From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
##
## Arguments: None
## Return: None 
##
##Author     Venkatesh Vedam
##
##Version    1.0

#Set the working directory
setwd("D:/DS/Coursera/GettingCleaningData/data")

#Create the vector for the file width, since the input files are fixed format.
file_widths = c(-2,14)
for (i in 1:560)
{
  file_widths <- append(file_widths,-1)
  file_widths <- append(file_widths,15)
}

#Use read.fwf to read the fixed width input files X_train and X_test into the respective data frames
X_train <- read.fwf(
 file="X_train.txt",
 widths = file_widths,
 buffersize = 100
 )

X_test <- read.fwf(
  file="X_test.txt",
  widths = file_widths,
  buffersize = 50
)

#Merge the train and test data frames with the help of the rbind function
X_All <- rbind(X_train,X_test)

# library(gdata)
# write.fwf(human,file = "human.txt")

# Read the features (column headings for the main data)  
features <- read.csv(file = "features.txt",sep = " ",stringsAsFactors = FALSE,header = FALSE)
#exclude the numbering column, retaining only the headings.
features <- features[,2]
#define a loop function to clean up the headings by using gsub and removing the part starting with a comma
cleaned <- function(x){gsub(",.*","", x)}
#Use sapply to apply the loop function defined above to the features list
features <- sapply(features,cleaned)
#Assign the clean column headings to the main data frame
names(X_All) <- features

#Read the activity code and the activity
act_label <- read.csv(file = "activity_labels.txt",sep=" ",stringsAsFactors = FALSE,header = FALSE)
colnames(act_label) <- c("activity_code","activity")

#Read the subject train and test data for each row (of main data) from the separate files provided
sub_test <- read.csv(file = "subject_test.txt",stringsAsFactors = FALSE,header = FALSE)
sub_train <- read.csv(file = "subject_train.txt",stringsAsFactors = FALSE,header = FALSE)

#Merge sub_train and sub_test using rbind and also assign the column heading
sub_consol <- rbind(sub_train,sub_test)
colnames(sub_consol) <- c("subject_code")

#Read the train and test activity codes for each row(of main data) from the separate files provided
y_test <- read.csv(file = "y_test.txt",stringsAsFactors = FALSE,header = FALSE)
y_train <- read.csv(file = "y_train.txt",stringsAsFactors = FALSE,header = FALSE)

#merge y_test and y_train into a single data frame and also assign the column heading
yconsol <- rbind(y_train,y_test)
colnames(yconsol) <- c("activity_code")

#Use grep to extract only the measurements on std deviation and mean in the main data frame
#and consolidate using cbind
std_cols <- (X_All[ , grep("std", colnames(X_All))])
mean_cols <- (X_All[ , grep("mean", colnames(X_All))])
X_All <- cbind(std_cols,mean_cols)

#Add the subject and activity columns to the main data frame
X_All <- cbind(yconsol,sub_consol,X_All)

#Use the merge function to pull the activity on the basis of activity code and add to the main data frame
X_All=merge(X_All,act_label,by.x = "activity_code",by.y = "activity_code",all=TRUE) 

#Use plyr library to create the tidy data set with 
#main data frame measurements averaged by subject and activity
library(plyr)
#create the grouping vector with activity and subject
groupcol = c("activity","subject_code")
#Bunch together the data columns (which will be averaged by groupcol)
datacol = c(3,4)
for (i in 5:81)
{
  datacol <- append(datacol,i)
}
#Invoke ddply function to create the tidy data set
X_tidy <- ddply(X_All, groupcol, function(x) colMeans(x[datacol]))

#Use write.table to write the tidy dataset into a file
write.table(X_tidy,file = "X_tidy.txt",row.name=FALSE,sep = " " )
















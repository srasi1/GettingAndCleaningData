# GettingAndCleaningData
Courseera's Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
##  Explanation of Code (run_analysis.R)
  

###### download the raw data

```
library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./FUCIDataset.zip", method = "curl")
zipF<- "./FUCIDataset.zip"
outDir<-"./"
unzip(zipF,exdir=outDir)
```

Files used for data

1. test/y_test.txt   		label	    (2947 rows)
2. test/subject_test.txt  	sub	    (2947 rows)
3. test/X_test.txt		set	    (2947 rows)
4. train/y_train.txt		label	    (7352 rows)
5. train/subject_train.txt	sub	    (7352 rows)
6. train/X_train.txt		set	    (7352 rows)

Read all the 6 files into tables (read.table)

```
test_lab <- read.table("./UCI HAR Dataset/test/y_test.txt")
train_lab <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
```


######Step 1				
Merge training and test sets               
bind test and train tables separately (rbind)

```
dt_sub <- rbind(train_sub, test_sub)
dt_lab <- rbind(train_lab, test_lab)
dt_set <- rbind(train_set, test_set)
```
update column names for subject (person) and label (activity) tables
bind sub, lab and set (data) tables 
to make 1 dataframe (cbind)

```
colnames(dt_sub) <- c("subject")
colnames(dt_lab) <- c("label")

dt <- cbind(dt_sub, dt_lab)
dt <- cbind(dt, dt_set)
```

 dt is the data frame that has the data of step1
 At this step
 dim(dt)
 [1] 10299   563


######Step 2				
 Extract only measurements on the mean 	
 and standard deviation for each measurement	                
				
Read features and make unique (make.names & gsub)
We are making the column names unique since there are some columns repeated for 3 times

```
feats <- read.table("./UCI HAR Dataset/features.txt")
feats$V2 <- make.names(feats$V2, unique = TRUE, allow_ = FALSE)
feats$V2 <- gsub(".", "" , feats$V2, fixed = T)
```

1. All column names of dataset dt(merged dataset) - dt_colname
2. Find column names with std and mean - sm_col_ind
3. dataset with only std and mean measurements - dt_std_mean

```
dt_colname <- c(c("subject", "label"), feats$V2)
sm_col_ind <- grep("mean|std|Mean", dt_colname)
dt_std_mean <- dt[,c(1, 2, sm_col_ind)]
```

dt_std_mean is the data frame that has the data of step2
i.e. with all columns of mean, std for each subject & label(activity)

* 46 columns with mean
* 7 columns with Mean
* 33 columns with std

86 columns of measurement data, one column 
for subject and one column for activity

storing all std and mean col names 
in sm_cols variable for future use
dim(dt_std_mean)
[1] 10299 88

```
sm_cols <- grep("mean|std|Mean", feats$V2)
sm_cols <- feats$V2[sm_cols]
```
						
######Step 3			
Uses descriptive activity names to name the activities 	in the data set	                
merge the ACTIVITY values using label column

```
dt_act <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(dt_act) <- c("actNum", "actName")
```

creating a new column id to preserve the current order of the data
Merging the data using activity data frame and then order the data set
  to make it in the order of original data set
```
dt_std_mean$id <- 1:nrow(dt_std_mean)
mergeData <- merge(dt_std_mean, dt_act, by.x = "label", by.y = "actNum", sort = FALSE)
mergeData <- mergeData[order(mergeData$id), ]
```

mergeData is the dataframe that has the data after step3
activity column has values of it's descriptions now

					
######Step 4				
Appropriately label the data set with descriptive variable names
We are going to pull the column names from the feature list to 
name the columns of the data set

```
sm_col_name <- dt_colname[sm_col_ind]
sm_col_name <- c("label", "subject", sm_col_name, "id", "actname")
colnames(mergeData) <- sm_col_name
drops <- c("label","id")
mergeData <- mergeData[ , !(names(mergeData) %in% drops)]
```
				
######Step 5				
From the data set in step 4, 		
create a second, independent tidy data	
set with the average of each variable	
for each activity and each subject		

```
fMergeData <- aggregate(x = mergeData[sm_cols], by = mergeData[c("subject", "actname")], FUN = mean)
write.csv(fMergeData, file = "./fMergeData.csv",row.names=FALSE)
```

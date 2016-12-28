#################################################
#		Step 0				#
#     Create data directory			#
#     download the file				#	
#     unzip the file into data directory	#
#						#
#################################################

setwd("/home/sasi/R_Practice/3-GettingCleaningData/data/Project")
library(dplyr)


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./FUCIDataset.zip", method = "curl")
zipF<- "./FUCIDataset.zip"
outDir<-"./"
unzip(zipF,exdir=outDir)

#######################################################
#          Files used for data
#          ===================   
#   test/y_test.txt   		label	(2947 rows)
#   test/subject_test.txt  	sub	(2947 rows)
#   test/X_test.txt		set	(2947 rows)
#   train/y_train.txt		label	(7352 rows)
#   train/subject_train.txt	sub	(7352 rows)
#   train/X_train.txt		set	(7352 rows)
#
#   Read all the 6 files into tables (read.table)
#######################################################
test_lab <- read.table("./UCI HAR Dataset/test/y_test.txt")
train_lab <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")


#################################################
#						#
#		Step 1				#
#    Merge training and test sets               #
#						#
#################################################

#
# bind test and train tables separately (rbind)
#
dt_sub <- rbind(train_sub, test_sub)
dt_lab <- rbind(train_lab, test_lab)
dt_set <- rbind(train_set, test_set)

#
# update colnames for sub and lab tables
#
# bind sub, lab and set tables 
# to make 1 dataframe (cbind)
#

colnames(dt_sub) <- c("subject")
colnames(dt_lab) <- c("label")

dt <- cbind(dt_sub, dt_lab)
dt <- cbind(dt, dt_set)

#
# dt is the data frame that has the data of step1
# dim(dt)
# [1] 10299   563
#


#################################################
#						#
#		Step 2				#
#    Extract only measurements on the mean 	#
#      and standard deviation for each 		#
#	     measurement	                #
#						#
#################################################


#
# read features and make unique (make.names & gsub)
#

feats <- read.table("./UCI HAR Dataset/features.txt")
feats$V2 <- make.names(feats$V2, unique = TRUE, allow_ = FALSE)
feats$V2 <- gsub(".", "" , feats$V2, fixed = T)

#
# 1. All column names of dataset dt(merged dataset) 
# 2. Find column names with std and mean - sm_col_ind
# 3. dataset with only std and mean measurements - dt_std_mean
# 4. std and mean features - sm_col_name
# 5. column names of dataset (only with std and mean measurements)
#    is reset with right column names from features list
#

dt_colname <- c(c("subject", "label"), feats$V2)
sm_col_ind <- grep("mean|std|Mean", dt_colname)
dt_std_mean <- dt[,c(1, 2, sm_col_ind)]

#
#  dt_std_mean is the data frame that has the data of step2
#  i.e. with all columns of mean, std and subject & label(activity)
#

#
# storing all std and mean col names 
# in sm_cols variable for future use
#

sm_cols <- grep("mean|std|Mean", feats$V2)
sm_cols <- feats$V2[sm_cols]

#################################################
#						#
#		Step 3				#
#    Uses descriptive activity 			#
#      names to name the activities 		#
#	     in the data set	                #
#						#
#################################################


#
# merge the ACTIVITY values using label column
#

dt_act <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(dt_act) <- c("actNum", "actName")

#
# creating a new column id to preserve
# the current order of the data
#

dt_std_mean$id <- 1:nrow(dt_std_mean)
mergeData <- merge(dt_std_mean, dt_act, by.x = "label", by.y = "actNum", sort = FALSE)
mergeData <- mergeData[order(mergeData$id), ]

#
# mergeData is the dataframe that has the data after step3
# activity column has values of it's descriptions now
#

#################################################
#						#
#		Step 4				#
#    Appropriately labels the data		#
#    set with descriptive variable 		#
#	names		                	#
#						#
#################################################

sm_col_name <- dt_colname[sm_col_ind]
sm_col_name <- c("label", "subject", sm_col_name, "id", "actname")
colnames(mergeData) <- sm_col_name
drops <- c("label","id")
mergeData <- mergeData[ , !(names(mergeData) %in% drops)]


#################################################
#						#
#		Step 5				#
#    From the data set in step 4, 		#
#    create a second, independent tidy data	#
#    set with the average of each variable	#
#    for each activity and each subject		#
#						#
#################################################

fMergeData <- aggregate(x = mergeData[sm_cols], by = mergeData[c("subject", "actname")], FUN = mean)
write.csv(fMergeData, file = "./fMergeData.csv",row.names=FALSE)


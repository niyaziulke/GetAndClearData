

dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataZip <- "data.zip"

#download and unzip the data if it is needed.
if(!file.exists(dataZip)){
  download.file(url=dataUrl,destfile = dataZip)
  unzip(dataZip)
}


#read activity labels and feature names.
activityLabels <- (read.table("UCI HAR Dataset/activity_labels.txt",as.is = TRUE))[,2]
features <- (read.table("UCI HAR DATASET/features.txt",as.is = TRUE))[,2]


# read test and train data, merge them.
xMerged <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"),read.table("UCI HAR Dataset/test/X_test.txt"))
yMerged <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"),read.table("UCI HAR Dataset/test/y_test.txt"))
subjects <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"),read.table("UCI HAR Dataset/test/subject_test.txt"))



#extract only the measurements on the mean and standard deviation.
selectFeatures <- grep("-(mean|std)\\(\\)", features)
features <- features[selectFeatures]
xMerged <- xMerged[,selectFeatures]



# convert activity IDs to corresponding activity names.
activities <- sapply(yMerged, function(x) x<- activityLabels[x])


#improve feature names.
features <- gsub("(\\(\\)|-)","",features)
features <- gsub("mean","Mean",features)
features <- gsub("std","StandardDeviation",features)


#clear a tidy data set by calculating averages of each variable for each activity and each subject.
complete <- cbind(activities,subjects,xMerged)
colnames(complete) <- c("Activity","Subject", features)
tidyTable <- aggregate(. ~ Activity + Subject ,data =complete, FUN=mean)
tidyTable<- tidyTable[order(match(tidyTable$Activity,activityLabels)),]
tidyTable <- tidyTable[order(tidyTable$Subject),]
firstCol <- tidyTable[,1]
tidyTable[,1] <- tidyTable [,2]
tidyTable[,2] <- firstCol
colnames(tidyTable) <- c("Subject", "Activity" , features)
#print the table.
write.table(tidyTable, "tidy_dataset.txt", row.names = FALSE,col.names = TRUE ,quote = FALSE)


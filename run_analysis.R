

dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataZip <- "data.zip"

# if the zip file does not exist, download and unzip it.
if(!file.exists(dataZip)){
  download.file(url=dataUrl,destfile = dataZip)
  unzip(dataZip)
}

# main directory which contains the data.
dataPath <-  "UCI HAR Dataset"


# read test and train data, merge them.
xMerged <- rbind(read.table(paste0 (dataPath,"/train/X_train.txt")),read.table(paste0 (dataPath,"/test/X_test.txt")))
yMerged <- rbind(read.table(paste0 (dataPath,"/train/y_train.txt")),read.table(paste0 (dataPath,"/test/y_test.txt")))
subjects <- rbind(read.table(paste0 (dataPath,"/train/subject_train.txt")),read.table(paste0 (dataPath,"/test/subject_test.txt")))

#read activity label and feature names.
activityLabels <- (read.table(paste0(dataPath,"/activity_labels.txt"),as.is = TRUE))[,2]
features <- read.table(paste0(dataPath,"/features.txt"),as.is = TRUE)[,2]

#extract only the measurements on the mean and standard deviation.
selectFeatures <- grep("-(mean|std)\\(\\)", as.character(features))
features <- features[selectFeatures]
xMerged <- xMerged[,selectFeatures]

#improve variable names.
features <- gsub("(\\(\\)|-)","",features)
features <- gsub("mean","Mean",features)
features <- gsub("std","Std",features)


# store descriptive activity names.
activities <- sapply(yMerged, function(x) x<- activityLabels[x])

#clear a tidy data set by calculating averages of each variable for each activity and each subject.
complete <- cbind(subjects,activities,xMerged)
colnames(complete) <- c("Subject","Activity", features)
complete <- aggregate(. ~ Subject + Activity ,data =complete, FUN=mean)
tidyTable<- complete[order(match(complete$Activity,activityLabels)),]
tidyTable <- tidyTable[order(tidyTable$Subject),]

#print the table.
write.table(tidyTable, "tidy_dataset.txt", row.names = FALSE,col.names = TRUE ,quote = FALSE)


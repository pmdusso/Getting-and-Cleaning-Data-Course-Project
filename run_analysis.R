# You should create one R script called run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
X <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"))
S <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt"))
Y <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt"))

# Extracts only the measurements on the mean and standard deviation for each measurement.
# Read the features file 
features <- read.table("UCI HAR Dataset/features.txt")
# Select only the indexes which contain the words "mean" or "std"
meanAndStDevFeaturesIndex <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
# Assign to the X vector a subset of its own, but this time with only the relevant features
X <- X[,meanAndStDevFeaturesIndex]
# Get the name of the features, filtering by their index (meanAndStDevFeaturesIndex) and second column of the features file (where the names are)
names(X) <- features[meanAndStDevFeaturesIndex, 2]
# Remove the parenteses from the names
names(X) <- gsub("\\(|\\)", "", names(X))

# Uses descriptive activity names to name the activities in the data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# Appropriately labels the data set with descriptive variable names. 
names(S) <- "subject"
cleanData <- cbind(S, Y, X)
write.table(cleanData, "cleanData.txt", row.name=FALSE)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
cleanData <- cleanData[order(cleanData$activity, decreasing = FALSE),]
cleanData <- cleanData[order(cleanData$subject, decreasing = FALSE),]

uniqueSubjects = unique(cleanData[,1])
numSubjects <- length(unique(cleanData[,1]))
numActivities = length(unique(cleanData[,2]))
numCols = dim(cleanData)[2]
result = cleanData[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
    for (a in 1:numActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = activities[a, 2]
        tmp <- cleanData[cleanData$subject==s & cleanData$activity==activities[a, 2], ]
        result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row+1
    }
}
write.table(result, "cleanDataWithAverages.txt", row.name=FALSE)
##Check the existance of the data file, if not, download and unzip it.
if (!file.exists("~/Desktop/getclean2")) {
  dir.create("~/Desktop/getclean2")
}
setwd("~/Desktop/getclean2")

if (!file.exists("data.zip")) {
  fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, destfile = "./data.zip", method = "curl")
  dataset <- unzip("data.zip")
}

##Read the files separately, including the data, and the labels
file <- list.files("UCI HAR Dataset", recursive = T)
subject_test <- read.table(file.path("UCI HAR Dataset", file[14]), header = F)
X_test <- read.table(file.path("UCI HAR Dataset", file[15]), header = F)
Y_test <- read.table(file.path("UCI HAR Dataset", file[16]), header = F)

subject_train <- read.table(file.path("UCI HAR Dataset", file[26]), header = F)
X_train <- read.table(file.path("UCI HAR Dataset", file[27]), header = F)
Y_train <- read.table(file.path("UCI HAR Dataset", file[28]), header = F)

labels <- read.table(file.path("UCI HAR Dataset", file[1]), header =F)
features <- read.table(file.path("UCI HAR Dataset", file[3]), header =F)

##Find the mean and the standard deviation for each measurement and extract them
set.mean <- grep("-mean()", features[, 2], fixed = T)
set.std <- grep("-std()", features[, 2], fixed = T)
set <- sort(unique(c(set.mean, set.std)))
set.names <- as.character(features[set, 2])
X_test <- X_test[, set]
X_train <- X_train[, set]
names(X_test) <- set.names
names(X_train) <- set.names

names(subject_test) <- "subject"
names(Y_test) <- "activity"
names(subject_train) <- "subject"
names(Y_train) <- "activity"

##Merge the test data and train data into one big dataset
data.test <- cbind(subject_test, Y_test, X_test)
data.train <- cbind(subject_train, Y_train, X_train)
data <- rbind(data.test, data.train)


##Name the activity according to the feature list
for (i in 1:6) {
  data$activity <- gsub(labels[i,1], labels[i,2], data$activity)
}

##Create a second, independent dataset with averaging each variable for each activity and each subject
tidy.data <- aggregate(data[,3:ncol(data)], by = list(data$subject, data$activity), mean)
names(tidy.data)[1:2] <- c("subject", "activity")
write.csv(tidy.data, "tidydata.csv")

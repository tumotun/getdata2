#Code Book
***

##Set working directory
The function will look up if "getclean2" exists on desktop or not. If it does, set it as working directory, or create one.	

	Then the function will check if the data package exists or not. If not, download one from the internet and unzip it.  
 
```
if (!file.exists("~/Desktop/getclean2")) {
  dir.create("~/Desktop/getclean2")
}
setwd("~/Desktop/getclean2")

if (!file.exists("data.zip")) {
  fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, destfile = "./data.zip", method = "curl")
  dataset <- unzip("data.zip")
}
```

##Read file	
The function will read the data, including test, train, labels, features file.

```
file <- list.files("UCI HAR Dataset", recursive = T)
subject_test <- read.table(file.path("UCI HAR Dataset", file[14]), header = F)
X_test <- read.table(file.path("UCI HAR Dataset", file[15]), header = F)
Y_test <- read.table(file.path("UCI HAR Dataset", file[16]), header = F)

subject_train <- read.table(file.path("UCI HAR Dataset", file[26]), header = F)
X_train <- read.table(file.path("UCI HAR Dataset", file[27]), header = F)
Y_train <- read.table(file.path("UCI HAR Dataset", file[28]), header = F)

labels <- read.table(file.path("UCI HAR Dataset", file[1]), header =F)
features <- read.table(file.path("UCI HAR Dataset", file[3]), header =F)
```

##Find target information
The function will locate all the columns of the mean and the standard deviation, and then extract them from the data. 

```
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
```

##Merge the data
The function will merge the test and the train file together with the subject number and the type of activity. 

```
data.test <- cbind(subject_test, Y_test, X_test)
data.train <- cbind(subject_train, Y_train, X_train)
data <- rbind(data.test, data.train)
```

##Name the activity
The function uses a loop to name all the activity according to the feature list in the big data. 

```
for (i in 1:6) {
  data$activity <- gsub(labels[i,1], labels[i,2], data$activity)
} 
```

##Create a second, independent dataset
Use `aggregate()` function to calculate the mean by subject and types of activity. 	
Rename the subject and activity columns.	
Output a text file as a second independent data.

```
tidy.data <- aggregate(data[,3:ncol(data)], by = list(data$subject, data$activity), mean)
names(tidy.data)[1:2] <- c("subject", "activity")
write.csv(tidy.data, "tidydata.csv")
```
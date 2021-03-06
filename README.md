#This repo is for the second peer assessments.
***
# Introduction
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones] [1] 

Here are the data for the project: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] [2] 

You should create one R script called run_analysis.R that does the following.   
	1. Merges the training and the test sets to create one data set.  
	2. Extracts only the measurements on the mean and standard deviation for each measurement.   
	3. Uses descriptive activity names to name the activities in the data set.  
	4. Appropriately labels the data set with descriptive variable names.  
	5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

[1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
[2]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

***
# How it works:
1. Set a file name "getclean2" on destop as the working directory. If not, the script will create one for instead.
2. Check if the required data exists in the file. If not, it will download and unzip to the working directory.
3. Read the data, and the labels file separately.
4. Find the mean and the sd value for each measurement and extract them.
5. Merge the test and train data into one big dataset.
6. Create a second, independent dataset with averaging each variable for each activity and each subject, and output as a text file.
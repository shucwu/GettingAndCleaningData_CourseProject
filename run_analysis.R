# Getting and Cleaning Data
# Course Project

# load libraries
library(dplyr)
library(plyr)
library(reshape2)

# read raw data files into data frames

x_train_raw <- read.table("./UCI Har Dataset/train/x_train.txt")
y_train_raw <- read.table("./UCI Har Dataset/train/y_train.txt")
subject_train_raw <- read.table("./UCI Har Dataset/train/subject_train.txt")

x_test_raw <- read.table("./UCI Har Dataset/test/x_test.txt")
y_test_raw <- read.table("./UCI Har Dataset/test/y_test.txt")
subject_test_raw <- read.table("./UCI Har Dataset/test/subject_test.txt")

features <- read.table("./UCI Har Dataset/features.txt")

# label the varibles in datasets x, y, and subject of both training and test sets

names(x_train_raw) <- as.character(features[,2])
names(y_train_raw) <- c("activity")
names(subject_train_raw) <- c("subject")


names(x_test_raw) <- as.character(features[,2])
names(y_test_raw) <- c("activity")
names(subject_test_raw) <- c("subject")

# combine datasets of x, y, and subject for training and test sets, respectively

train_data <- cbind(subject_train_raw, y_train_raw, x_train_raw)
test_data <- cbind(subject_test_raw, y_test_raw, x_test_raw)

# merge the training and test sets

all_data <- rbind(train_data,test_data)

# extract only the measurements on the mean and standard deviation for each measurement

all_data_mean <- all_data[, grep("mean\\(\\)",names(all_data), value = TRUE)]
all_data_std <- all_data[, grep("std\\(\\)",names(all_data), value = TRUE)]

subset_data <- cbind(all_data$subject, all_data$activity, all_data_mean, all_data_std)

# fix subject and activity var names (okay I am finicky)
names(subset_data)[1] <- c("subject")
names(subset_data)[2] <- c("activity")

# use descriptive activity names to name the activities

    # read the activity labels file to get the labels
activity_labels <- read.table("./UCI Har Dataset/activity_labels.txt")

    # replace activity codes with descriptive activity names
subset_data$activity <- factor(subset_data$activity, levels = c(1:6),labels = activity_labels$V2)

# label the dataset with descriptive variable names

    # Remove symbols from names
    # find and replaced t and f with time and fft 
    # expanded acc as acceleration
    # expand mag as magnitude
    # put everything in camelCase 

names(subset_data) <- sapply(names(subset_data), function(x) gsub("*-","", x))
names(subset_data) <- sapply(names(subset_data), function(x) gsub("\\(\\)","", x))


names(subset_data) <- sapply(names(subset_data), function(x) gsub("tBody","timeBody", x))
names(subset_data) <- sapply(names(subset_data), function(x) gsub("fBody","fftBody", x))
names(subset_data) <- sapply(names(subset_data), function(x) gsub("BodyAcc","BodyAcceleration", x))

names(subset_data) <- sapply(names(subset_data), function(x) gsub("tGravity","timeGravity", x))
names(subset_data) <- sapply(names(subset_data), function(x) gsub("GravityAcc","GravityAcceleration", x))
names(subset_data) <- sapply(names(subset_data), function(x) gsub("Mag","Magnitude", x))

names(subset_data) <- sapply(names(subset_data), function(x) gsub("mean","Mean", x))
names(subset_data) <- sapply(names(subset_data), function(x) gsub("std","Std", x))

# create a second dataset with the average of each variable for each activity and subject

subset_data_melted <- melt(subset_data, id = c("subject","activity"))

subset_data_casted <- ddply(subset_data_melted, .(subject, activity, variable), summarize, mean = mean(value))

# output final dataset
write.table(subset_data_casted, file = "tidyoutput.txt", row.names = FALSE)


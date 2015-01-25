# CodeBook.md

This is the CodeBook for the Course Project of the Getting and Cleaning Data course. It describes the source data, the varaibles in the output tidy dataset (tidydataset.txt in repo), and  transformations performed to the source data in order to produce the tidy dataset (run_analysis.R in repo). 

## Purpose of Project

The purpose of the project is to create a tidy data set based on the data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Required Resources 

* Unzipped data folder "UCI HAR Dataset" present in the working directory of RStudio
* R package libraries: dplyr, plyr, reshape2

## Source Data

Three sets of data files are required for the analysis: training set, test set, and descriptive label set.

### Training set:

* subject\_train.txt (7352 observations, 1 variable): contains subject id associated with observations in X\_train.txt
* X_train.txt (7352 observations, 561 variables): contains the bulk of the training set data
* y\_train.txt (7352 observations, 1 variable): contains activity associated observations in X\_train.txt file

### Test set: 

* subject\_test.txt (2947 observations, 1 variable): contains subject id associated with observations in X\_test.txt
* X\_test.txt (2947 observations, 561 variables): contains the bulk of the test set data
* y\_test.txt (2947 observations, 1 variable): contains activity associated observations in X\_test.txt file

### Descriptive label set:

* features.txt (561 observations, 2 variables): contains the names of the 561 variables for X\_train.txt and X\_test.txt
* activity_labels.txt (6 observations, 2 variables): contains the names of the activities

## Output Tidy Dataset

The output tidy dataset (tidydataset.txt in repo) has 4 variables: 
* subject: subject id number
* activity: 6 types of activities in descriptive names (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)
* variable: mean and std related measures from the source data, in descriptive names written in CamelCase
* mean: the average of each variable for each activity and each subject

The output dataset is tidy because:
* Each variable (subject, activity, variable, mean) is in its own column
* Each observation is in a different row
* In addition, levels within a variable have descriptive labels written in easily readable CamelCase

## Transformation Performed

 Don't just make a tidy data set, make it clear to people reviewing it why it is tidy. When you given the variables descriptive names, explain why the names are descriptive. Don't give your reviewers the opportunity to be confused about your work, spell it out to them.



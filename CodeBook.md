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

* subject: subject identification number

* activity: 6 types of activities in descriptive names (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)

* variable: mean and std related measures from the source data, in descriptive names written in CamelCase. The following is the list of all possible variable levels/measures. The prefix "time" designates time domain signals. The prefix "fft" designates frequency domain signals derived from Fast Fourier Transform (FFT). The rest are coded in descritive languages and hopefully self explanatory. :-) 

  * "timeBodyAccelerationMeanX"
  * "timeBodyAccelerationMeanY"
  * "timeBodyAccelerationMeanZ"
  * "timeGravityAccelerationMeanX"
  * "timeGravityAccelerationMeanY"
  * "timeGravityAccelerationMeanZ"
  * "timeBodyAccelerationJerkMeanX"
  * "timeBodyAccelerationJerkMeanY"
  * "timeBodyAccelerationJerkMeanZ"
  * "timeBodyGyroMeanX"
  * "timeBodyGyroMeanY"
  * "timeBodyGyroMeanZ"
  * "timeBodyGyroJerkMeanX"
  * "timeBodyGyroJerkMeanY"
  * "timeBodyGyroJerkMeanZ"
  * "timeBodyAccelerationMagnitudeMean"
  * "timeGravityAccelerationMagnitudeMean"
  * "timeBodyAccelerationJerkMagnitudeMean"
  * "timeBodyGyroMagnitudeMean"
  * "timeBodyGyroJerkMagnitudeMean"
  * "fftBodyAccelerationMeanX"
  * "fftBodyAccelerationMeanY"
  * "fftBodyAccelerationMeanZ"
  * "fftBodyAccelerationJerkMeanX"
  * "fftBodyAccelerationJerkMeanY"
  * "fftBodyAccelerationJerkMeanZ"
  * "fftBodyGyroMeanX"
  * "fftBodyGyroMeanY"
  * "fftBodyGyroMeanZ"
  * "fftBodyAccelerationMagnitudeMean"
  * "fftBodyBodyAccelerationJerkMagnitudeMean"
  * "fftBodyBodyGyroMagnitudeMean"
  * "fftBodyBodyGyroJerkMagnitudeMean"
  * "timeBodyAccelerationStdX"
  * "timeBodyAccelerationStdY"
  * "timeBodyAccelerationStdZ"
  * "timeGravityAccelerationStdX"
  * "timeGravityAccelerationStdY"
  * "timeGravityAccelerationStdZ"
  * "timeBodyAccelerationJerkStdX"
  * "timeBodyAccelerationJerkStdY"
  * "timeBodyAccelerationJerkStdZ"
  * "timeBodyGyroStdX"
  * "timeBodyGyroStdY"
  * "timeBodyGyroStdZ"
  * "timeBodyGyroJerkStdX"
  * "timeBodyGyroJerkStdY"
  * "timeBodyGyroJerkStdZ"
  * "timeBodyAccelerationMagnitudeStd"
  * "timeGravityAccelerationMagnitudeStd"
  * "timeBodyAccelerationJerkMagnitudeStd"
  * "timeBodyGyroMagnitudeStd"
  * "timeBodyGyroJerkMagnitudeStd"
  * "fftBodyAccelerationStdX"
  * "fftBodyAccelerationStdY"
  * "fftBodyAccelerationStdZ"
  * "fftBodyAccelerationJerkStdX"
  * "fftBodyAccelerationJerkStdY"
  * "fftBodyAccelerationJerkStdZ"
  * "fftBodyGyroStdX"
  * "fftBodyGyroStdY"
  * "fftBodyGyroStdZ"
  * "fftBodyAccelerationMagnitudeStd"
  * "fftBodyBodyAccelerationJerkMagnitudeStd"
  * "fftBodyBodyGyroMagnitudeStd"
  * "fftBodyBodyGyroJerkMagnitudeStd"

* mean: the average of each variable for each activity and each subject. Note that measurements are normalised and so unitlless

The output dataset is tidy because:
* Each variable (subject, activity, variable, mean) is in its own column
* Each observation is in a different row
* In addition, levels within a variable have descriptive labels written in easily readable CamelCase

## Transformation Performed

* Read source data
  * Each source data file is read into a separate data frame
  * variables are renamed in descriptive languages (e.g., subject, activity) or using measurement labels from features.txt
* Combine data frames
  * Data frames for the traning set are combined (using cbind) into one data frame 
  * Separately, data frames for the test set are also combined (using cbind) into one data frame 
  * Both the combined training and test data frames now have 563 variables (the original 561 from the X data file, 1 from the subject id file, 1 from y data file) 
  * The two data frames of combined train and test set data frames are further merged into one complete data frame (using rbind)
* Extract measurements
  * From the complete data frame, measurements related to mean and std are extracted using grep. 
  * The extracted data frames are then combined with subject id and activity information (using cbind) to form the subset data frame on which the output tidy dataset will be based
* Apply descriptive labels
  * Levels in the activity variable are renamed using information from activity_labels.txt
  * Measurement names are made descriptive by applying the following changes:
    * Remove symbols from names
    * Replace t with time and f with fft (for Fast Fourier Transform)
    * Expand Acc as Accerleration
    * Expand Mag as Magnitude
    * Put everyhing in CamelCase
* Creat the tidy dataset
  * Transform the dataset using melt with subject and activity as the identifiers. The resulting dataset has 4 variables: subject, activity, variable (which contains the measurements in one column), and value (that is associated with the subject, activity, and the specific measurement)
  * Transform the dataset again using ddply to obtain the average of each variable (i.e., measurement) for each activity and each subject
  * Write the final tidy dataset out to tidydataset.txt


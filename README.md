# README.md

## What is in this repo?

This repo contains 4 files:
* README.md: the file you are reading
* run_analysis.R: the R script that performs the data analysis
* tidydataset.txt: the resulting tidy dataset produced by run_analysis.R
* CodeBook.md: describes the source data, the varaibles in the output tidy dataset (tidydataset.txt), and  transformations performed to the source data in order to produce the tidy dataset (run_analysis.R) 

## What does the script run_analysis.R do?

It reads in the source data files and produce a tidy dataset

## How to run the script?

To run the script run_analysis.R, you will need:

* Unzipped data folder "UCI HAR Dataset" present in the working directory of RStudio
* R package libraries: dplyr, plyr, reshape2

## How to read the output tidy dataset?

read.table("tidydataset.txt", header=TRUE)

## Cool! How did you create such a beautiful tidy dataset?

Please refer to the CodeBook.md file in this repo

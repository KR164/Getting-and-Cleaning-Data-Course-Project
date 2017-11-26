# Getting-and-Cleaning-Data-Course-Project
This repository contains my work on the dataset given in the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It contains 3 other documents:
run_analysis.R: this is the script that merges the 'test' and 'train' datasets if Dataset.zip is unzipped in the same folder as the script.
    It also extracts only the 88 measurements on the 'mean' and 'standard deviation' for each measurement. 
    It replaces the activity numbers 1 to 6 with the descriptive variable names that are available in a separate file in the dataset.
    It adds and adjusts the variable names to be a bit more descriptive, using the sub() function.
    It creates a 2nd, tall and skinny dataframe with the average of each variable for each activity and each of the 30 subjects.
    It writes the result to a csv file (tidydataset.csv)
tidydataset.csv: this is the result of the script run_analysis.R
codebook.tx: this explains the variables in tidydataset.csv

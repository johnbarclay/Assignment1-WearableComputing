---
title: "ReadMe"
author: "John Barclay"
date: "March 9, 2016"
output: html_document
---

This data set is a course assignment.

## Background Material and Data Sources
* summary of this package is in "assignment.MD" file
* Data Used: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Article On Study: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* summaries of data can be found in UCI HAR Dataset/features_info.text


## Script
The script to transform all the data is called "run_analysis.R"


## Output files

See UCI HAR Dataset/features_info.text for observational variables; units have not been changed.

* AssignmentSteps1to4Result.csv
    * subject: integer from 1 to 30 representing subjects in experiments
    * activity: See "activity labels.txt" for mapping. WALKING,WALKING UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING
    * type: character of "train" or "test"
    * tBodyAcc.tBodyAcc.mean.X ...fBodyBodyGyroJerkMag.meanFreq.  values for Dataset/features_info.text variables.


* AssignmentStep5Result.csv
    * subject: integer from 1 to 30 representing subjects in experiments
    * activity: See "activity labels.txt" for mapping. WALKING,WALKING UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING
    * tBodyAcc.tBodyAcc.mean.X ...fBodyBodyGyroJerkMag.meanFreq.  Mean of all Dataset/features_info.text values for subject and activity from both train and test data.


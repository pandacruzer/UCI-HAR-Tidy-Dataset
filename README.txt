==================================================================
HAR Tidy Dataset
Version 1.0
Author: Peter Zhang
Date: 6/27/2020
==================================================================

This project aims to process the Human Activity Recognition Using Smartphones Dataset[1] to a tidy, use-specific format. The features in this database is a processed version of the HAR dataset[1], combining the test and train data and outputs the average of all mean and standard deviation meansurements by the six activities and test subjects.


The dataset includes the following files:
=========================================

- 'README.txt'

- 'Run_analysis.R': R script to create the tidy database.

- 'HAR_tidy_codebook.txt': Shows information about the variables included in the dataset.

- 'data_features.csv': List of all features.

- 'HAR_tidy_dataset.txt': Combined and process tidy data at the test subject, activity level.


Usage
=====

To use Run_analysis.R, first change the working directory to your direcctory of choice.
		
		wd <- "[your directory of choice]"

Once wd is changed, run through the entire script to arrive at the outputs
		'HAR_tidy_dataset.txt'
		'data_features.csv'


Process 
=======
- Download and unzips data source from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
- Understand data using accompanying 'README.txt' and 'features_info.txt'
- Loads all relevant data files:
	activity_labels.txt
	features.txt
	subject_train.txt
	X_train
	y_train
	X_test
	y_test
- Apply column names to x_train and y_train using "features.txt", keeping the original order
- Add y_test and y_train to the dataset to pull in activity_label from 'activity_labels.txt'
- Append train and test sets into one dataset
- Use name match to look for column names with Mean/mean or std and keep only those and attribute columns
- Export updated column list to 'data_features.csv'
- Summarize data to test subject and activity type level and output as 'HAR_tidy_dataset.csv'


Reference:
========
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
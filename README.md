# UCI HAR Data Analysis

This repository contains an R script that processes the UCI Human Activity Recognition (HAR) dataset to generate a tidy dataset with the average of each variable for each activity and each subject.

## Files

- `run_analysis.R`: The R script that performs the data merging, extraction, labeling, and calculation of averages.
- `tidy_data.txt`: The output from `run_analysis.R` containing the tidy dataset.
- `README.md`: This file.
- `CodeBook.md`: A file describing the variables in the dataset.

## Instructions

1. Download the UCI HAR Dataset and place it in your working directory.
2. Run the `run_analysis.R` script in R.
3. The output will be saved as `tidy_data.txt` in your working directory.

## Requirements

- R (version 3.5 or higher)
- dplyr package
- data.table package

## How to Run

1. Clone this repository or download the files.
2. Download the UCI HAR dataset from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip it in the working directory.
3. Run `run_analysis.R` in R. The tidy dataset will be saved as `tidy_data.txt`.

# Final Project for Getting & Cleaning Data

## Project Description

This project uses data from a study in wearable computing. The data from the
study is available at the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The objective of this project is to produce two clean data sets:
* A combined set of training and test data, containing only the measurements on
the mean and standard deviation.
* A second data set, containing averages of each measurement for each subject
and activity.

## Methodology

To clean up the data, we employ some base R functions and some functions from
the dplyr package. 

Activity labels are drawn from the 
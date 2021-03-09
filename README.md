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

Activity labels are drawn from Data/activity_labels.txt. The files y_test.txt
and y_train.txt contain vectors of integers between 1 and 6 that correspond to
these labels. The first section of code generates this vector with human-
readable names.

We then read in the data from features.txt, which contains the names of the 561
measurements logged in each line of X_test.txt and X_train.txt. Using Regex, we
identify which positions on each vector are mean() or std() values, and mark
those to be selected later. We also strip all punctuation and make the names
lowercase, for more readable column names.

As we read in the data from X_test.txt and X_train.txt, we use the column labels
created in the last step, and make sure to select only the rows identified 
above. We create a new table from the vector of subject IDs, the vector of
activities, and the data table we imported for each of X_test and X_train. Once
we combine these two tables, we have a clean data set.

To obtain the second data set, we simply use the melt() and dcast() functions
from the reshape2 package. Melt() generates a tall data frame with one variable
per row, while dcast() takes the melted data and creates a table of the mean
value of each variable per subject and activity.

A description of the variables is contained in the file codebook.txt.
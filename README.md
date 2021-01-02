# Getting-and-Cleaning-Data

## Data imports
Variable names and datasets were imported, and variable names were assigned to the two main files (X_test and X_train).

For each data use (test and train), the three available sets of data were then compiled using `cbind()`, and then the complete dataset was made by combining those two resulting datasets with `rbind()`

The activity labels file was then imported and merged with the main file. The data along variables with mean() and std() were then selected, and the means were then calculated along the groups subject and activity.
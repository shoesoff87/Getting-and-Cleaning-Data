library(tidyverse)
col_names <- read.table("./UCI HAR Dataset/features.txt")
col_names <- col_names[,2]

X_test <- setNames(read.table("./UCI HAR Dataset/test/X_test.txt"), col_names)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") %>%
        mutate(datause = "test") # add a label for the use of the data


X_train <- setNames(read.table("./UCI HAR Dataset/train/X_train.txt"), col_names)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") %>%
        mutate(datause = "train") # add a label for the use of the data


test_all <- cbind(subject_test, y_test, X_test)# combine the test datasets files
train_all <- cbind(subject_train, y_train, X_train) # combine the training dataset files

X_all <- rbind(test_all, train_all) # combine the test and train datasets
colnames(X_all)[1:3] <- c("subject", "datause","activity_ID")

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activity_ID","activity"))
X_all <- merge(activity_labels, X_all) # Get the activity description

X_all2 <- X_all %>%
        select(subject, datause, activity, contains(c("mean()", "std"))) # filter only for variables that have mean or std

library(tidyverse)

# Get variable names
col_names <- read.table("./UCI HAR Dataset/features.txt")
col_names <- col_names[,2] # create variable name vector

# Import test data
X_test <- setNames(read.table("./UCI HAR Dataset/test/X_test.txt"), col_names) # also assign variable names
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Import training data
X_train <- setNames(read.table("./UCI HAR Dataset/train/X_train.txt"), col_names) # also assign variable names
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Combine datasets
test_all <- cbind(subject_test, y_test, X_test)# combine the test datasets files
train_all <- cbind(subject_train, y_train, X_train) # combine the training dataset files
X_all <- rbind(test_all, train_all) # combine the test and train datasets
colnames(X_all)[1:2] <- c("subject", "activity_ID")

# Activity description
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activity_ID","activity"))
X_all <- merge(activity_labels, X_all) # Get the activity description

Clean <- X_all %>%
        select(subject, activity, contains(c("mean()", "std"))) %>% # filter for mean or std
        group_by(subject, activity) %>%
        summarize_all(mean)

write.table(Clean, "tidy_data.txt", row.names = FALSE)
print(Clean)
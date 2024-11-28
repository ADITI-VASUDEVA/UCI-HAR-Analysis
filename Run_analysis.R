# Step 1: Load necessary libraries
library(dplyr)
install.packages("data.table")
library(data.table)

# Step 2: Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "UCI_HAR_Dataset.zip"
if (!file.exists(zip_file)) {
  download.file(url, zip_file, method = "curl")
}
unzip(zip_file)

# Step 3: Read in the data
# Load features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityLabel"))

# Load the training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityId")

# Load the test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityId")

# Step 4: Merge the training and test sets
subject_data <- rbind(subject_train, subject_test)
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)

# Combine all data into one dataset
all_data <- cbind(subject_data, y_data, X_data)

# Step 5: Extract measurements on the mean and standard deviation
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$feature)
selected_data <- all_data[, c(1, 2, mean_std_features + 2)]

# Step 6: Use descriptive activity names
selected_data <- merge(selected_data, activity_labels, by.x = "activityId", by.y = "activityId")
selected_data$activityId <- NULL  # Remove activityId column after merging

# Step 7: Label the dataset with descriptive variable names
names(selected_data) <- gsub("^t", "time", names(selected_data))
names(selected_data) <- gsub("^f", "frequency", names(selected_data))
names(selected_data) <- gsub("Acc", "Accelerometer", names(selected_data))
names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))
names(selected_data) <- gsub("BodyBody", "Body", names(selected_data))

# Step 8: Create a tidy dataset with the average of each variable for each activity and each subject
tidy_data <- selected_data %>%
  group_by(subject, activityLabel) %>%
  summarise(across(everything(), mean))

# Write the tidy data to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

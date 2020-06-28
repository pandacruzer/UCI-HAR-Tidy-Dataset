

##----- Download, unzip -----##
wd <- "C:/Users/pz11965/Documents/R Coursera/Getting and Cleaning Data/Project"
setwd(wd)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "getdata_projectfiles_UCI HAR Dataset.zip")
unzip("getdata_projectfiles_UCI HAR Dataset.zip")


##----- Load and process train input -----##
wd <- paste0(wd,"/UCI HAR Dataset/")
setwd(wd)

features <- read.table("features.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
act_label <- read.table("activity_labels.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)

x_train <- read.table("train/X_train.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
y_train <- read.table("train/y_train.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
subject_train <- read.table("train/subject_train.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)

# Criteria 4 - Appropriately labels the data set with descriptive variable names
# names columns with headers in "features.txt"
names(x_train) <- features$V2
x_train$record_num <- as.numeric(rownames(x_train))
x_train$subject <- subject_train$V1
x_train$act_num <- y_train$V1

# keep track of the train records
x_train$set <- "train"

# Criteria 3 - Use descriptive activity names to name the activities in the data set
# merge in activity names by the activity number
names(act_label) <- c("act_num", "act_label")
x_train <- merge(x_train, act_label, by = "act_num", all.x = TRUE)
x_train <- x_train[order(x_train$record_num),]


##----- Load and process test input -----##

x_test <- read.table("test/X_test.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
y_test <- read.table("test/y_test.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
subject_test <- read.table("test/subject_test.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)


# Criteria 4 - Appropriately labels the data set with descriptive variable names
# names columns with headers in "features.txt"
names(x_test) <- features$V2
x_test$record_num <- as.numeric(rownames(x_test))
x_test$subject <- subject_test$V1
x_test$act_num <- y_test$V1

# keep track of the test records
x_test$set <- "test"

# Criteria 3 - Use descriptive activity names to name the activities in the data set
# merge in activity names by the activity number
x_test <- merge(x_test, act_label, by = "act_num", all.x = TRUE)
x_test <- x_test[order(x_test$record_num),]


##----- Merge train and test input -----##

# Check that all columns match before appending; should = 1
sum(names(x_train) == names(x_test))/length(names(x_train))

# criteria 1 - Merges the training and the test sets to create one data set
x_aggregated <- rbind(x_train, x_test)

# Criteria 2 - Extracts only the measurements on the mean and standard deviation for each measurement
# Here taking all the features with Mean/mean, or std in their names as mean and std measurements

# Pull column numbers of the mean and std columns
mean_std_list <- grep("[Mm]ean|std", names(x_aggregated))

# Pull column numbers of the attibute columns
attribute_col <- grep("act_num|subject|act_label", names(x_aggregated))

col_to_keep <- c(mean_std_list, attribute_col)

length(col_to_keep)
x_aggr_mean_std <- x_aggregated[, col_to_keep]
x_columns <- names(x_aggr_mean_std)


##----- Create average at the activity and subject level----- ##

# criteria 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
x_avg <- x_aggr_mean_std %>% group_by(act_label, subject) %>% summarise_each(funs(mean))
x_avg <- data.frame(x_avg)

##----- Export tidy dataset -----##
write.table(x_avg, "HAR_tidy_dataset.txt", row.names = FALSE)
write.csv(x_columns, "data_features.csv")







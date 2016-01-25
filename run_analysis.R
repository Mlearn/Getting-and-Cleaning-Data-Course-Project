run_analysis <- function() {
  library(dplyr)
  # Before we start, Read the training and test data seperately
  X_train <- read.table("./train/X_train.txt")
  y_train <- read.table("./train/y_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  
  X_test <- read.table("./test/X_test.txt")
  y_test <- read.table("./test/y_test.txt")
  subject_test <- read.table("./test/subject_test.txt")
  
  # 1. Merges the training and the test sets to create one data set: merge_data
  merge_data <- rbind(X_train, X_test)
  merge_active <- rbind(y_train, y_test)
  merge_subject <- rbind(subject_train, subject_test)
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement
  #    In this step, we need the feature every column means to pick the useful column data
  features <- readLines("./features.txt")
  used <- grep("mean|std", features)
  merge_data <- merge_data[,used]
  
  # 3. Uses descriptive activity names to name the activities in the data set
  activities_names <- read.table("activity_labels.txt")
  #merge_active <- merge(merge_active, activities_names, by.y="V1")
  for (i in activities_names$V1) {
    merge_active$V1 <- sub(as.character(i), activities_names$V2[i], merge_active$V1)
  }
  
  # 4. Appropriately labels the data set with descriptive variable names
  cname <- sapply(strsplit(features[used]," "), function(x){gsub("\\(\\)","",x[[2]])})
  cname <- make.names(cname)
  colnames(merge_data) <- cname
  merge_data <- tbl_df(merge_data)
  merge_data$activity = as.factor(merge_active[,1])
  merge_data$subject = as.factor(merge_subject[,1])
  
  # 5. Creates a second, independent tidy data set with the average
  # of each variable for each activity and each subject
  group_data <- group_by(merge_data, subject, activity)
  average_group <- summarize_each(group_data, funs(mean))
  
  write.table(average_group,"analyzed_result.txt", row.names = FALSE)
}
# How to run the script
First of all, you should download the data from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip it to your local disk.

Secondly, download the "run_analysis.R" script to your local disk, and make sure to put it in the same directory as the unzipped data. After you did this, the directory contains:

> * ./test/
> * ./train/
> * ./activity_labels.txt
> * ./features_info.txt
> * ./features.txt
> * ./README.txt
> * ./run_analysis.R

After everything is OK, open your R console and set you R's working directory as where the data set is, by typing the command *setwd()* with the first argument a double quoted directory.

Finally, to run the script, you should first load it to your working environment by typing command *source("run\_analysis.R")*. After that ,type *run\_analysis()* to create a tidy data file named "analyzied_result.txt" in the same directory.

# Script description
The function *run_analysis()* mainly did five things for you. Before all, it loaded all needed data sets and 
assigned to corresponding variable. 

* Step 1: Merged the training and test data set together by using *rbind()*. 

* Step 2: Readed all the column names from "features.txt" and picked out the useful names using *grep()* function.

* Step 3: Loaded the descriptive activity names from "activity_labels.txt", and used it to change the active class number to descriptive names in the merged data set created in step 1.

* Step 4: Appropriately labeled the data set with descriptive variable names

* Step 5: Grouped the merged data by factor "activity" and "subject". The calculated every variable's average value for each group, save the result to a new file named "analyzed_result.txt".
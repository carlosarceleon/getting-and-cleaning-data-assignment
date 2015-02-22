#
########################################## 
################# PART 1 ################# 
########################################## 

# 
# Read the data labels and change troublesome or confusing names
#
labels <- as.vector(read.table("../UCI HAR Dataset/features.txt")[,2]);
labels <- gsub("[(][)]","",labels)
labels <- gsub("[(]","_",labels)
labels <- gsub("[)]","_",labels)
labels <- gsub("_$","",labels)
labels <- gsub(",","_",labels)
labels <- gsub("-","_",labels)
labels <- gsub("^f","frequencyDomain_",labels)
labels <- gsub("^t","timeDomain_",labels)
labels <- gsub("_t","_timeDomain_",labels)
labels <- gsub("_f","_frequencyDomain_",labels)

# 
# Read the raw data in
#
x_train <- read.table("../UCI HAR Dataset/train/X_train.txt",col.names=labels); # Read X_train
x_train['Data_set'] <- "train" # Label this variable to differenciate it from test
y_train <- read.table("../UCI HAR Dataset/train/y_train.txt",col.names=c('Activity_label')); # Read y_train
x_train['Activity_label'] <- y_train # Append the activity label

x_test  <- read.table("../UCI HAR Dataset/test/X_test.txt",col.names=labels); #Read X_test
x_test['Data_set'] <- "test" # Label this variable to differenciate it from train
y_test  <- read.table("../UCI HAR Dataset/test/y_test.txt",col.names=c('Activity_label')); # Read y_test
x_test['Activity_label'] <- y_test # Append the activity label

# 
# Merge the data
#
merged_data <- rbind(x_test,x_train) # Do the actual appending of the data sets into a single one

#
########################################## 
################# PART 2 ################# 
########################################## 
#

#
# Get all labels related to standard deviations
#
std_labels <- colnames(merged_data)[grep('std',colnames(merged_data))]
#
# Get all labels related to averages
#
mean_labels <- colnames(merged_data)[grep('mean',colnames(merged_data))]

#
# Extract std and mean labels from the merged dataset and overwrite it
#
merged_data <- merged_data[,c(mean_labels,std_labels,"Activity_label","Data_set")]

#
########################################## 
################# PART 3 ################# 
########################################## 
#

#
# Read the activity label ID numbers from the provided text file
#
activity_labels  <- as.vector(read.table("../UCI HAR Dataset/activity_labels.txt")$V2); 

#
# For all the available activities, change them in the data frame
#
for(i in 1:length(activity_labels)){
   merged_data$Activity_label[merged_data$Activity_label==i] <- activity_labels[i]
}

#
########################################## 
################# PART 4 ################# 
########################################## 
#

# Part 4 is conducted above

#
########################################## 
################# PART 5 ################# 
########################################## 
#
library(plyr)
tidy_data <- ddply(merged_data, c('Data_set','Activity_label'), numcolwise(mean))

#
########################################## 
################ Code Book ############### 
########################################## 
#
write.table(colnames(tidy_data), file = "CodeBook.md", row.name = FALSE, quote = FALSE)

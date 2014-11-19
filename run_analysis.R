merge_data <- function(){

## import dplyr, tidyr
library(dplyr)
library(tidyr)

## Load Data
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

X_df <- rbind(X_train, X_test) # Merge X_train and X_test
names(X_df) <- features[,2] # Naming variables with Descriptive names(col2)
X <- tbl_df(X_df) # Transform to tbl

## remove duplicated columns
duplicated_colNo <- duplicated(names(X))
X <- X[,!duplicated_colNo] # length(names(X)) = 477

## subsetting mean and std

##extract_mean_std <- function(X, target){  # X = tbl_df; target = string
  X_onlywith_mean <- select(X,contains("-mean")) # Error: found duplicated column name
  X_onlywith_std <- select(X,contains("-std"))
##  return(X_onlywith_mean,X_onlywith_std)

## merge two blocks and make a new table X
X <- cbind(X_onlywith_mean, X_onlywith_std)

subject_values <- rbind(subject_train, subject_test)
names(subject_values) <- c("subject")
activity_values <- rbind(Y_train, Y_test)
activity_values <- sapply(activity_values, function(x) activity_labels[x,2]) ## maps activity values (digit) to descriptive strings
activity_values <- data.frame(activity_values)
names(activity_values) <- c("activity")

X <- cbind(X, subject_values, activity_values)
names(X)<-sub("-","_",names(X)) ## remove the 1st hyphen
names(X)<-gsub("[()]","",names(X))  ## remove brackets
return(X)
}

## 4.Appropriately labels the data set with descriptive variable names.
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- function(X){
  
X %>%
   gather(type_measure, value, -subject, -activity) %>%
   separate(type_measure, c("type", "measure"), sep = "_") %>% ## e.g. tBodyAcc-mean()-X -> [tBodyAcc, mean-X]
   group_by(subject, activity, type, measure) %>% ##  group_by(subject, activity) = -0.6042467
   mutate(average = mean(value),
          group_n = n())
}

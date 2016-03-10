#


#require("reshape2");
require("dplyr");

rm("features","colNames.Obs","colNames.Filter","observations","meansBySubjectXActivity");

# Script to do the following:
#   - Merges the training and the test sets to create one data set.
#   - Extracts only the measurements on the mean and standard deviation for each measurement.
#   - Uses descriptive activity names to name the activities in the data set
#   - Appropriately labels the data set with descriptive variable names.
#   - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# develop vector of observation variable headings
features <- read.table(file = "UCI HAR Dataset/features.txt" );
features <- mutate(features, V2 = gsub("[-]",".",V2))  ## tBodyAcc-std()-Y
features <- mutate(features, V2 = gsub("[()]","",V2))  ## tBodyAcc-std()-Y
colNames.Obs <- features$V2;
rm("features");

# develop vector of desired observational columns including independent variables (subject, activity, type)
colNames.Filter <- c("subject","activity", "type", colNames.Obs[grepl("mean|std", colNames.Obs)]);

# get training and test data into table
observations <- rbind(
    DF.FromFiles("train", colNames.Filter, colNames.Obs), 
    DF.FromFiles("test",colNames.Filter, colNames.Obs)
    ); 



# calculate mean by subject and activity (across test and train types)
meansBySubjectXActivity <- ddply(observations,.(subject,activity),colwise(mean));
# remove type column, it has no meaning since our average included both types
meansBySubjectXActivity <- meansBySubjectXActivity[ , !names(meansBySubjectXActivity) %in% c("type")]

write.csv(observations, file="AssignmentSteps1to4Result.csv", append = FALSE);
write.csv(meansBySubjectXActivity, file="AssignmentStep5Result.csv", append = FALSE);

#' DF.FromFiles function a data frame for a particular observation type
#'
#' @param obsName should be "test" or "train"
#' @param colNames.Filter character vector of columns to keep
#' @param colNames.Obs character vector of variable columns in file
#'
#' @return df with one row for each observation.
#'          indepent variables: 
#'              type = "test" or "train"
#'              subject = numeric id of participant
#'              activity = actity such as WALKING
#'          dependent variables:  observation names.
#'
DF.FromFiles <- function(obsName, colNames.Filter, colNames.Obs) { # obsName = "test" or "train"
    
    table.obs <- read.table(file = paste0("UCI HAR Dataset/", obsName, "/X_", obsName, ".txt"), col.name = colNames.Obs );  
    table.variables <- read.table(file = paste0("UCI HAR Dataset/", obsName, "/Y_", obsName, ".txt") , col.names = c("measurement"));
    table.subjects <- read.table(file = paste0("UCI HAR Dataset/", obsName, "/subject_", obsName, ".txt") , col.names = c("subject") );
    table <- cbind(table.subjects, table.variables, table.obs);
    table <- mutate(table, type = obsName);
    # add activity names
    labels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
    table <- mutate(table, activity = labels[as.integer(table$measurement)])
    table <- table[,colNames.Filter];
    return (table);
}

pkgTest <- function(x)
{
    if (!require(x,character.only = TRUE))
    {
        install.packages(x,dep=TRUE)
        if(!require(x,character.only = TRUE)) stop("Package not found")
    }
}


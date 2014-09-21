# Load test data files to test data frames
#   x: data
#   y: activities
#   subject: participant

y_test <- read.table("./test/y_test.txt")
x_test <- read.table("./test/X_test.txt")
subject_test <- read.table("./test/subject_test.txt")

# Load train data files to train data frames
#   x: data
#   y: activities
#   subject: participant

y_train <- read.table("./train/y_train.txt")
x_train <- read.table("./train/X_train.txt")
subject_train <- read.table("./train/subject_train.txt")


# Optional step: Verify the subject train and test are distinct
# should return integer(0)

intersect(subject_test$V1,subject_train$V1)


# provide descriptive column names for Activity and Subject 

names(y_test) <- "ActivityID"
names(y_train) <- "ActivityID"
names(subject_test) <- "SubjectID"
names(subject_train) <- "SubjectID"


# concatenated rows into 3 dataframes representing the 1 data set for the project

ActivityT <- rbind(y_test,y_train)
DataT <- rbind(x_test,x_train)
SubjectT <- rbind(subject_test,subject_train)


# Optional Step: Verify the row count consistancy should be the same for the 3 dataframe
#  before merging them column wise
#  With my current dataset rownum was 10299

nrow(ActivityT)
nrow(DataT)
nrow(SubjectT)

# Load the descriptive feature names

featureNames <- read.table("./features.txt")
names(featureNames) <- c("featureID","featureName")



# Load the Activity names

activityLabels <- read.table("./activity_labels.txt")
names(activityLabels) <- c("ActivityID","ActivityName")
featureHeaders <- featureNames[order(featureNames$featureID),"featureName"]
featureHeaders <- as.character(featureHeaders)


# Add descriptive Activity Labels to dataT
names(DataT) <- featureHeaders

# Extract the relevant columns from DataT for only mean() and std()
#   mean():  mean
#   std() :  standard deviation
#   Refer the README.txt
#  The data set name is MeanStdT

meanCol <- grep("mean()", featureHeaders,fixed=TRUE)
stdCol <- grep("std()", featureHeaders, fixed=TRUE)
allCol <- c(meanCol,stdCol)
MeanStdT<- DataT[,allCol]


# Optional Step:  Verify that all columns are extracted
#   66 Columns
#   Only main() and std() columns are included in MeanStdT 
#   Only FALSE is expected from the grep statement

length(allCol)
length(names(MeanStdT))
!(grep("-mean()",names(MeanStdT),fixed=TRUE)&grep("-std()",names(MeanStdT),fixed=TRUE))



# Contruct dataset 2 called Data2 with columns:
# SubjectID, ActivityID, Mean and Std columns
#

Data2 <- cbind(SubjectT,ActivityT,MeanStdT)


# Optional step Verify number of columns is 68
ncol(Data2)

# Optional step verify Data2 and activityLabels only have ActivityID as common variable
intersect(names(Data2),names(activityLabels))


# Add the descriptive activity names to Data2 to form Data3 for the third question of the project
#

Data3 <- merge(Data2,activityLabels)


# Appropiate label the data with descriptive variable names already done in #9
#  The Data frame Data3 has descriptive activity names and descriptive variable names



# from the dataset Data3, create a new independent tidy dataset with the average
# of each variable for each activity and each subject

# Get the indices of the columns for execution of aggregated mean function
l <- c(grep("mean()",names(Data3),fixed=TRUE),grep("std()",names(Data3),fixed=TRUE))

# Load the library reshape2
library(reshape2)

# Reshape the Dataset 3 using melt function to variable/value combination
#  multi-type column
Data4Melt <- melt(Data3,id=c("ActivityName","ActivityID","SubjectID"), measure.vars=l)

# Reshape the dataset by applying the mean() function over groups of ActivityName and SubjectID
# using dcast function
# 
ActSubData <- dcast(Data4Melt,paste(ActivityName,"-",SubjectID,sep="")~variable,mean)

# Prepare to add back the Activity name and Subject ID to the result data set
#  Vector Activity represent the activities
#  Vector Subject  represent the SubjectID
#
lis <- strsplit(ActSubData[,1],"-")

Activity <- NULL
Subject <- NULL

for (i in 1:length(lis)) {
  Activity <- c(Activity,lis[[i]][1])
  Subject <- c(Subject,lis[[i]][2])
}

# Option Step: Verify the length of Activity and Subject are matching
# to the row count of ActSubData, in my case 180
# 

length(Activity)
length(Subject)
nrow(ActSubData)

# Drop the first column used by melt function
#
drops <- names(ActSubData)[1]
FinalResult <- ActSubData[,!(names(ActSubData) %in% drops)]

# Add the 2 columns Activity and Subject
FinalResult <- cbind(Activity,Subject,FinalResult)


# Export data set as a txt file into the local directory
# write.csv(FinalResult, "./MyTidyResult.csv")

write.table(FinalResult, "./MyTidyResult.txt", row.name=FALSE) 

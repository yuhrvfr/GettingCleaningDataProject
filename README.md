GettingCleaningDataProject
==========================

#Objective of the project 

Get tidy data representing the average of mean and standard deviation per activity and per subject based on dataset provided by this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Create one R script called run_analysis.R that does the following:

1 Merges the training and the test sets to create one data set.
   The 3 dataframes representing the 1 data set for the project
   
    Dataset name        Description
    --------------      ------------------
     ActivityT           Combined Activity
     DataT               Combined Data
     SubjectT            Combined Subject

2 Extracts only the measurements on the mean and standard deviation for each measurement. 

   The dataset DataT for only mean() and std()
      mean():  mean
      std() :  standard deviation
     Refer the README.txt
    The data set name is MeanStdT

3 Uses descriptive activity names to name the activities in the data set
   The dataset Data3 has the column ActivityName

4 Appropriately labels the data set with descriptive variable names. 
   The dataset Data3 has also the descriptive variable names added loading feature names

5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

     Dataset name: FinalResult
     Data file   : MyTidyResult.txt



Manual Steps recommanded
========================

#1 create directory project

Download "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
into the directory ./project

#2 Extract "getdata-projectfiles-UCI HAR Dataset.zip"

#3 You should find 4 directories created under ./project

    ./project
      /getdata-projectfiles-UCI HAR Dataset
        /UCI HAR Dataset
         /test
         /train

#4 Launch R console

   Verify your version, I am using:
   --------------------------------
   R version 3.1.1 (2014-07-10) -- "Sock it to Me"
   Copyright (C) 2014 The R Foundation for Statistical Computing
   Platform: x86_64-w64-mingw32/x64 (64-bit)

   I am using a Window 7 plateform on HP laptop core i3 intel with 4 Giga Byte of RAM
   
#6 Make sure you have the package reshape2 installed, if not please execute:

> install.packages("reshape2")

  follow the instruction to the find the website from which the code will come from to complete installation.


#5  go to the working directory

Either change dir in R consol of use the command below:

> setwd("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")


#6 Use the script run_analysis.R

Once you are positioned in the directory "UCI HAR Dataset".
Verify you have the script run_analysis.R and run

> source("run_analysis.R")

The result file:
       MyTidyResult.txt will be created under the directory "UCI HAR Dataset"

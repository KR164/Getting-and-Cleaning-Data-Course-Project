#Step 1 Merge 'test' and 'train' to one dataset

    data <- rbind(cbind(read.table("test/subject_test.txt"),
                        read.table("test/y_test.txt"),
                        read.table("test/X_test.txt")),
                  cbind(read.table("train/subject_train.txt"),
                        read.table("train/y_train.txt"),
                        read.table("train/X_train.txt")))
    
    #add the names 'subject', 'activity'and the featurenames 
    #to the variables
    names(data) <- c("subject", "activity", 
                     make.names(read.table("features.txt")$V2, 
                                unique = TRUE)) 

#Step 2 Extract only mean & standard deviation for each measurement
    library(dplyr)
    data <- select(data, subject, activity, 
                        contains("mean"), contains("std"))
    
#Step 3 Replace activity numbers (1-6) with activity names
    activitynames <- read.table("activity_labels.txt")
    data$activity <- activitynames$V2[match(data$activity, 
                                                 activitynames$V1)]
    
#Step 4 Descriptive variable names
  names(data) <- sub("\\.\\.\\.", "", names(data))
  names(data) <- sub("^t", "time", names(data))
  names(data) <- sub("^f", "frequency", names(data))
  names(data) <- sub("\\.std\\.", "STDEV", names(data))
  names(data) <- sub("\\.std", "STDEV", names(data))
  names(data) <- sub("\\.mean", "MEAN", names(data))
  names(data) <- sub("Mag", "Magnitude", names(data))
    
#Step 5 Create 2nd dataset with average of each variable 
#for each activity and each subject 
    library(reshape2)
    averageData <- melt(data, id = c("subject", "activity"), 
                         measure.vars = c(names(data[,3:88])))
    averageData <- ddply(averageData, .(subject, activity, variable), 
                          summarize, mean = mean(value), .inform = TRUE)
    #averageData is a tall, skinny dataframe
    
#Write the dataframe to a csv file    
    write.table(averageData, file = "tidydataset.csv", sep = ",", col.names =
                  +                 NA, row.names = TRUE)

    
    
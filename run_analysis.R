
## Getting and Cleaning Data: Course Project
## Derek M Wilson 14.10.20

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#       of each variable for each activity and each subject.

######################################################################

## STEP A : Download and Establish the working folder holding UCI HAR Dataset

## Assumes current working folder
datafolder <- getwd()

## Utilise the next two lines if needing to set the folder holding the 
## datafolder <- "/Users/DMW/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset"
## setwd(datafolder)

library("plyr")
folders <- data.frame(test=paste(datafolder,"test",sep="/")
                      ,train=paste(datafolder,"train",sep="/")
                      ,stringsAsFactors = FALSE)



## STEP B : Combine train and test data into a single dataset retaining only the 
##      Means and Standard Deviation measures for Feature Vectors

activities <- read.table('activity_labels.txt')

for (t in c('train','test')) {
        #t <- 'train'
        xvals <- read.table(paste(t,'/X_',t,'.txt',sep=''))
        yvals <- read.table(paste(t,'/Y_',t,'.txt',sep=''))
        subject <- read.table(paste(t,'/subject_',t,'.txt',sep=''))
        features <- read.table('features.txt')

        meanstd_features <- sort(c(
                                grep('mean()',features[,2],fixed=TRUE)
                                ,grep('std()',features[,2],fixed=TRUE)
                        ))
        xvals <- xvals[,meanstd_features]
        features <- features[meanstd_features,]
        colnames(xvals) <- features[,2]

        yvals <- sapply(yvals[,1],function (x) {as.character(activities[activities[,1]==x,2])})

        xvals <-cbind(
                data = t
                ,subject = subject[,1]
                ,activity = yvals
                ,xvals)

        if (t=='train') {
                HARSamsungData <- xvals
        } else {
                HARSamsungData <- rbind(HARSamsungData,xvals)
        }
}
if (sum(colSums(is.na(HARSamsungData)))!=0) {
        print('NAs exist:')
        colnames(HARSamsungData[,colSums(is.na(HARSamsungData))])
} else {print('Data prepared and checked!')}



## STEP C : Change the columns names to intuitive descriptive names
name <- names(HARSamsungData)
name[4:69] <- sub("^t","time",name[4:69])
name[4:69] <- sub("^f","frequency",name[4:69])
name[4:69] <- sub("BodyBody","Body",name[4:69])
name[4:69] <- sub("Body",".body",name[4:69])
name[4:69] <- sub("Gravity",".gravity",name[4:69])
name[4:69] <- sub("Acc",".accelerometer",name[4:69])
name[4:69]<-sub("Gyro",".gyroscope",name[4:69])
name[4:69]<-sub("Mag",".magnitude",name[4:69])
name[4:69]<-sub("Jerk",".jerk",name[4:69])
name[4:69] <- sub("-mean",".mean",name[4:69])
name[4:69] <- sub("-std",".standard_deviation",name[4:69])
name[4:69]<-sub("[(][)]","",name[4:69])
name[4:69] <- sub("-X",".x_direction",name[4:69])
name[4:69] <- sub("-Y",".y_direction",name[4:69])
name[4:69] <- sub("-Z",".z_direction",name[4:69])
##list(name)
names(HARSamsungData)<- name



## STEP D : Create new table of feature vector measure means for each subject and activity 
fvmeans <- aggregate(HARSamsungData[4:69]
                        ,list(
                                subject = HARSamsungData$subject
                                ,activity = HARSamsungData$activity
                        )
                        ,mean
                )



## STEP E : Write means of feature vector measures to tinydata.txt results file 
write.table(fvmeans,file="tinydata.txt",sep="\t",row.name=FALSE)


#load the appropriate library
library(dplyr)

# read in data from files
trainData<-read.table("~/UCI HAR Dataset/train/X_train.txt")
testData<-read.table("~/UCI HAR Dataset/test/X_test.txt")
yTrain<-read.table("~/UCI HAR Dataset/train/y_train.txt")
yTest<-read.table("~/UCI HAR Dataset/test/y_test.txt")
trainSubjects<-read.table("~/UCI HAR Dataset/train/subject_train.txt")
testSubjects<-read.table("~/UCI HAR Dataset/test/subject_test.txt")
features<-read.table("~/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
 
#assemble the data
interimData<-bind_rows(trainData, testData)
new_features<-valid_column_names<-make.names(features$V2, unique=TRUE, allow_=TRUE)
colnames(interimData)<-new_features

trainTestDesc<-bind_rows(yTrain, yTest)
trainTestDesc<-mutate(trainTestDesc, Activities = V1)
trainTestDesc<-select(trainTestDesc, Activities)

mergedData<-bind_cols(trainTestDesc, interimData)

subJects<-bind_rows(trainSubjects, testSubjects)
subJects<-mutate(subJects, Subjects = V1)
subJects<-select(subJects, Subjects)

mergedData<-bind_cols(subJects, mergedData)

#Select the relevant variables
meanData<-select(mergedData, contains("mean"))

#Bind the activities and subjects columns to the table
meanData<-bind_cols(trainTestDesc, meanData)
meanData<-bind_cols(subJects, meanData)


#Relabel (tidy the table) for easier viewing
labelSub<-function(mergedData1){
  for (i in 1:dim(mergedData1)[1])
    {
    if (mergedData1$Activities[i]==1)
        {mergedData1$Activities[i]="STANDING"}
    else if (mergedData1$Activities[i]==2)
        {mergedData1$Activities[i]="WALKING_UPSTAIRS"}
    else if (mergedData1$Activities[i]==3)
        {mergedData1$Activities[i]="WALKING_DOWNSTAIRS"}
    else if (mergedData1$Activities[i]==4)
        {mergedData1$Activities[i]="SITTING"}
    else if (mergedData1$Activities[i]==5)
        {mergedData1$Activities[i]="STANDING"}
    else if(mergedData1$Activities[i]==6)
        {mergedData1$Activities[i]="LAYING"}
    }
return(mergedData1)
}

#Run the function above to relabel the rows
meanData<-labelSub(meanData)

#Group the variables accordingly
meanData<-group_by(meanData, Subjects, Activities)

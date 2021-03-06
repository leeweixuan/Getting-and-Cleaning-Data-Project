workingdir = getwd()


'Setting directories and reading training dataset'
setwd(paste(workingdir,"/UCI HAR Dataset/train",sep=""))
Train_identifier = read.table("subject_train.txt")
Train_set = read.table("X_train.txt")
Train_labels = read.table("Y_train.txt")


'Setting directories and reading test dataset'
setwd(paste(workingdir,"/UCI HAR Dataset/test",sep=""))
Test_identifier = read.table("subject_test.txt")
Test_set = read.table("X_test.txt")
Test_labels = read.table("Y_test.txt")


'renamed labels to their activity names instead of numbers'
'combined the subject identifier set, activity set and the measurements of each activity'
'renamed variable headings using features file'
setwd(paste(workingdir,"/UCI HAR Dataset",sep=""))
activity_labels = read.table("activity_labels.txt")
features = read.table("features.txt")

Test_labels = lapply(Test_labels, function(x){x = as.character(activity_labels[x,2])})
CombinedTest = cbind(Test_identifier, Test_labels, Test_set)
Train_labels = lapply(Train_labels, function(x){x = as.character(activity_labels[x,2])})
CombinedTrain = cbind(Train_identifier, Train_labels, Train_set)

colnames(CombinedTest) = c("subject", "activity", as.character(features[,2]))
colnames(CombinedTrain) = c("subject", "activity", as.character(features[,2]))

'merging the combined test and training data set'
MergedData = rbind(CombinedTrain,CombinedTest)


'logical vector to detect column names for mean and std measurements using regular expression '
'make.names is used to convert other symbols to periods'
'first 2 columns of subject and activity are to be included'
col_to_be_kept = ifelse(grepl("(.mean...)|(.std...)", make.names(colnames(MergedData))), TRUE, FALSE)
col_to_be_kept[1:2] = TRUE

'subsetting the merged data based on the logical vector'
NewMergedData = MergedData[col_to_be_kept]

'Creates a second, independent tidy data set with the average of each variable for each activity and each subject '
library(dplyr)
SecondDataSet = 0
'Loops through each subject and then each activity to average the columns'
for (x in unique(NewMergedData$subject)){
  for (y in unique(NewMergedData$activity)){
    SubjectSubset = NewMergedData[NewMergedData$subject == x,c(1:63)]
    ActivitySubset = filter(SubjectSubset, SubjectSubset$activity == y)
    ColumnsToAverage = select(ActivitySubset, c(3:63))
    SecondDataSet = rbind(SecondDataSet,c(x,y, colMeans(ColumnsToAverage)))
  }
}
colnames(SecondDataSet)[1:2] = c("subject", "activity")
SecondDataSet = SecondDataSet[2:181,]

'writing the dataset out'
write.table(SecondDataSet, file = "SecondDataset.txt")

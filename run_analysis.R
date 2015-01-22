#install libraries
library(plyr)
library(dplyr)

#get common data
activity_labels_df <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE)
feature_labels_df <- read.table("UCI HAR Dataset/features.txt",header=FALSE)

#organize date for test
subject_test_df <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
y_test_df <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
x_test_df <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)

#rename col names for subject_test_df
names(subject_test_df)<-c("Subject")

#merge and rename col names for y_test_df
y_test_df <- merge(y_test_df,activity_labels_df, by="V1" )
y_test_df <- subset(y_test_df,select=c("V2"))
names(y_test_df)<-c("Activity")

#merge and rename col names for x_test_df
names(x_test_df) <- as.vector(feature_labels_df[,"V2"])

#bind cols for the dataframes
test_df <- cbind(subject_test_df, y_test_df, x_test_df)

#clean up test temp vars
rm(subject_test_df)
rm(y_test_df)
rm(x_test_df)




#organize data for train
subject_train_df <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
y_train_df <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
x_train_df <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)

#rename col names for subject_train_df
names(subject_train_df)<-c("Subject")

#merge and rename col names for y_train_df
y_train_df <- merge(y_train_df,activity_labels_df, by="V1" )
y_train_df <- subset(y_train_df,select=c("V2"))
names(y_train_df)<-c("Activity")

#merge and rename col names for x_train_df
names(x_train_df) <- as.vector(feature_labels_df[,"V2"])

#bind cols for the dataframes
train_df <- cbind(subject_train_df, y_train_df, x_train_df)

#clean up train vars
rm(subject_train_df)
rm(y_train_df)
rm(x_train_df)



#merger test and train
data_df <- rbind(test_df,train_df)

#clean up temp vars
rm(test_df)
rm(train_df)
rm(activity_labels_df)
rm(feature_labels_df)


#extract mean() and standard deviations std()
mean_std_cols <- grep("mean[()]|std[()]", colnames(data_df))
data_ms_df <- data_df[mean_std_cols]

#create tidy data set 
tidy_df <- cbind(data_df['Activity'],data_df['Subject'], data_ms_df)
rm(data_ms_df)
rm(data_df)
rm(mean_std_cols)


#ddply(df,.(a,b),summarize, mean=mean(c) && numcolwise(mean,na.rm = TRUE)--works
tidy_mean_df <-ddply(tidy_df, .(Subject,Activity), numcolwise(mean,na.rm = TRUE))
rm(tidy_df)

#final tidy set
write.table(tidy_mean_df, fil="tidy_mean_df.txt",  row.names="TRUE")

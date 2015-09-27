# set directory
setwd("~/Documents/software/R/CourseRA/GetData/project/UCI_HAR_Dataset/")

# readin datasets and merge them
dXtest=read.table(file="test/X_test.txt")
dXtrain=read.table(file="train/X_train.txt")
dXall=rbind(dXtest,dXtrain)

dsubject_test=read.table(file="test/subject_test.txt")
dsubject_train=read.table(file="train/subject_train.txt")
dsubject_all=rbind(dsubject_test,dsubject_train)
dytest=read.table(file="test/y_test.txt")
dytrain=read.table(file="train/y_train.txt")
dyall=rbind(dytest,dytrain)

#select only mean and std
# from the feature.txt file select the variables needed
# and put them into another file features_sel.txt
#f_sel=read.table(file='features_sel.txt')
#f_sel_1=f_sel$V1 # index of the mean and std
f_sel_1=c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85,  86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 253, 254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 505, 516, 517, 529, 530, 542, 543)
sf_sel_1=paste("V",f_sel_1,sep="") # change to column name
dXall_sel=dXall[sf_sel_1] # select subset, mean/std
#f_name=f_sel$V2 # name of the variables

f_name = c('tBodyAcc-mean()-X',           'tBodyAcc-mean()-Y',          
 'tBodyAcc-mean()-Z',           'tBodyAcc-std()-X',           
 'tBodyAcc-std()-Y',            'tBodyAcc-std()-Z',           
 'tGravityAcc-mean()-X',        'tGravityAcc-mean()-Y',       
 'tGravityAcc-mean()-Z',        'tGravityAcc-std()-X',        
 'tGravityAcc-std()-Y',         'tGravityAcc-std()-Z',        
 'tBodyAccJerk-mean()-X',       'tBodyAccJerk-mean()-Y',      
 'tBodyAccJerk-mean()-Z',       'tBodyAccJerk-std()-X',       
 'tBodyAccJerk-std()-Y',        'tBodyAccJerk-std()-Z',       
 'tBodyGyro-mean()-X',          'tBodyGyro-mean()-Y',         
 'tBodyGyro-mean()-Z',          'tBodyGyro-std()-X',          
 'tBodyGyro-std()-Y',           'tBodyGyro-std()-Z',          
 'tBodyGyroJerk-mean()-X',      'tBodyGyroJerk-mean()-Y',     
 'tBodyGyroJerk-mean()-Z',      'tBodyGyroJerk-std()-X',      
 'tBodyGyroJerk-std()-Y',       'tBodyGyroJerk-std()-Z',      
 'tBodyAccMag-mean()',          'tBodyAccMag-std()',          
 'tGravityAccMag-mean()',       'tGravityAccMag-std()',       
 'tBodyAccJerkMag-mean()',      'tBodyAccJerkMag-std()',      
 'tBodyGyroMag-mean()',         'tBodyGyroJerkMag-mean()',    
 'tBodyGyroJerkMag-std()',      'fBodyAcc-mean()-X',          
 'fBodyAcc-mean()-Y',           'fBodyAcc-mean()-Z',          
 'fBodyAcc-std()-X',            'fBodyAcc-std()-Y',           
 'fBodyAcc-std()-Z',            'fBodyAccJerk-mean()-X',      
 'fBodyAccJerk-mean()-Y',       'fBodyAccJerk-mean()-Z',      
 'fBodyAccJerk-std()-X',        'fBodyAccJerk-std()-Y',       
 'fBodyAccJerk-std()-Z',        'fBodyGyro-mean()-X',         
 'fBodyGyro-mean()-Y',          'fBodyGyro-mean()-Z',         
 'fBodyGyro-std()-X',           'fBodyGyro-std()-Y',          
 'fBodyGyro-std()-Z',           'fBodyAccMag-mean()',         
 'fBodyAccMag-std()',           'fBodyAccMag-mad()',          
 'fBodyBodyAccJerkMag-mean()',  'fBodyBodyAccJerkMag-std()',  
 'fBodyBodyGyroMag-mean()',     'fBodyBodyGyroMag-std()',     
 'fBodyBodyGyroJerkMag-mean()', 'fBodyBodyGyroJerkMag-std()' )
names(dXall_sel)=f_name # rename the columns

# read in activity label
act_label=read.table(file='activity_labels.txt')
act_name=act_label$V2

# read in activity list and get their name
dyall_1=dyall$V1
act_all=act_name[dyall_1]

# read in subject label
Subject_Label=dsubject_all$V1
Activity_Label=act_all

# merge all the data together.
MergeData=data.frame(Subject_Label,Activity_Label)
MergeData1=cbind(MergeData,dXall_sel)

# calculate by subject and activity
avgdat=aggregate(MergeData1,by=list(Subject_Label, Activity_Label), FUN=mean, na.rm=TRUE)

write.table(avgdat,"avgdat.dat",sep=",",row.names=FALSE,col.names=TRUE)

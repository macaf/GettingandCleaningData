#Downloading Test
X_test <- read.table("C:/Users/pc/Desktop/Python/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
features <- read.table("C:/Users/pc/Desktop/Python/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
names(X_test)=features[,2]
y_test <- read.table("C:/Users/pc/Desktop/Python/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
str(y_test)
range(y_test)
names(y_test)="Activity"
niveles=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
y_test$V1=factor(y_test$V1,labels = niveles)
subject_test <- read.table("C:/Users/pc/Desktop/Python/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
names(subject_test)="Subject"

#Choosing mean and std
means=grep("mean()",names(X_test))
meanfreq=grep("meanFreq()",names(X_test))
means=means[!(means %in% meanfreq)]
stds=grep("std",names(X_test))
todo=c(means,stds)
todo=sort(todo)
X_test_1=X_test[,todo]
View(X_test_1)
X_test_1=cbind(subject_test,y_test,X_test_1)

#Trainning Data
X_train <- read.table("C:/Users/pc/Desktop/Python/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
names(X_train)=features[,2]
subject_train <- read.table("C:/Users/pc/Desktop/Python/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
nrow(X_train)
nrow(subject_train)
y_train <- read.table("C:/Users/pc/Desktop/Python/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
unique(y_train)
unique(subject_train)
unique(subject_test)
names(y_train)="Activity"
y_train$Activity=factor(y_train$Activity,labels = niveles)
names(subject_train)="Subject"

#Chosing mean and std
means=grep("mean()",names(X_train))
meanfreq=grep("meanFreq()",names(X_train))
means=means[!(means %in% meanfreq)]
stds=grep("std",names(X_train))
todo=c(means,stds)
todo=sort(todo)

X_train_1=X_train[,todo]
X_train_1=cbind(subject_train,y_train,X_train_1)


#Merge Data
X_train_1$Subjet_type="Train"
X_test_1$Subjet_type="Test"
data=rbind(X_test_1,X_train_1)

#Changing Names
nombres=names(data)
nombres=gsub("-","_",nombres)
nombres=gsub("[()]", "", nombres)
names(data)=nombres
#Saving data
write.csv(data,file="data_assigment.csv")

#Mean by subject and activity
library(dplyr)
cran=as_tibble(data)
agrupado=group_by(data,Subject,Activity)%>%summarise_all(mean)

write.table(cran,file="tidydata.txt",row.name=FALSE)
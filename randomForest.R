
library(randomForest)

#Loading the Allstate data set
setwd("C:/Users/sparta/Desktop/R/Allstate")
train=read.csv("train.csv")
test=read.csv("test.csv")

# #Building test and train set
# sc= base::sample(150, 100) 
# iris_train= iris[s,]
# iris_test=iris[-s,]

#Building random forest model
rfm= randomForest(loss ~ ., train)
rfm

# Prediction
prediction=predict(rfm, test)
prediction

table(test[,"loss"], prediction)
mean(test[,"loss"]==prediction)
importance(rfm)
getTree(rfm, 500, labelVar = TRUE)

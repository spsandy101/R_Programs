rm(list = ls())
# Get data
str(iris)
table(iris$Species)
summary(iris)

# Reorder the data set
set.seed(1234)
gp=runif(nrow(iris))
iris_new=iris[order(gp),]
head(iris_new)

# Normalize the data
normalize=function(x){return((x-min(x))/(max(x)-min(x)))}
iris_new=as.data.frame(lapply(iris[, c(1,2,3,4)], normalize))
summary(iris_new)

# Create training and testing sets
iris_train= iris_new[1:129,]
iris_test=iris_new[130:150,]

iris_train_target=iris[1:129, 5]
iris_test_target=iris[130:150, 5]

# Run kNN classifier
library(class)
sqrt(150) # fix a value to k

m1=knn(train = iris_train, test = iris_test, cl=iris_train_target, k=13)
m1

# Confusion matrix
table(iris_test_target, m1)


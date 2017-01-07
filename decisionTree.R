### Decision tree using rpart ###

#Loading the Allstate data set
setwd("C:/Users/sparta/Desktop/R/Allstate")
train=read.csv("train.csv")
test=read.csv("test.csv")

# #Building test and train set
# s=base::sample(150, 55)
# train=data[-s,]
# test=data[s,]

#Working with rpart
library(rpart)
dtm=rpart(loss~., train, method = "class")

# Plot the data
library(rpart.plot)
rpart.plot(dtm)

# Make predictions
prediction= predict(dtm, test, type="class")
table(test[,"loss"], prediction)

######   Decision trees Regression #######

library(MASS)
attach(Boston)
library(tree)

set.seed(1)
train=sample(nrow(Boston), nrow(Boston)/2)
test=-train

training_data=Boston[train,]
testing_data=Boston[test,]
testing_medv=medv[test]

# Fit a tree based on training data
tree_model= tree(medv ~ ., data= training_data)
plot(tree_model)
text(tree_model, pretty=0)

# Check the model with test data
tree_pred= predict(tree_model, testing_data)
tree_pred
mse= mean((tree_pred - testing_medv)^2)
mse

## cross validation for pruning the tree
cv_tree= cv.tree(tree_model)
plot(cv_tree$size, cv_tree$dev, type = "b", xlab = "Tree size", ylab = "MSE")

which.min(cv_tree$dev)
cv_tree$size[1]

### Prune the tree to size 4 ###
pruned_model= prune.tree(tree_model, best = 4)

plot(pruned_model)
text(pruned_model, pretty = 0)

### Check the pruned model with test data
pruned_pred=predict(pruned_model, testing_data)
mse=mean((pruned_pred - testing_medv)^2)
mse



######   Decision trees Classification #######
library(ISLR)
library(tree)

attach(Carseats)

## Data Manipulation
range(Sales)
#Create a categorical variable based on sales
High= ifelse(Sales>8, "Yes", "No")
# Append High to Carseats dataset
Carseats=data.frame(Carseats, High)
names(Carseats)

## Split data into testing and training data
set.seed(2)
train=sample(nrow(Carseats), nrow(Carseats)/2)
test=-train
training_data=Carseats[train,]
testing_data=Carseats[test,]
testing_high=High[test]

# Fit the tree model using training data
tree_model=tree(High~., training_data)

plot(tree_model)
text(tree_model, pretty = 0)

# Check the model with test data
tree_pred= predict(tree_model, testing_data, type = "class")
mean(tree_pred != testing_high)


### Cross validation to check where to stop pruning

set.seed(3)

cv_tree=cv.tree(tree_model, FUN = prune.misclass)
names(cv_tree)
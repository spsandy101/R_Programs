
## Simple linear regression

library(MASS)
attach(Boston)

names(Boston)

lm.fit= lm(medv ~ lstat)
summary(lm.fit)

plot(lm.fit)

plot(lstat, medv, main = "Scatterplot", xlab = "Lstat", ylab = "Median Value")
abline(lm.fit, col="red", lwd=3)

## Multiple linear regression

pairs(Boston[c(1,3,7)])

lm.fit2=lm(medv ~ lstat+age)
summary(lm.fit2)

lm.fitAll=lm(medv ~ ., data = Boston)
summary(lm.fitAll)

lm.fit4=lm(medv ~ . - age, data= Boston)
summary(lm.fit4)

## Interaction term

lm.fit5= lm(medv~lstat*age)
summary(lm.fit5)

#Exclude age
lm.fit6= lm(medv~ lstat+lstat:age)
summary(lm.fit6)


## Adding non linear transformations of predictors

lm.fit7= lm(medv~ poly(lstat, 2))
summary(lm.fit7)

lm.fit8= lm(medv~ poly(lstat, 3))
summary(lm.fit8)
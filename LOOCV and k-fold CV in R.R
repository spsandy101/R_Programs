library(ISLR)
library(boot)
set.seed(1)
attach(Auto)

#Fit a linear model
model=glm(mpg~horsepower, data = Auto)
MSE_LOOCV= cv.glm(Auto, model)
MSE_LOOCV
MSE_LOOCV$delta[1]


MSE_LOOCV=NULL

for (i in 1:10) {
  model=glm(mpg~poly(horsepower, i), data = Auto)
  MSE_LOOCV[i]= cv.glm(Auto, model)$delta[1]
}
MSE_LOOCV
MSE_LOOCV[7]


### K-fold cv

MSE10foldCV=NULL

for (i in 1:10) {
  model=glm(mpg~poly(horsepower, i), data = Auto)
  MSE10foldCV[i]= cv.glm(Auto, model, K=10)$delta[1]
}

MSE10foldCV

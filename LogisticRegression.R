###########################
### Fitting logistic regression
### Data set: Smarket (S$P 500 stock index, 1250 observations, 9 variables
###########################

### Step1: Load data and run numerical and graphical summaries

library(ISLR)
attach(Smarket)
summary(Smarket)
str(Smarket)
cor(Smarket[,-9])
pairs(Smarket[, -9])

### Step2: Split data into testing and training sets

training= (Year < 2005)

training_data= Smarket[training, ]
testing_data= Smarket[!training, ]

Direction_testing= Direction[!training]

### Step3: Fit a logistic regression model using training data

stock_model= glm(Direction~ Lag1+Lag2+Lag3+Lag4+Lag5+Volume, 
                 data= training_data, family = binomial(link = "logit"))
summary(stock_model)

### Step4: Use the model to predict using testing data

model_pred_probs= predict(stock_model, testing_data, type = "response")

model_pred_direction= rep("Down", 252)
model_pred_direction[model_pred_probs > 0.5]="Up"

### Step5: Create the confusion matrix and compute the misclassification rate

table(model_pred_direction, Direction_testing)
misClassError= mean(model_pred_direction != Direction_testing)
misClassError



# Install e1071 package
install.packages("e1071")
library(e1071)

# Create data
classification <- function() {   
  x <- c(rnorm(50, mean=0), rnorm(50, mean=4))
  y <- c(rnorm(50, mean=4), rnorm(50, mean=0))
  z <- c(rep("1", 50), rep("0", 50))
  data <- data.frame(x, y, z)
}
data <- classification()

# Create training and test set
index = sample(100,66)
train <- data[index,]
test <- data[(1:100)[-index],]

# Modelling using Naive Bayes
mdl1 <- naiveBayes(z~., data=train)
# apriori summarization
mdl1$apriori
# Attribute summarization
mdl1$tables

# Predict
predictions <- predict(mdl1, test[,1:2])

# Predictions summary
table(predictions, test$z)
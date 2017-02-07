
### Get the data into R session
train<- read.csv("train.csv")
str(train)
pairs(train)
names(train)
View(train)
test<- read.csv("test.csv")
#Add total_sales variable to test
test$total_sales<- 0
names(test)
View(test)
sales.total<-train$total_sales
train<- train %>% select(-c("total_sales"))
model.glm<- glm(sales.total~., data = train)
test$total_sales<- predict(model.glm, data=test)


# Combine both data
data.combined<-rbind(train, test)
str(train)
pairs(train)
names(train)
View(train)


## Data preparation
library(dplyr)

# Change credit_score_range to integer
train$credit_score_range= as.integer(train$credit_score_range)

# Generate IDs for factor variable
train.modified= mutate(train, cityId= match(city, unique(city)), stateID=match(state, unique(state)),
                       zipID=match(zip, unique(zip)),
                       store_location_id= match(store_location, unique(store_location)),
                       time_zone_id= match(time_zone, unique(time_zone)),
                       location_employee_code_id= match(location_employee_code, unique(location_employee_code)),
                       credit_score_id= match(credit_score, unique(credit_score)),
                       store_location_id= match(store_location, unique(store_location)),
                       location_employee_code_id= match(location_employee_code, unique(location_employee_code))
)
# Capture the target variable
target_total_sales<- train.modified$total_sales
#Remove factor variables from training set
train.modified<- train.modified %>% select(-c(city, state, time_zone, location_employee_code, 
                                              credit_score, store_location, total_sales))
str(train.modified)
names(train.modified)
View(train.modified)


# ## Normalizing function
# normalise <- function(x) {
#   (x - mean(x))/sd(x)
# }
# 
# ##Normalise the data set
# train.modified<- sapply(train.modified, normalise, simplify = TRUE, USE.NAMES = TRUE)
# View(train.modified)

## PCA 
pca1<- princomp( train.modified, scores = TRUE, cor = TRUE, tol = sqrt(.Machine$double.eps))
summary(pca1)
loadings(pca1)
plot(pca1, type="l")
biplot(pca1)
pca1$scores[1:15]

fa1<- factanal(train.modified, factors = 7, rotation = "varimax", scores = "regression")
fa1$loadings
pc1 <- pca1$scores[,1]
pc2 <- pca1$scores[,2]
pc3 <- pca1$scores[,3]
pc4 <- pca1$scores[,4]
pc5 <- pca1$scores[,5]
pc6 <- pca1$scores[,6]
pc7 <- pca1$scores[,7]
pc_df<- data.frame(pc1, pc2, pc3, pc4, pc5, pc6, pc7)

## Make prediction
##model1<- lm(target_total_sales~., data = pc_df)

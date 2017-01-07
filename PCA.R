#Downloading a file
#temp=tempfile()
#download.file("http://www.nipsfsc.ecs.soton.ac.uk/datasets/GISETTE.zip", temp, mode = "wb")

#Unzipping a file
#unzip(temp, "GISETTE/gisette_train.data")

# Principal Component Analysis and Factor Analysis
mydata=read.csv("test.csv")
attach(mydata)
View(mydata)
str(mydata)

#Define variables
x=cbind(PassengerId, Pclass, Name, Sex, Age, SibSp, Parch, Ticket, Fare, Cabin, Embarked)

#Description statistics
summary(x)
cor(x)

#Principal component analysis
pca1=princomp(na.omit(x) , scores = TRUE, cor = TRUE)
summary(pca1)

#loadings of principal components
loadings(pca1)

#Scree plots of eigenvalues
plot(pca1)
screeplot(pca1, type = "line", main = "Scree plot")

#Biplot of score variables
biplot(pca1)

#Scores of the components
pca1$scores[1:10,]

#Rotation
#varimax(pca1$rotation)
#promax(pca1$rotation)

#Factor analysis - different results from other software and no rotation
fa1=factanal(na.omit(x), factors=3)
fa1

fa2=factanal(na.omit(x), factors = 3, rotation = "varimax")
fa2

fa3=factanal(na.omit(x), factors = 3, rotation = "varimax", scores = "regression")
fa3
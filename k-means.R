#### k-means clustering ####
# Create dataset
classification <- function() {   
  x <- c(rnorm(50, mean=0), rnorm(50, mean=4))
  y <- c(rnorm(50, mean=4), rnorm(50, mean=0))
  data <- data.frame(x, y)
}
data <- classification()

# k-means model
mdl1 <- kmeans(data, 2)
# Model summary
summary(mdl1)
# Results summary
table(mdl1$cluster)

# visualizing the cluster
plot(data, col=mdl1$cluster)
points(mdl1$centers, pch=19)
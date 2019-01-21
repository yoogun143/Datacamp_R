setwd("E:/Datacamp/R/Unsupervised Learning")
x <- read.csv('seeds.csv')
x <- x[1:2]

# Create the k-means model: km.out
km.out <- kmeans(x, centers = 3, nstart = 20)

# Inspect the result
summary(km.out)

# Print the cluster membership component of the model
km.out$cluster

# Print the km.out object
print(km.out)

# Scatter plot of x
plot(x, col = km.out$cluster,
     main = "k-means with 3 clusters",
     xlab = "",
     ylab = "")


#### HOW K-MEANS WORK
# Set up 2 x 3 plotting grid
par(mfrow = c(2, 3))

# Set seed
set.seed(1)

for(i in 1:6) {
  # Run kmeans() on x with three clusters and one start
  km.out <- kmeans(x, centers = 3, nstart = 1)
  
  # Plot clusters
  plot(x, col = km.out$cluster, 
       main = km.out$tot.withinss, 
       xlab = "", ylab = "")
}


#### SELECT NUMBER OF CLUSTERS
# Initialize total within sum of squares error: wss
wss <- 0

# For 1 to 15 cluster centers
for (i in 1:15) {
  km.out <- kmeans(x, centers = i, nstart = 20)
  # Save total within sum of squares to wss variable
  wss[i] <- km.out$tot.withinss
}

# Plot total within sum of squares vs. number of clusters
plot(1:15, wss, type = "b", 
     xlab = "Number of Clusters", 
     ylab = "Within groups sum of squares")

# Set k equal to the number of clusters corresponding to the elbow location
k <- 3
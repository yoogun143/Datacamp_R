#### LINEAR
# Create linear model: res
res <- lm(Volume ~ Girth, data = trees)

# Plot res
plot(res)

# Import ggfortify and use autoplot()
library(ggfortify)
autoplot(res, ncol = 2)


#### TIMESERIES
setwd("E:/Datacamp/R/GGplot/Part 3 - Advanced plots and ggplot2 internals")
Canada = dget('Canada.txt')

# Inspect structure of Canada
str(Canada)

# Call plot() on Canada
plot(Canada)

# Call autoplot() on Canada
autoplot(Canada)


#### DISTANCE MATRICES AND MULTI-DIMENSIONAL SCALING
# Autoplot + ggplot2 tweaking
autoplot(eurodist) + 
  coord_fixed()

# Autoplot of MDS
autoplot(cmdscale(eurodist, eig = TRUE), 
         label = TRUE, 
         label.size = 3, 
         size = 0)


#### KMEANS
# Perform clustering
iris_k <- kmeans(iris[-5], 3)

# Autoplot: color according to cluster
autoplot(iris_k, data = iris, frame = TRUE)

# Autoplot: above, plus shape according to species
autoplot(iris_k, data = iris, frame = TRUE, shape = 'Species')

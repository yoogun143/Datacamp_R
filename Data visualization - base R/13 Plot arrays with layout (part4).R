rowA <- c(1, 1, 1)
rowB <- c(2, 0, 3)
layoutVector <- c(rowA, rowA, rowB)
layoutMatrix <- matrix(layoutVector, byrow = TRUE, nrow = 3)
layout(layoutMatrix)
layout.show(n=3)
library(MASS)
plot(UScereal$sugars, UScereal$calories, pch = 15,
       col = "magenta")
title("Long, skinny scatterplot across the top of the array")
plot(density(UScereal$sugars),
       main = "Small left-hand plot: \n Sugars density")
plot(density(UScereal$calories),
       main = "Small right-hand plot: \n Calories density")
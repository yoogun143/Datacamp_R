# Load the rpart library
library(rpart)

# Fit an rpart model to predict medv from all other Boston variables
tree_model <- rpart(medv ~., data = Boston)

# Plot the structure of this decision tree model
plot(tree_model)

# Add labels to this plot
text(tree_model, cex = 0.7)
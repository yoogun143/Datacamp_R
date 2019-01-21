setwd("E:/Datacamp/R/Machine Learning Toolbox")
wine <- readRDS('wine_100.RDS')
overfit = read.csv('overfit.csv')

# Fit random forest: model
model <- train(
  quality ~ .,
  tuneLength = 3, #RF has primary tuning parameter: mtry: number of randomly selected preidctors
  data = wine, method = "ranger",
  trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE)
)

# Print model to console
model

# Plot model
plot(model)


#### CUSTOM TUNING
# Fit random forest: model
model <- train(
  quality ~ .,
  tuneGrid = data.frame(mtry = c(2,3,7), splitrule = "variance", min.node.size = 5),
  data = wine, method = "ranger",
  trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE)
)

# Print model to console
model

# Plot model
plot(model)


#### TUNE GLMNET
# Create custom trainControl: myControl
myControl <- trainControl(
  method = "cv", number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)

# Fit glmnet model: model
model <- train(
  y ~ ., data = overfit,
  method = "glmnet",
  trControl = myControl
)

# Print model to console
# Default tuning: 3 alpha, 3 lambda
# alpha[0,1]: pure lasso to pure ridge
# lambda (0, infinity): size of the penalty
model

# Plot model
plot(model)

# Print maximum ROC statistic
max(model[["results"]][['ROC']])

# Train glmnet with custom trainControl and tuning: model
model <- train(
  y ~ ., overfit,
  tuneGrid = expand.grid(
    alpha = 0:1,
    lambda = seq(0.0001, 1, length = 20)),
  method = "glmnet",
  trControl = myControl
)

# Print model to console
model
plot(model)

# Print maximum ROC statistic
max(model[["results"]][["ROC"]])
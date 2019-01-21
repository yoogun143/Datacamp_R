setwd("E:/Datacamp/R/Machine Learning Toolbox")
load('churn.RData')
library(caret)

# Create custom indices: myFolds
myFolds <- createFolds(churn_y, k = 5)

# Create reusable trainControl object: myControl
myControl <- trainControl(
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE,
  savePredictions = TRUE,
  index = myFolds
)


#### FIT GLMNET
# Fit glmnet model: model_glmnet
model_glmnet <- train(
  x = churn_x, y = churn_y,
  metric = "ROC",
  method = "glmnet",
  trControl = myControl
)


#### FIT RANDOMFOREST
# Fit random forest: model_rf
model_rf <- train(
  x = churn_x, y = churn_y,
  metric = "ROC",
  method = "ranger",
  trControl = myControl
)


#### COMPARE 2 MODELS
# => In general, you want the model with the higher median AUC, as well as a smaller range between min and max AUC.
# Create model_list
model_list <- list(item1 = model_glmnet, item2 = model_rf)

# Pass model_list to resamples(): resamples
resamples <- resamples(model_list)

# Summarize the results
summary(resamples)

# Create bwplot
bwplot(resamples, metric = "ROC")

# Create xyplot
xyplot(resamples, metric = "ROC")
# It's particularly useful for identifying if one model is consistently better than the other across all folds, or if there are situations when the inferior model produces better predictions on a particular subset of the data.

# Create dotplot
dotplot(resamples, metric = 'ROC')

# Density plot
densityplot(resamples, metric = 'ROC')


#### ENSEMBLE MODEL
library(caretEnsemble)

# Creat caretlist
models <- caretList(x = churn_x, y = churn_y,
                    trControl = myControl,
                    methodList = c('glmnet', 'ranger'))

# Create ensemble model: stack
stack <- caretStack(models, method = "glm")

# Look at summary
summary(stack)

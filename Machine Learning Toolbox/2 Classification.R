library(mlbench)
library(caret)
data("Sonar")

#### 60/40 SPLIT
# Shuffle row indices: rows
rows <- sample(nrow(Sonar))

# Randomly order data: Sonar
Sonar <- Sonar[rows, ]

# Identify row to split on: split
split <- round(nrow(Sonar) * .6)

# Create train
train <- Sonar[1:split, ]

# Create test
test <- Sonar[(split + 1):nrow(Sonar), ]


#### FIT LOGIT MODEL
# Fit glm model: model
model <- glm(Class ~ ., family = binomial(link = "logit"), train)

# Predict on test: p
p <- predict(model, test, type = "response")


#### CONFUSION MATRIX
# https://en.wikipedia.org/wiki/Confusion_matrix
# Calculate class probabilities: p_class
p_class <- ifelse(p >  0.5, "M", "R")

# Create confusion matrix
confusionMatrix(p_class, test$Class)

# Apply threshold of 0.9: p_class
p_class <- ifelse(p > 0.9, "M", "R")

# Create confusion matrix
confusionMatrix(p_class, test$Class)

# Apply threshold of 0.10: p_class
p_class <- ifelse(p > 0.1, "M", "R")

# Create confusion matrix
confusionMatrix(p_class, test$Class)


#### ROC CURVE
library(caTools)

# Predict on test: p
p <- predict(model, test, type = "response")

# Make ROC curve
colAUC(p,test$Class, plotROC = TRUE)


#### AUC
# AUC = 0.5: random guessing, 1: model always right, 0: model always wrong
# Create trainControl object: myControl
myControl <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary, # replace AUC for accuracy in metric
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)

# Train glm with custom trainControl: model
model <- train(Class ~ ., data = Sonar, method = "glm", trControl = myControl)


# Print model to console
model

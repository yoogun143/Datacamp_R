library(ggplot2)
library(caret)

#### OUT-OF-SAMPLE METRIC (RMSE) FOR REGRESSION
# Set seed
set.seed(42)

# Shuffle row indices: rows
rows <- sample(nrow(diamonds))

# Randomly order data
diamonds <- diamonds[rows,]

# Determine row to split on: split (80:20)
split <- round(nrow(diamonds) * .8)

# Create train
train <- diamonds[1:split,]

# Create test
test <- diamonds[(split + 1): nrow(diamonds), ]

# Fit lm model on train: model
model <- lm(price ~ ., data = train)

# Predict on test: p
p <- predict(model, test)

# Compute errors: error
error <- p - test$price

# Calculate RMSE
sqrt(mean(error^2))


#### CROSS-VALIDATION
# Fit lm model using 10-fold CV: model
model <- train(
  price ~ ., train,
  method = "lm",
  trControl = trainControl(
    method = "cv", number = 10,
    verboseIter = TRUE
  )
)

# Print model to console
model

# Predict on test: p
p <- predict(model, test)

# Compute errors: error
error <- p - test$price

# Calculate RMSE
sqrt(mean(error^2))

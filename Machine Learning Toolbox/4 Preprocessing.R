setwd("E:/Datacamp/R/Machine Learning Toolbox")
load('BreastCancer.RData')
load('BloodBrain.RData')

# Create custom trainControl: myControl
myControl <- trainControl(
  method = "cv", number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)


#### MEDIAN IMPUTATION (for missing at random)
# Apply median imputation: model
model <- train(
  x = breast_cancer_x, y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "medianImpute"
)

# Print model to console
model


#### KNN IMPUTATION (for missing not at random)
# Apply KNN imputation: model2
model2 <- train(
  x = breast_cancer_x, y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "knnImpute"
)

# Print model to console
model2


#### MORE PREPROCESSING
# Start with median imputation (Try KNN imputation if data missing not at random)
# For linear models: center and scale, try PCA and spatial sign
# Tree-based models don't need much preprocessing
# Fit glm with median imputation and standardization: model2
model2 <- train(
  x = breast_cancer_x, y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = c("medianImpute", "center", "scale", 'pca')
)

# Print model2
model2


# REMOVE NEAR ZERO VARIANCE PREDICTORS
# the dataset contains many variables and many of these variables have extemely low variances => little info because mostly consist of a single value
# Method 1: use function: Identify near zero variance predictors: remove_cols
remove_cols <- nearZeroVar(bloodbrain_x, names = TRUE, 
                           freqCut = 2, uniqueCut = 20)

# Get all column names from bloodbrain_x: all_cols
all_cols <- names(bloodbrain_x)

# Remove from data: bloodbrain_x_small
bloodbrain_x_small <- bloodbrain_x[ , setdiff(all_cols, remove_cols)]

# Method2: Remove near zero value in preprocessing
# Fit model on reduced data: model
model <- train(x = bloodbrain_x, y = bloodbrain_y, method = "glm",
               preProcess = c('nzv'))

# Print model to console
model


#### ALTERNATIVE TO NEARZEROVAR(): PCA
# more preferable because it does not throw out all data
# many different low variance predictors may end up combined into one high variance PCA variable
# Fit glm model using PCA: model
model <- train(
  x = bloodbrain_x, y = bloodbrain_y,
  method = "glm", preProcess = "pca"
)

# Print model to console
model

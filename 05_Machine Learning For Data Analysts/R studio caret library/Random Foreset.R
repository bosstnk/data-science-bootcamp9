library(tidyverse)
library(caret)
library(mlbench)

################################################################################

# Set Threshold

## Load data & Skip split data
data("PimaIndiansDiabetes")
df <- PimaIndiansDiabetes
mean(complete.cases(df))

################################################################################

## random forest (bagging)
## I like the most
## RPART
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE
)

tree_model <- train(
  diabetes ~ .,
  data = df,
  method = "rpart",
  metric = "Accuracy",
  trControl = ctrl
)

## Random Forest
rf_model <- train(
  diabetes ~ .,
  data = df,
  method = "rf", 
  metric = "Accuracy",
  tuneGrid = data.frame(mtry = c(2,3,4)),
  trControl = ctrl
)

tree_model
rf_model

## RF > Decision Tree 95%

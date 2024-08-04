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

## Ridge vs. Lasso Regression
## Regularization 
## Ridge => beta will be lower, but not zero
## Lasso => beta can be zero (feature selection)

glmnet_model <- train(
  diabetes ~ .,
  data = df,
  method = "glmnet", 
  metric = "Accuracy",
  tuneGrid = expand.grid(
    alpha = 0:1,
    lambda = c(0.004, 0.04, 0.08) # or lambda = seq(0.0001, 1, length=20)
  ),
  trControl = ctrl
)

glmnet_model

## save model
saveRDS(glmnet_model, "ridge_lasso_reg.RDS")
model <- readRDS("ridge_lasso_reg.RDS")

###############################################################################

# install.packages(c("tidyverse", "caret"))

library(tidyverse)
library(caret)

################################################################################

## preview data
head(mtcars)

################################################################################

## 1. split data
train_test_split <- function(data, size=0.8) {
  set.seed(42)
  n <- nrow(data)
  train_id <- sample(1:n, size*n)
  train_df <- data[train_id, ]
  test_df <- data[-train_id, ]
  return( list(train_df, test_df) )
}

prep_df <- train_test_split(mtcars, size=0.8)
prep_df

################################################################################

# ## 2. train model
# # Bootstrapped (Default of train function)
# model <- train(mpg ~ hp + wt + am,
#                data = prep_df[[1]],
#                method = "lm")
# model

## 2. train model
## cv stands for K-Fold CV
ctrl <- trainControl(method = "cv",
                     number = 5)

model <- train(mpg ~ hp + wt + am,
               data = prep_df[[1]],
               method = "lm", # Method = for change ML model
               trControl = ctrl)
model


################################################################################

## 3. score model
pred_mpg <- predict(model, newdata= prep_df[[2]])
pred_mpg

################################################################################

## 4. evaluate model
actual_mpg <- prep_df[[2]]$mpg

## error = actual - prediction
(test_mae <- mean(abs(pred_mpg - actual_mpg))) # Better for use
(test_rmse <- sqrt(mean((pred_mpg - actual_mpg)**2)))

print(test_mae)
MAE(pred_mpg, actual_mpg)

print(test_rmse)
RMSE(pred_mpg, actual_mpg)

################################################################################

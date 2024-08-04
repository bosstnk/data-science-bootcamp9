## find the best hyperparameter that improve model performance

# install.packages(c("tidyverse", "caret", "mlbench"))

library(tidyverse)
library(caret)
library(mlbench)

#############################################################################

# from mlbench
data("BostonHousing")
data("PimaIndiansDiabetes")

#############################################################################

## Clean data
clean_df <- mtcars %>% 
  select(mpg, hp, wt, am) %>%
  ## mean imputation
  mutate(hp = replace_na(hp, mean(mtcars$hp)),
         wt = replace_na(wt, mean(mtcars$wt))) %>%
  # drop NA column other than hp and wt
  # rule of thumb: NA < 3-5% -- can drop NA
  drop_na() 

#############################################################################

# review train

## linear regression
set.seed(42)
(lm_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "lm"
))

## knn: k-nearest neighbors
set.seed(42)
(knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn"
))

# Decision tree
set.seed(42)
(knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "rpart",
  metric = "RMSE"
))

#############################################################################

# Hyper parameter tuning
# setting metric for find the best k

set.seed(42)
(knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "RMSE"
))

set.seed(42)
(knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "MAE"
))

set.seed(42)
(knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "Rsquared" # for statistics research
))

#############################################################################

# Train model with K-Fold CV
## knn: k-nearest neighbors

set.seed(42)

ctrl <- trainControl(
  method = "cv",
  number = 3,
  verboseIter = TRUE # progress bar
)

# train model
knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl
)

#############################################################################

# Train model with K-Fold CV and Grid Search CV
## knn: k-nearest neighbors

set.seed(42)

## grid search (dataframe)
k_grid <- data.frame(k = c(3,9))

# # หรือใช้ Expand.grid แทนได้
# k_grid <- expand.grid(k = 1:10)

ctrl <- trainControl(
  method = "cv",
  number = 3,
  verboseIter = TRUE # progress bar
)

# train model
knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneGrid = k_grid
)

#############################################################################

# Train model with K-Fold CV and Random Search CV
## knn: k-nearest neighbors

set.seed(42)

ctrl <- trainControl(
  method = "cv",
  number = 3,
  verboseIter = TRUE # progress bar
)

## random k, 4 values
knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneLength = 2
)

#############################################################################

# Train model with Repeated CV and Grid Search CV
## knn: k-nearest neighbors

set.seed(42)

## grid search (dataframe)
k_grid <- data.frame(k = c(3,9))

ctrl <- trainControl(
  method = "repeatedcv",
  number = 3,
  repeats = 5,
  verboseIter = TRUE # progress bar
)

# train model
knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneGrid = k_grid
)

#############################################################################

## save model
## .RDS extension
saveRDS(knn_model, "knnModel.RDS")

## read model
knn_model_load <- readRDS("knnModel.RDS")

#############################################################################

## normalization
## 1. min-max (feature scaling 0-1)
## 2. standardization -3,+3

x <- c(5, 10, 12, 15, 20)

minmaxNorm <- function(x) {
  (x-min(x)) / ( max(x)-min(x) )
}

# center and scale
# standardization
zNorm <- function(x) {
  (x-mean(x)) / sd(x)
}

#############################################################################

## preProcess() -- Min-max Normalization
train_df <- mtcars[1:20, ]
test_df <- mtcars[21:32, ]

## Create transformer for compute min, max from train data
transformer <- preProcess(train_df,
                          method=c("range"))

train_df_z <- predict(transformer, train_df)
test_df_z <- predict(transformer, test_df)

################################

## preProcess() -- Z Normalization
train_df <- mtcars[1:20, ]
test_df <- mtcars[21:32, ]

## Create transformer for compute x_bar, x_sd from train data
transformer <- preProcess(train_df,
                          method=c("center","scale"))

train_df_z <- predict(transformer, train_df)
test_df_z <- predict(transformer, test_df)

#############################################################################

# install.packages(c("tidyverse", "caret"))

library(tidyverse)
library(caret)

################################################################################

churn_data <- read_csv("data/churn.csv")

## preview data
head(churn_data)

################################################################################

# prepare data
churn_data$churn <- factor(churn_data$churn)

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

prep_df <- train_test_split(churn_data, size=0.8)
prep_df

################################################################################

colnames(churn_data)

## 2. train model
## cv stands for K-Fold CV
ctrl <- trainControl(method = "cv",
                     number = 5)

model <- train(churn ~ accountlength + 
                 voicemailplan + 
                 internationalplan + 
                 totaldayminutes +
                 totalintlminutes +
                 numbercustomerservicecalls,
               data = prep_df[[1]],
               method = "glm", # Method = for change ML model
               trControl = ctrl)
model


################################################################################

## 3. score model
pred_churn <- predict(model, newdata= prep_df[[2]])
pred_churn

################################################################################

## 4. evaluate model
actual_churn <- prep_df[[2]]$churn

# Confusion Matrix method 1
conM <- table(pred_churn, actual_churn, 
              dnn=c("Predicted", "Actual"))
conM

cat("Accuracy:", (conM[1,1] + conM[2,2]) / sum(conM))
cat("Precision:", conM[2,2] / (conM[2,1] + conM[2,2]))
cat("Recall:", conM[2,2] / (conM[1,2] + conM[2,2]))
cat("F1-score:", 2*0.9*0.9/(0.9+0.9))

# Confusion Matrix method 2
conM <- confusionMatrix(data=pred_churn, reference = actual_churn)
conM

################################################################################

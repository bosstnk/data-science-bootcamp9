## build ML to classify diabetes patients
## binary classification

library(tidyverse)
library(caret)
library(mlbench)
library(MLmetrics)

#############################################################################

## load dataset
data("PimaIndiansDiabetes")
df <- PimaIndiansDiabetes

#############################################################################

## explore dataset
glimpse(df)

## no missing value
mean(complete.cases(df)) 

#############################################################################

# Check Correlation of x with y
df %>%
  group_by((diabetes)) %>%
  summarise(mean(age),
            mean(mass),
            mean(insulin),
            mean(glucose)) %>%
  t()

#############################################################################

## select variables
df_starter <- df %>%
  select(2,5,6,8,diabetes)

#############################################################################

## 1. split data
set.seed(42)
n <- nrow(df_starter)
id <- sample(1:n, size = 0.8*n)
train_df <- df_starter[id, ]
test_df <- df_starter[-id, ]

#############################################################################

## 2. train 

set.seed(42)

## use for Recall, Precision, F1, AUC
ctrl <- trainControl(method="cv", 
                     number=5,
                     ## pr = precision + recall
                     summaryFunction = prSummary,
                     classProbs = TRUE)

knn_model <- train(diabetes ~ .,
                     data = train_df,
                     method = "knn",
                     metric = "AUC",
                     trControl = ctrl)

knn_model

#############################################################################

## 3. scoring
p <- predict(knn_model, newdata = test_df)

#############################################################################

## 4. evaluate
mean(p == test_df$diabetes)

## confusion matrix
table(test_df$diabetes, p, dnn=c("actual", "predict"))

## confusion matrix
confusionMatrix(p, 
                test_df$diabetes, 
                positive="pos", # can change to neg class
                mode="prec_recall")

mean(test_df$diabetes == "neg")

# # Statistics Evaluate
# confusionMatrix(p, 
#                 test_df$diabetes, 
#                 positive="pos")

#############################################################################

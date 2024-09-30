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

## train model by "rpart"
## recursive partitioning (decision tree)

ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE,
  classProbs = TRUE, # we can change threshold 0.5
  summaryFunction = twoClassSummary
)

tree_model <- train(
  diabetes ~ glucose + pressure + insulin + mass + age,
  data = df,
  method = "rpart",
  metric = "ROC",
  trControl = ctrl
)

# try to print result
predict(tree_model, df, type = "prob")[1:10, ]

## prediction
## change threshold
probs <- predict(tree_model, df, type = "prob")
(p_class <- ifelse(probs$pos >= 0.5, "pos", "neg"))

table(df$diabetes, p_class)

################################################################################

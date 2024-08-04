library(tidyverse)
library(caret)
library(MLmetrics)
library(corrplot)

churn_df <- read_csv("data/churn.csv")
## explore dataset
glimpse(churn_df)

## no missing value
mean(complete.cases(churn_df))

colnames(churn_df)

# prepare data
churn_df$churn <- factor(churn_df$churn)

# Check Correlation x and y for numerical number
churn_df %>%
  group_by((churn)) %>%
  summarise(mean(accountlength),
            mean(numbervmailmessages),
            mean(totaldayminutes),
            mean(totaldaycalls),
            mean(totaleveminutes),
            mean(totalevecalls),
            mean(totalnightminutes),
            mean(totalnightcalls),
            mean(totalintlminutes),
            mean(totalintlcalls),
            mean(numbercustomerservicecalls),
            ) %>%
  t()
#international plan
churn_df %>%
  group_by(internationalplan, churn) %>%
  summarise(count = n()) %>%
  mutate(percent = round(count/sum(count)*100, 1))

ggplot(churn_df, aes(internationalplan, fill=churn)) +
  geom_bar(position="fill") + 
  theme_minimal()
  
#voicemail plan
churn_df %>%
  group_by(voicemailplan, churn) %>%
  summarise(count = n()) %>%
  mutate(percent = round(count/sum(count)*100, 1))

ggplot(churn_df, aes(voicemailplan, fill=churn)) +
  geom_bar(position="fill") + 
  theme_minimal()
  
## select variables
churn_select <- churn_df %>%
  select(
    internationalplan,
    numbervmailmessages,
    totaldayminutes,
    totaleveminutes,
    totalnightminutes,
    numbercustomerservicecalls,
    churn
  )

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

prep_df <- train_test_split(churn_select, size=0.8)
prep_df

## Min-max Normalization
## Create transformer for compute min, max from train data
transformer <- preProcess(prep_df[[1]],
                          method=c("range"))

train_norm <- predict(transformer, prep_df[[1]])
test_norm <- predict(transformer, prep_df[[2]])

################################################################################

## 2. train model

set.seed(42)

ctrl <- trainControl(
  method = "cv",
  number = 5,
  summaryFunction = prSummary,
  classProbs = TRUE
)

model <- train(churn ~ .,
               data = train_norm,
               method = "knn",
               metric = "AUC",
               trControl = ctrl)
model

################################################################################

## 3. score model
pred_train <- predict(model, newdata= train_norm)
pred_test <- predict(model, newdata= test_norm)

################################################################################

## 4. evaluate model
actual_train <- train_norm$churn
actual_test <- test_norm$churn

# Check Overfitting
mean(pred_train == actual_train)
mean(pred_test == actual_test)

# Confusion Matrix method 2
conM <- confusionMatrix(data=pred_test, 
                        reference = actual_test, 
                        positive="Yes",
                        mode="prec_recall")
conM

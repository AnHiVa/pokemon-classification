library(tidyverse)
library(caret)
library(corrplot)
library(rpart)
library(rpart.plot)
library(rattle)
library(randomForest)
library(randomForestExplainer)

df <- read_csv('pokedex_(Update_05.20).csv')

df_small <- df %>%
  select(status,hp, attack,
         defense, sp_attack, sp_defense,
         speed,base_experience) %>%
  mutate(status = as.factor(status)) %>%
  group_by(status) %>%
  mutate( base_experience = replace_na(base_experience, 20))

set.seed(745)

dset <- createDataPartition(y = df_small$status, p = 0.7, list = FALSE)
training <- df_small[dset, ]
test <- df_small[-dset, ]


training %>%
  group_by(status) %>%
  count(status)


corrplot(cor(select(ungroup(training), -c(status))), 
         method = "color", title = 'Stats Correlation Graph')

#decision tree
set.seed(7818)

model_dt <- rpart(status~., data = training, method = 'class')
pred_dt <- predict(model_dt, test, type = 'class')

confusionMatrix(pred_dt, test$status)
fancyRpartPlot(model_dt)

#random forest
set.seed(7818)

model_rf <- randomForest(status~., data = training, localImp = TRUE)
pred_rf <- predict(model_rf, test)

confusionMatrix(pred_rf, test$status) 

## explain_forest(model_rf, interactions = TRUE, data = training) #Run for Forest Explanation
 
#Random Forest is selected, sample error 2.94%


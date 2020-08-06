library(tidyverse)
library(caret)
library(corrplot)
library(rpart)
library(rpart.plot)
library(rattle)
library(randomForest)
library(randomForestExplainer)

# Kaggle url of dataset used  https://www.kaggle.com/mariotormo/complete-pokemon-dataset-updated-090420

## download.file('https://www.kaggle.com/mariotormo/complete-pokemon-dataset-updated-090420/download', '593561_1119602_bundle_archive.zip', method = 'curl')
## unzip('593561_1119602_bundle_archive')

df <- read_csv('pokedex_(Update_05.20).csv')

# clean data for analisis 
df_small <- df %>%
  select(status,hp, attack,
         defense, sp_attack, sp_defense,
         speed,base_experience) %>%
  mutate(status = as.factor(status)) %>%
  group_by(status) %>%
  mutate( base_experience = replace_na(base_experience, 20))


set.seed(745) #For reproducibility 

#Create training and testing sets
dset <- createDataPartition(y = df_small$status, p = 0.7, list = FALSE)
training <- df_small[dset, ]
test <- df_small[-dset, ]

#Check the count of our value of interest
training %>%
  group_by(status) %>%
  count(status)

#Correlation Plot
corrplot(cor(select(ungroup(training), -c(status))), 
         method = "color", title = 'Stats Correlation Graph')

#decision tree
set.seed(7818) #For reproducibility

model_dt <- rpart(status~., data = training, method = 'class')
pred_dt <- predict(model_dt, test, type = 'class')

confusionMatrix(pred_dt, test$status)
fancyRpartPlot(model_dt)

#random forest
set.seed(7818) # For reproducibility

model_rf <- randomForest(status~., data = training, localImp = TRUE)
pred_rf <- predict(model_rf, test)

confusionMatrix(pred_rf, test$status) 

## explain_forest(model_rf, interactions = TRUE, data = training) #Run for Forest Explanation
 
#Random Forest is selected, sample error 2.94%


library(tidyverse)
library(caret)
library(randomForest)

df <- read_csv('data/pokedex_(Update_05.20).csv')

# clean data for modeling 
df_small <- df %>%
  select(status,hp, attack,
         defense, sp_attack, sp_defense,
         speed,base_experience) %>%
  mutate(status = as.factor(status)) %>%
  group_by(status) %>%
  mutate( base_experience = replace_na(base_experience, 20))


set.seed(745) #For reproducibility 

#Create training set
dset <- createDataPartition(y = df_small$status, p = 0.7, list = FALSE)
training <- df_small[dset, ]

#random forest model 
set.seed(7818) # For reproducibility

model_rf <- randomForest(status~., data = training, localImp = TRUE)


# Pokémon Classifier
Classifies a Pokémon by its stats combination. 
Done for the Data Products Coursera course. 

The dataset was downloaded from Mario Tormo Romero’s [Kaggle page](https://www.kaggle.com/mariotormo/complete-pokemon-dataset-updated-090420)

[Shiny app](https://anhiva.shinyapps.io/pokemon-classifier/)

[Coursera presentation](https://anhiva.github.io/pokemon-classification/#1)

# Goal
The Goal of the project is to classify a Pokémon in
- Normal
- Sub Legendary
- Mythical
- Legendary
Depending on a combination of stats.

# Data preparation
The variables needed are the Pokémon *stats*, therefore the data was filtered appropiately.


|status | hp| attack| defense| sp_attack| sp_defense| speed| base_experience|
|:------|--:|------:|-------:|---------:|----------:|-----:|---------------:|
|Normal | 45|     49|      49|        65|         65|    45|              64|
|Normal | 60|     62|      63|        80|         80|    60|             142|
|Normal | 80|     82|      83|       100|        100|    80|             236|
|Normal | 80|    100|     123|       122|        120|    80|             281|
|Normal | 39|     52|      43|        60|         50|    65|              62|

Then, the dataset was divided into a training and test set.

**Training Set**

|status        |   n|
|:-------------|---:|
|Legendary     |  28|
|Mythical      |  21|
|Normal        | 641|
|Sub Legendary |  32|

**Correlation Graph**

![correlation](https://github.com/AnHiVa/pokemon-classification/blob/master/correlation.png)

# Model Fitting

## Decision Tree
First, a decision tree model was fitted

**Decision Tree**
![decisiontree](https://github.com/AnHiVa/pokemon-classification/blob/master/decisiontree.png)

|              | Legendary| Mythical| Normal| Sub Legendary|
|:-------------|---------:|--------:|------:|-------------:|
|Legendary     |         9|        0|      2|             1|
|Mythical      |         0|        5|      2|             1|
|Normal        |         2|        1|    269|             0|
|Sub Legendary |         0|        2|      1|            11|

|               |         x|
|:--------------|---------:|
|Accuracy       | 0.9607843|
|Kappa          | 0.8039509|
|AccuracyLower  | 0.9325006|
|AccuracyUpper  | 0.9795753|
|AccuracyNull   | 0.8954248|
|AccuracyPValue | 0.0000229|
|McnemarPValue  |       NaN|

*Accuracy 96.08%, 95% CI (0.9325, 0.9796), sample error of 3.92%*

## Random Forest 
A random forest model was fitted.

|              | Legendary| Mythical| Normal| Sub Legendary|
|:-------------|---------:|--------:|------:|-------------:|
|Legendary     |        11|        0|      1|             1|
|Mythical      |         0|        3|      0|             1|
|Normal        |         0|        2|    272|             0|
|Sub Legendary |         0|        3|      1|            11|

|               |         x|
|:--------------|---------:|
|Accuracy       | 0.9705882|
|Kappa          | 0.8485981|
|AccuracyLower  | 0.9449034|
|AccuracyUpper  | 0.9864647|
|AccuracyNull   | 0.8954248|
|AccuracyPValue | 0.0000006|
|McnemarPValue  |       NaN|

*97.06% accuracy, 95% CI (0.9449, 0.9865), 2.94% sample error*

The Random Forest Explanation can be viewed by downloading this [html file](https://github.com/AnHiVa/pokemon-classification/blob/master/Your_forest_explained.html)

# Conclusion
Random forest model was selected for the [final app](https://anhiva.shinyapps.io/pokemon-classifier/), deployed with Shiny Apps. 

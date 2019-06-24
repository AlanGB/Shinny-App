Predicting Stopping Distances of Cars
========================================================
author: "Alán García Bernal"
date: 23/06/2019
autosize: true
transition: rotate

General Information
========================================================

The current Shiny Webb App uses the R dataset 'cars' (for more information on the data set  follow this link: https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/cars.html).


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

to create and plot 2 linear models with regression to the origin:
- Model A: lm(dist ~ speed -1, data = cars)
- Model B: lm(dist ~ speedsp + speed - 1, data = cars)

Inputs
========================================================

This App takes 3 different inputs:

- **Slider Input**: between 1 and 25 that determines the miles per hour used to predict the stopping distance.

- **Checkbox 1**: to determine if the Model A line will be visible.

- **Checkbox 2**: to determine if the Model B line will be visible.

Outputs
========================================================

- **Plot A**: a scatter plot with 'speed' in the x-axis and 'stopping distance' in the y-axis. It shows (if the user decides so) the lines for Models A and/or B and the difned point for making the predictions.

- **Predicted Stopping Distance for Model A**: the predicted stopping distance for the specified speed according to Model A (see example below).


```r
data(cars)
modelA <- lm(dist ~ speed - 1, data = cars)
predict(modelA, newdata = data.frame(speed = 20))
```

```
       1 
58.18264 
```

- **Predicted Stopping Distance for Model B**: the predicted stopping distance for the specified speed according to Model B (see example below).


```r
cars$speedsp <- ifelse(cars$speed - 19 > 0, cars$speed -19, 0)
modelB <- lm(dist ~ speedsp + speed - 1, data = cars)
predict(modelB, newdata = data.frame(speed = 19, speedsp = 0))
```

```
       1 
49.66642 
```

Plot
========================================================
This is an example of the plot produced by the App:

![plot of chunk plots](Predicting Stopping Distances of Cars-figure/plots-1.png)

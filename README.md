# Regression Analysis on Daily Arrivals to Italy and Greece

This repository contains R code for analyzing the daily arrivals of immigrants to Italy and Greece, and the impact of the COVID-19 pandemic on these arrivals. The code uses polynomial regression to model the relationship between arrivals and time, and compares the results for the pre-COVID-19 and post-COVID-19 periods.

## Data Preprocessing

The code begins by importing the necessary libraries: readxl for reading Excel files, and ggplot2 for plotting. The dataset is then loaded from two Excel files: dataset.xlsx and datasetprecovid19.xlsx. The arrival data for Italy and Greece is extracted from the datasets, and the log of the arrival data is calculated to account for non-normality.

## Polynomial Regression Analysis

Polynomial regression is used to model the relationship between the log of arrivals and time, both for the pre-COVID-19 and post-COVID-19 periods. The following polynomial regression models are considered:

* Linear regression (model 1): `log(arrivals) ~ time`
* Quadratic regression (model 2): `log(arrivals) ~ time + I(time^2)`
* Cubic regression (model 3): `log(arrivals) ~ time + I(time^2) + I(time^3)`

The coefficients of each model are estimated using the `lm()` function, and the fitted values are plotted alongside the actual log(arrivals) data. The R-squared values are also reported to assess the goodness-of-fit of each model.

## Results and Interpretation

The results of the polynomial regression analysis show that the quadratic regression (model 2) provides the best fit for the pre-COVID-19 and post-COVID-19 periods. This suggests that the relationship between arrivals and time is non-linear, and that the quadratic model captures this non-linearity better than the linear or cubic models.

The COVID-19 pandemic had a significant impact on immigrants arrivals to Italy and Greece, as evidenced by the sharp decline in arrivals after the pandemic began. The polynomial regression models reveal that the impact of the pandemic was more pronounced in Greece than in Italy, we can also assume that the major feature influencing this trend is not the covid19.

## Conclusion

This analysis provides valuable insights into the factors influencing immigrants arrivals to Italy and Greece, and the impact of the COVID-19 pandemic on these arrivals. 


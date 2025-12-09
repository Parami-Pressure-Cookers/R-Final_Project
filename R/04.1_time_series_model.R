library(tidyverse)
library(lubridate)
library(forecast)
library(tseries)

all_sales_2019 <- read_csv("data/processed/all_sales_2019_v2.csv")

# Aggregate sales by day
daily_sales <- all_sales_2019 %>%
  mutate(Date = as.Date(OrderDateTime)) %>% # Date format
  group_by(Date) %>%
  summarize(TotalSales = sum(TotalSales)) %>%
  arrange(Date) # data is ordered chronologically

# create a Time Series Object
# use frequency = 7 >>> weekly seasonality
sales_ts <- ts(daily_sales$TotalSales, frequency = 7)

# analyze Differencing
sales_diff <- diff(sales_ts2)
# we look at the Differenced data (Day 2 - Day 1)


# Plot ACF and PACF
ggtsdisplay(sales_diff, main="ACF & PACF of Differenced Sales")



# MODEL BUILDING
## Model A: (ARIMA 0,1,1)
model_a <- Arima(sales_ts2, order = c(0,1,1))

## Model B: (ARIMA 1,1,1)
model_b <- Arima(sales_ts2, order = c(1,1,1))
# checks if yesterday's sales value directly predicts today's


## Model C: (SARIMA 1,1,1)(1,0,0)[7]
model_c <- Arima(sales_ts2, 
                 order = c(1,1,1), 
                 seasonal = list(order = c(1,1,1), period = 7))
# looks for a 7-day (weekly) pattern

# Compare Models
cat("AIC Comparison (Lower is Better):\n")
cat("Model A (0,1,1):", AIC(model_a), "\n")
cat("Model B (1,1,1):", AIC(model_b), "\n")
cat("Model C (Seasonal):", AIC(model_c), "\n")


# Visual Comparison of Forecasts
autoplot(sales_ts2) +
  autolayer(forecast(model_a, h=30), series="Model A (0,1,1)", PI=FALSE) +
  autolayer(forecast(model_b, h=30), series="Model B (1,1,1)", PI=FALSE) +
  autolayer(forecast(model_c, h=30), series="Model C (Seasonal)", PI=FALSE) +
  labs(title = "Comparing Straight Line vs. Seasonal Forecasts",
       y = "Daily Sales ($)") +
  theme_minimal()

# visualization with the uncertainty
autoplot(sales_ts2) +
  autolayer(forecast(model_c, h=30), series="Model C (Seasonal)", PI=TRUE) +
  labs(title = "Comparing Straight Line vs. Seasonal Forecasts",
       y = "Daily Sales ($)") +
  theme_minimal()




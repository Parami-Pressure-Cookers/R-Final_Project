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

# check for adf test
print(adf.test(sales_ts))

# Fit the ARIMA Model
arima_model <- auto.arima(sales_ts, seasonal = TRUE)

# print Model Summary
print(summary(arima_model))

# check residuals
checkresiduals(arima_model)

# forecast future sales (Next 30 Days)
sales_forecast <- forecast(arima_model, h = 30)

# visualization
autoplot(sales_forecast) +
  labs(title = "Daily Sales Forecast (ARIMA)",
       x = "Time (Weeks)",
       y = "Total Sales ($)") +
  theme_minimal()

# visualization without the purple shade
autoplot(sales_forecast, PI = FALSE) +
  geom_line(color = "red", size = 1.5)




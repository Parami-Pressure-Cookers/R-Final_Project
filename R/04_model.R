library(tidyverse)
library(lubridate)


all_sales_2019 <- read_csv("data/processed/all_sales_2019_v2.csv")

# 1. Prepare Data: Aggregate sales by day
daily_sales <- all_sales_2019 %>%
  mutate(Date = as.Date(OrderDateTime, format = "%m/%d/%y %H:%M")) %>%
  group_by(Date) %>%
  summarize(TotalSales = sum(QuantityOrdered * PriceEach)) %>%
  mutate(DayIndex = as.numeric(Date - min(Date) + 1)) # Create a numeric time variable

# 2. Build Linear Model (Simple Linear Regression)
# Model: TotalSales = Intercept + Slope * DayIndex
sales_model <- lm(TotalSales ~ DayIndex, data = daily_sales)

# 3. Model Evaluation
model_summary <- summary(sales_model)
print(model_summary)

# Extract R-squared to see how well the date explains sales variance
r_squared <- model_summary$r.squared
cat("R-squared:", r_squared, "\n")

# 4. Visualization with Regression Line
ggplot(daily_sales, aes(x = Date, y = TotalSales)) +
  geom_point(alpha = 0.5, color = "navyblue") +      # Scatter plot of actual data
  geom_smooth(method = "lm", color = "red") +    # The regression line
  labs(title = "Daily Sales Trend (2019)",
       subtitle = paste("R-squared:", round(r_squared, 4)),
       x = "Date",
       y = "Total Sales ($)") +
  theme_minimal()

ggsave("outputs/figures/sales_trend_regression.png")

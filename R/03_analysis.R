library(readr)
library(ggplot2)
library(dplyr)
library(scales)


# You can clean the environment as we are reading the data again.
all_sales_2019 <- read_csv("data/processed/all_sales_2019_v2.csv")

# Check data structure and Null Value.
head(all_sales_2019)
glimpse(all_sales_2019)

# Check Null Value
sum(is.na(all_sales_2019))


# Question 1: What was the best month for sales? How much was earned that month?
total_sales_each_month <- all_sales_2019 %>%
  group_by(Month) %>%
  summarize(TotalSales = sum(TotalSales)) %>%
  arrange(desc(TotalSales))

month_order = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

# ordering month for visual
total_sales_each_month <- total_sales_each_month %>%
  mutate(Month = factor(Month, levels = month_order))

vis_1 <- ggplot(total_sales_each_month, aes(x = Month, y = TotalSales)) +
  geom_col(fill = "#FFCD27") + 
  labs(title = "Total Sales by Month",
       x = "Month",
       y = "Total Sales")

vis_1 <- vis_1 + 
  geom_text(aes(label = scales::dollar(TotalSales, scale = 1/1e6, suffix = "M")),
            vjust = -0.5,
            size = 2.5) +
  scale_y_continuous(labels = scales::dollar_format(scale = 1/1e6, suffix = "M"))

print(vis_1)



best_month_for_sales <- total_sales_each_month %>%
  slice_max(TotalSales, n = 1)

cat("The best month for sales is", best_month_for_sales$Month, 
    "with the total sales of", 
    paste0("$", best_month_for_sales$TotalSales, "."),
    "\n")

# ============================================================

# Question 2: What city has the highest sales?

# glimpse(all_sales_2019)

total_sales_each_city <- all_sales_2019 %>%
  group_by(City) %>%
  summarize(TotalSales = sum(TotalSales)) %>%
  arrange(desc(TotalSales))


vis_2 <- ggplot(total_sales_each_city, aes(TotalSales, City)) +
  geom_col(fill = "#FFCD27")

vis_2 <- vis_2 + geom_text(aes(label = scales::dollar(TotalSales, scale = 1/1e6, suffix = "M")),
                   hjust = -0.2,
                   size = 2.5) +
  scale_x_continuous(label = scales::dollar_format(scale = 1/1e6, suffix = "M"),
                     expand = expansion(add = c(0, 1e6))) + 
  theme_minimal()

print(vis_2)

city_with_highest_sales <- total_sales_each_city %>%
  slice_max(TotalSales, n = 1)


cat("The city with highest sales is", city_with_highest_sales$City, 
    "with the total sales of", 
    paste0("$", city_with_highest_sales$TotalSales, "."),
    "\n")

# ============================================================

# Question 3: What time should we display advertisements to maximize likehood of customers buying products?

glimpse(all_sales_2019)

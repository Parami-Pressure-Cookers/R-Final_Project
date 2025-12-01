library(readr)
library(ggplot2)
library(dplyr)
library(scales)
library(forcats)


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

write_csv(total_sales_each_month, "outputs/tables/total_sales_each_month.csv")

month_order = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

# ordering month for visual
total_sales_each_month <- total_sales_each_month %>%
  mutate(Month = factor(Month, levels = month_order))

vis_1 <- ggplot(total_sales_each_month, aes(x = Month, y = TotalSales)) +
  geom_col() + 
  labs(title = "Total Sales by Month",
       x = "Month",
       y = "Total Sales in USD ($)")

vis_1 <- vis_1 + 
  geom_text(aes(label = scales::dollar(TotalSales, scale = 1/1e6, suffix = "M")),
            vjust = -0.5,
            size = 2.5) +
  scale_y_continuous(
    labels = scales::dollar_format(scale = 1/1e6, suffix = "M"),
    expand = expansion(add = c(0, 1e6))
    ) +
  theme_minimal()

ggsave("outputs/figures/total_sales_by_month.jpg", plot = vis_1)
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

write_csv(total_sales_each_city, "outputs/tables/total_sales_each_city.csv")

vis_2 <- ggplot(total_sales_each_city, aes(TotalSales, City)) +
  geom_col()

vis_2 <- vis_2 + 
  labs(
    title = "Total Sales per City",
    x = "Total Sales n USD ($)",
    y = "City Name"
  )+
  geom_text(aes(label = scales::dollar(TotalSales, scale = 1/1e6, suffix = "M")),
                   hjust = -0.2,
                   size = 2.5) +
  scale_x_continuous(
    label = scales::dollar_format(scale = 1/1e6, suffix = "M"),
     expand = expansion(add = c(0, 1e6))
    ) + 
  theme_minimal()

ggsave("outputs/figures/total_sales_per_city.jpg", plot = vis_2)
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

sales_by_hours <- all_sales_2019 %>%
  group_by(Hour) %>%
  summarize(TotalQuantitySales = sum(QuantityOrdered))

write_csv(sales_by_hours, "outputs/tables/sales_by_hours.csv")

vis_3 <- ggplot(sales_by_hours, aes(x = Hour, y = TotalQuantitySales)) +
  geom_line(size = 1) +
  labs(
    title = "Total Sales by Hours",
    y = "Total Sales in USD ($)",
    x = "Hour of the Day (24 Hrs)"
  ) +
  scale_x_continuous(breaks = seq(0, 24, by = 4)) +
  scale_y_continuous(breaks = seq(0, 17500, by = 2500)) +
  theme_minimal()

ggsave("outputs/figures/total_sales_by_hours.jpg", plot = vis_3)
print(vis_3)

# ===========================================================

# Question 4: What products are most often sold together?

duplicated_OrderID <- all_sales_2019 %>%
  group_by(OrderID) %>%
  filter(n() > 1) %>% 
  select(OrderID, Product) %>%
  ungroup()

products_sold_together <- duplicated_OrderID %>%
  group_by(OrderID) %>%
#  count(sort = TRUE) %>%
  summarize(ProductPairs = paste(sort(Product), collapse = ", ")) %>%
  ungroup()

products_sold_together_count <- products_sold_together %>%
  count(ProductPairs, sort = TRUE) %>%
  rename(TotalSales = n)

top_10_products_sold_together <- head(products_sold_together_count, n = 10)

print(top_10_products_sold_together)
write_csv(products_sold_together_count, "outputs/tables/products_sold_together.csv")

# ===========================================================

# Question 5: What product sold the most? Why do you think it sold the most?

single_product_sold <- all_sales_2019 %>%
  group_by(Product) %>%
  count(wt = QuantityOrdered, sort = TRUE) %>%
  rename(TotalUnitSold = n)

most_single_product_sold <- single_product_sold %>%
  head(1)


cat(paste0("The most sold product is ", most_single_product_sold$Product,
           " with the total sales of ", most_single_product_sold$TotalUnitSold,
           " items. \n"))

write_csv(single_product_sold, "outputs/tables/product_sales.csv")

vis_4 <- ggplot(single_product_sold, aes(TotalUnitSold, fct_reorder(Product, TotalUnitSold))) +
  geom_col() +
  labs(
    title = "Product Sales",
    x = "Number of Units Sold",
    y = "Product Name"
  ) +
  theme_minimal()

ggsave("outputs/figures/product_sales.jpg", plot = vis_4)
print(vis_4)


# ===========================================================


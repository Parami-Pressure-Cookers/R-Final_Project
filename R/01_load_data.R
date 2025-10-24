# install.packages("tidyverse")
library(tidyverse)

# loading each monthly sales
jan_sales <- read_csv("data/raw/2019-sales-monthly/201901-sales.csv")
head(jan_sales)

feb_sales <- read_csv("data/raw/2019-sales-monthly/201902-sales.csv")
head(feb_sales)

mar_sales <- read_csv("data/raw/2019-sales-monthly/201903-sales.csv")
head(mar_sales)

apr_sales <- read_csv("data/raw/2019-sales-monthly/201904-sales.csv")
head(apr_sales)

may_sales <- read_csv("data/raw/2019-sales-monthly/201905-sales.csv")
head(may_sales)

jun_sales <- read_csv("data/raw/2019-sales-monthly/201906-sales.csv")
head(jun_sales)

jul_sales <- read_csv("data/raw/2019-sales-monthly/201907-sales.csv")
head(jul_sales)

aug_sales <- read_csv("data/raw/2019-sales-monthly/201908-sales.csv")
head(aug_sales)

sep_sales <- read_csv("data/raw/2019-sales-monthly/201909-sales.csv")
head(sep_sales)

oct_sales <- read_csv("data/raw/2019-sales-monthly/201910-sales.csv")
head(oct_sales)

nov_sales <- read_csv("data/raw/2019-sales-monthly/201911-sales.csv")
head(nov_sales)

dec_sales <- read_csv("data/raw/2019-sales-monthly/201912-sales.csv")
head(dec_sales)

# combine the 12 months data using bind_rows
all_sales_2019_combine <- bind_rows(jan_sales, feb_sales, mar_sales,
                            apr_sales, may_sales, jun_sales,
                            jul_sales, aug_sales, sep_sales,
                            oct_sales, nov_sales, dec_sales)

head(all_sales_2019_combine)

# check the table info
glimpse(all_sales_2019_combine)

# Counts the number of missing cells (NA)
total_NA_cells <- sum(is.na(all_sales_2019_combine))
cat("Total no. of missing cells: ", total_NA_cells, "\n")

# Counts the number of rows with at least one NA
total_NA_rows <- sum(!complete.cases(all_sales_2019_combine))
cat("Total No. of missing rows: ", total_NA_rows, "\n")

# counting total no. of rows before dropping
row_before <- nrow(all_sales_2019_combine)
cat("Number of rows before dropping NA: ", row_before, "\n")

# dropping NA rows
all_sales_2019 <- drop_na(all_sales_2019_combine)
# counting total no. of rows after dropping
row_after <- nrow(all_sales_2019)

cat("Number of rows after dropping NA: ", row_after, "\n")

# if this match with the total no. of missing row, we can validate it
cat("No. of dropped rows: ", row_before - row_after)


all_sales_2019 <- all_sales_2019 %>%
  # this remove the no. of repeated header rows
  filter(`Order ID` != "Order ID") %>%
  mutate(
      OrderID = `Order ID`,
      QuantityOrdered = as.integer(`Quantity Ordered`),
      PriceEach = as.numeric(`Price Each`),
      OrderDate = `Order Date`,
      PurchaseAddress = `Purchase Address`
  ) %>%
  select(OrderID, Product, QuantityOrdered, PriceEach, OrderDate, PurchaseAddress)
                        
row_after_cleaning_repeated_header <- nrow(all_sales_2019)

cat("Total no. of repeated header rows that was dropped: ", row_after - row_after_cleaning_repeated_header)

glimpse(all_sales_2019)

write_csv(all_sales_2019, "data/processed/all_sales_2019.csv")

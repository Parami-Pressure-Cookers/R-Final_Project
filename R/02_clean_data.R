library(tidyverse)
library(tidyr)
library(stringr)
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
    PurchaseAddress = `Purchase Address`,
    ZIP = str_extract(PurchaseAddress, "\\d{5}$")
  ) %>%
  select(OrderID, Product, QuantityOrdered, PriceEach, OrderDate, PurchaseAddress, ZIP)

row_after_cleaning_repeated_header <- nrow(all_sales_2019)

cat("Total no. of repeated header rows that was dropped: ", row_after - row_after_cleaning_repeated_header)


glimpse(all_sales_2019)

write_csv(all_sales_2019, "data/processed/all_sales_2019.csv")


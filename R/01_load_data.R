# install.packages("readr")
library(readr)
library(dplyr)

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


all_sales_2019 <- bind_rows(jan_sales, feb_sales, mar_sales,
                            apr_sales, may_sales, jun_sales,
                            jul_sales, aug_sales, sep_sales,
                            oct_sales, nov_sales, dec_sales)

head(all_sales_2019)

glimpse(all_sales_2019)

str(all_sales_2019)

# R Final Project: Exploratory Data Analysis of a 2019 Sales Dataset

[Brief Summary Here]

---

![Pressure Cookers](data\pressure_cookers_cover_photo.jpg)


## Our Group Members
*Students from Parami University, CS 251-R*

| Name | GitHub Profile |
| --- | --- |
| Ei Phyu Sin Win   | [@cathcath-ryn](https://github.com/cathcath-ryn) |
| Htet Khant Linn   | [@Htet-Khant-Linn](https://github.com/Htet-Khant-Linn) |
| Khine Nwe Lin     | [@khinenwelynn](https://github.com/khinenwelynn) |
| Khant Razar Kyaw  | [@khantgit](https://github.com/khantgit)       |

---

## Description

This repository contains the final project for the **CS 251** course. We explored a [2019 sales dataset](data\raw\2019-sales-monthly) to uncover patterns, trends and relationships. The key questions we sought to answer were:

* **Question 1**: What was the best month for sales? How much was earned that month?
* **Question 2**: What city has the highest sales?
* **Question 3**: What time should we display advertisements to maximize likehood of customers buying products?
* **Question 4**: What products are most often sold together?
* **Question 5**: What product sold the most? Why do you think it sold the most?

The analysis was conducted entirely in **R**. We leveraged several key packages for data manipulation, analysis, and visualization.




## 📂 Repository Structure
```
R-Final_Project/

├── .gitignore
├── README.md
├── R-Final_Project.Rproj
├── R/
│   ├── 01_load_data.R
│   ├── 02_clean_data.R
│   ├── 03_analysis.R
│   └── 04_visualize.R
│  
│
├── data/
│   ├── raw/
│   │   └── 2019-sales-monthly
│   └── processed/
│       └── [will be updated]
│
├── outputs/
│   ├── figures/
│   │   └── [will be updated]
│   └── tables/
│       └── final_results.csv
│
└── reports/
    └── final_report.Rmd
```


## Dataset Details
This dataset consists of 12 separate CSV files, each containing detailed sales data for each month of the year 2019.
Data Retrived from -> [Original Repo](https://github.com/sinjoysaha/sales-analysis?tab=readme-ov-file#the-dataset)

**File Naming**: Files are organised by month, following the convention Sales_[Month]_2019.csv.

**Data Volume**: Each monthly file contains between 9,000 and 26,000 sales records.

**Schema**: Each record provides the following 6 data points for an order:
* Order ID
* Product
* Quantity Ordered
* Price Each
* Order Date
* Purchase Address




## 🛠️ Installation & Setup

To replicate this analysis, you'll need to have R and RStudio installed on your machine.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Parami-Pressure-Cookers/R-Final_Project.git
    ```
2.  **Open the project** in RStudio.
3.  **Install the required packages.** You can run the following command in the R console to install all necessary dependencies:
    ```R
    install.packages(c("tidyverse", "ggplot2", "dplyr"))
    ```
    *Note: Add or remove packages from this list based on what you actually used.*



## ✨ Key Findings

Here are a few of the main conclusions from our analysis:
[Will be updated soon]



## 🤝 Contributing

This was a final project for a course (**CS 251**), so we are not actively seeking contributions. However, if you have suggestions for improvement or find any bugs, feel free to open an issue!


## 📝 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.


## ⚠️ Disclaimer
The content in this repository is intended for the **R Final Project**. If you are a student in **CS 251**, please use this as a reference but do not copy the code. Thanks.

---
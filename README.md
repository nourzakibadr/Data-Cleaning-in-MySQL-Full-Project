# 🧹 Data Cleaning in SQL – Layoffs Dataset

## 📌 Overview

This project was developed as part of my **Data Analytics Bootcamp during the Summer Vacation**, where we focused on **SQL-based data cleaning techniques**. The project demonstrates how to clean and prepare real-world data for analysis using SQL..

## 📁 Dataset

The dataset used in this project contains information on tech company layoffs, including details like:

* Company name
* Location
* Industry
* Total laid off
* Percentage laid off
* Date of layoffs
* Stage of company
* Country
* Funds raised

## 🛠️ Objectives

The primary goal was to **clean the raw data** and prepare it for downstream analysis. The main cleaning tasks include:

1. **Removing Duplicates**
2. **Standardizing Text Fields**
3. **Handling Null or Blank Values**
4. **Removing Irrelevant Columns**
5. **Ensuring Consistent Date Formats**

## 📊 Key SQL Operations

* **Creating staging tables** to preserve raw data and work on duplicates.
* **Using `ROW_NUMBER()`** with `PARTITION BY` to identify and remove duplicates.
* **Trimming and standardizing** company, industry, and country names.
* **Converting date formats** from text to `DATE` type using `STR_TO_DATE()`.
* **Handling nulls** by referencing other rows with matching company names.
* **Final cleanup** by deleting rows with insufficient data and dropping helper columns.

## 🧾 Example Snippets

```sql
-- Identifying duplicates
ROW_NUMBER() OVER(
  PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`
) AS row_num

-- Standardizing text
UPDATE layoffs_staging_2
SET company = TRIM(company);

-- Converting date format
UPDATE layoffs_staging_2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
```

## ✅ Outcome

By the end of the process, a **clean and analysis-ready version** of the layoffs dataset was created in `layoffs_staging_2`. This cleaned data can now be used for meaningful visualizations or further statistical exploration.

## 📚 Skills Gained :)

* SQL data wrangling
* Use of window functions
* Data profiling and standardization
* Working with dates and null values
* Real-world project structuring and documentation

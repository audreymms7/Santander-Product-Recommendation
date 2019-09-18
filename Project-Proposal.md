  
# Capstone Project - Santander Product Recommendation

## Problem Statement 

To support needs for a range of financial decisions, Santander Bank offers a lending hand to their customers through personalized product recommendations. Under their current system, a small number of Santander’s customers receive many recommendations while many others rarely see any, resulting in poor customer experience.

The project aims to assist the bank to predict which products their existing customers will use in the next month based on their past behaviors and product ownerships. The goal of this project is to take Santander Bank customer information between January 2015 and May 2016, understand client behaviours and to design a solution to predict which financial service products they are likely to purchase in the next month. With a more effective recommendation system in place, Santander can better meet their client’s needs, provide better client experience with more personalised product recommendations.

## Data 
Data is available on [Kaggle competition page](https://www.kaggle.com/c/santander-product-recommendation/data).
This project mainly uses train dataset, which includes 13 millions rows of customer bahaviour data, split by month.

## Approach 
* Exploratory data analysis
* Feature engineering - 46 variables are in the dataset and most of them are categorical. There might be a need to select valuable features, regroup variables to form new features and convert variables to other types. 
* Predictive model: KNN, Decision Tree, Random Forest

## Deliverables 
* R markdown report that includes detailed data exploratory analysis, executive summary and recommendation.
* R code

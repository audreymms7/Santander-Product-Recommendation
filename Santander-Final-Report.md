![image Santander](v2-c3f8056348b2ce53c9455da5936b0679_1200x500.jpg)
# Santander Product Recommendation

Audrey Meng
Sept. 22 2019




### Part 1 - Project Goals

To support needs for a range of financial decisions, Santander Bank offers a lending hand to their customers through personalized product recommendations. Under their current system, a small number of Santander’s customers receive many recommendations while many others rarely see any, resulting in poor customer experience.

The project aims to assist the bank to predict which products their existing customers will use in the next month based on their past behaviors and product ownerships. The goal of this project is to take Santander Bank customer information between January 2015 and May 2016, understand client behaviours and to design a solution to predict which financial service products they are likely to purchase in the next month. With a more effective recommendation system in place, Santander can better meet their client’s needs, provide better client experience with more personalised product recommendations.

Data used in this project is available on [Kaggle](https://www.kaggle.com/c/santander-product-recommendation/data). This project mainly uses train dataset, which includes 13 millions rows of customer bahaviour data, split by month.


### Part 2 - Recommendations



### Part 3 - Data First Glance


#### 3.1 First Glance

#### 3.2 Data Wrangling

Multiple data cleaning steps have to be conducted to the original dataset before I can perfrom any analysis and extract any valuable insights from it. 

Several variables contain missing values. Some of them can be simply imputed with more frequent status or median value, while others are more complicated. For example, I find out `renta` (gross income) has abundance of missing values and varies greatly across different province, therefore instead of filling in missing values with mean or median, it’s more accurate to break it down by province and use the median of each province.

![image income_by_prov](Rplot.png)


`antiguedad` contains customer senoirty in months. I suspect data in this feature is not so accurate since there is a number of negative outliers in the dataset.
```r
#   Min.   1st Qu.    Median      Mean   3rd Qu.      Max.      NA's 
#-999999.0      23.0      52.0      75.6     137.0     256.0      2407 
```
Most client has a client-joined-date so I am able to recalulate the seniority for each client, using `fecha_alta`.

To enhance visulisation readability, some new features are derived from existing variables. For example, `age_group` is created to categorise age into brackets. 

Additionaly, there’s also abundance of character variables that contain empty values and inconsistent formats.I decide to clean the format and either fill the empty strings with the most common value or remove the variable, based on my judgement. Since the dataset is in Spanish, some factor levels are also translated into English for better readability.

Lastly, some features are not loaded into R in the appropriate format. For example, `fecha_dato` (current date) and `fecha_alta` (client start date) are read as factor variables, so I have to convert them into dates.

### Part 4 - Exploratory Data Analysis

#### 4.1


### Part 5 - Prediction

#### 5.1 Model Selection

#### 5.2 Model Results

### Part 6 - Limitations and Further Study

Due to resource constaints, the analysis conducted in this project is based on a stratified random sampled dataset. In other words, the data is incomplete. While it is very reasonable to assume seasonality in financial service industry and pay closer attention to May and June data, taking a random sample still loses a substantial part of the data and limits its usability.

One of the biggest limitations of using sampled data is I am not able to track client over time. For example, `Indrel` indicates whether clients are still primary customers (1), or no longer primary customers at end of month (99). It seems to be an important variable, as customers who are no longer primary at end of month are likely to have had different purchasing behaviours than the others. For clients who are no longer primary customers at end of month, it would be interesting to compare their product owenership with previous month. Other questions that can be answered with full dataset include:

* Which products are usually bought together or within short period of time?
* What is the most common order of purchase? For example, chequing account, saving account then mortgage?
* It costs much less to maintain and cross sell to an existing client than to acquire a new one. How long does it take to cross sell or upsell other products to clients in differnt segments? In other words, how much marketing and sales efforts should Santander expect to spend, before they become multi-line (and more profitable) clients?






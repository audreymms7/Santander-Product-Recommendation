# Santander Product Recommendation




### Part 1 - Project Goals
---------------------------------------
To support needs for a range of financial decisions, Santander Bank offers a lending hand to their customers through personalized product recommendations. Under their current system, a small number of Santander’s customers receive many recommendations while many others rarely see any, resulting in poor customer experience.

The project aims to assist the bank to predict which products their existing customers will use in the next month based on their past behaviors and product ownerships. The goal of this project is to take Santander Bank customer information between January 2015 and May 2016, understand client behaviours and to design a solution to predict which financial service products they are likely to purchase in the next month. With a more effective recommendation system in place, Santander can better meet their client’s needs, provide better client experience with more personalised product recommendations.

Data used in this project is available on [Kaggle](https://www.kaggle.com/c/santander-product-recommendation/data). This project mainly uses train dataset, which includes 13 millions rows of customer bahaviour data, split by month.


### Part 2 - Deep Dive into Data
---------------------------------------
The dataset contains 48 variables and around 13.6 million rows of data observations. I find this dataset too large for my PC to process, and therefore decide to take a random sample of 1 million rows and use it for all further exercises. Given that financial service industry is subject to seasonal trend (Christmas bonus, tax season, etc.) and the goal is to predict the purchasing behaviour for June, I decide to take 80% of the data from May - Jun 2015 and May 2016, and 20% from the rest months.

`Indrel` indicates whether clients are still primary customers (1), or no longer primary customers at end of month (99). It seems to be an interesting variable, as customers who are no longer primary at end of month are likely to have different purchasing behaviours than the others. Choose to replace the missing values with the more frequent status, which is "1" in this case.

`Ind_actividad_cliente`, which indicates if clients are active or not. Again, I choose to replace the missing values with the more frequent status.

I decide to drop variable `cod_prov`, since province information is already saved in `nomprov`.

Address type variable `tipodom` has a few missing values too. After checking data distibution, all observatons have an address type of "1" - primary address so I simply remove the variable.

For the two product variables, replace the missing values with the more frequent status, which is 0.

Lastly, I also find out there’s also abundance of character variables that contain empty values and inconsistent formats.I decide to correct the formats, and either fill the empty strings with the most common value or remove the variable, based on my judgement.

### Part 3 - Initial Findings
---------------------------------------
* Product Ownership vs Age & Segment

![image age by segment](age_segment2.png)
![image age by segment](prod_age_seg.png)
* Foreigner 


![image foreigner by age](foreigner_by_age.png)

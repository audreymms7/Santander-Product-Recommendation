Data wrangling
================

![image Santander](v2-c3f8056348b2ce53c9455da5936b0679_1200x500.jpg)

Santander Product Recommendation
--------------------------------

The goal of this project is to take Santander Bank customer information between January 2015 and May 2016, and to design a solution to predict which financial service products they would purchase in the next month :rocket: .

Data Wrangling
---------------------

#### Bring in the data

The dataset contains 48 variables and around 13.6 million rows of data observations. I find this dataset too large for my PC to process, and therefore decide to take a random sample of 500k rows (400k from May and June, 100k from the rest months) and use it for all further exercises.

1.  Categorical variables:

| Variable                | Defination                                           |
|-------------------------|------------------------------------------------------|
| sexo                    | gender                                               |
| ind\_nuevo              | new customer index                                   |
| ind\_empleado           | customer employee status                             |
| segmento                | segmentation                                         |
| nomprov                 | Province                                             |
| tipodom                 | Address                                              |
| cod\_prov               | Province code                                        |
| indext                  | Foreigner index                                      |
| indresi                 | Residence index                                      |
| indrel                  | primary customer at beginning but not end of month   |
| tiprel\_1mes            | Customer relation type at the beginning of the month |
| ind\_actividad\_cliente | customer active index                                |
| canal\_entrada          | Acquisition channel                                  |
| conyuemp                | Spourse index                                        |

1.  Numeric variables:

``` r
library(dplyr)
library(tidyr)
library(Amelia)
library(ggplot2)
```

Including Plots
---------------

You can also embed plots, for example:

![](Data_wrangling_files/figure-markdown_github/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

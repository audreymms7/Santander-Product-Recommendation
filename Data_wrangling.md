Data wrangling
================

![image Santander](v2-c3f8056348b2ce53c9455da5936b0679_1200x500.jpg)

Santander Product Recommendation
--------------------------------

The goal of this project is to take Santander Bank customer information between January 2015 and May 2016, and to design a solution to predict which financial service products they would purchase in the next month :rocket: .

\#\#\# Data Wrangling
---------------------

#### Bring in the data

The dataset contains 48 variables and around 13.6 million rows of data observations. I find this dataset too large for my PC to process, and therefore decide to take a random sample of 500k rows and use it for all further exercises.

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
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tidyr)
library(Amelia)
```

    ## Loading required package: Rcpp

    ## ## 
    ## ## Amelia II: Multiple Imputation
    ## ## (Version 1.7.5, built: 2018-05-07)
    ## ## Copyright (C) 2005-2019 James Honaker, Gary King and Matthew Blackwell
    ## ## Refer to http://gking.harvard.edu/amelia/ for more information
    ## ##

``` r
library(ggplot2)
```

Including Plots
---------------

You can also embed plots, for example:

![](Data_wrangling_files/figure-markdown_github/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

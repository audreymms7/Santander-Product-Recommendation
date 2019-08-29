![image Santander](v2-c3f8056348b2ce53c9455da5936b0679_1200x500.jpg)
## Santander Product Recommendation

The goal of this project is to take Santander Bank customer information between January 2015 and May 2016, and to design a solution to predict which financial service products they would purchase in the next month. 

### Data Wrangling

#### Bring in the data

The dataset contains 48 variables and around 13.6 million rows of data observations. I find this dataset too large for my PC to process, and therefore decide to take a random sample of 500k rows and use it for all further exercises.

1. Categorical variables:
2. Numeric variables:

```{r}
library(dplyr)
library(tidyr)
library(Amelia)
library(ggplot2)
santander <- read.csv('santander_train.csv')
str(santander)
```

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3






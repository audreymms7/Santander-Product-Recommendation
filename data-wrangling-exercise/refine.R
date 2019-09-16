install.packages("dummies")
library(tidyr)
library(dplyr)
library(dummies)

#load data
refine <- read.csv("refine_original.csv", fileEncoding="UTF-8-BOM")
str(refine)

#cleaning
refine <- refine %>%
          mutate(company = tolower(company)) %>%
          separate(Product.code...number, c("product_code","product_number"),sep="-") %>%
          unite("full_address", address, city, country, sep=",", remove = FALSE)
          

refine$product_category[refine$product_code=="p"] <- "Smartphone"
refine$product_category[refine$product_code=="v"] <- "TV"
refine$product_category[refine$product_code=="x"] <- "Laptop"
refine$product_category[refine$product_code=="q"] <- "Tablet"


refine$company[refine$company %in% c("akz0", "ak zo")] <- "akzo"
refine$company[refine$company %in% c("phillips", "phllips","phillps","fillips","phlips")] <- "philips"
refine$company[refine$company %in% c("unilver")] <- "unilever"

#dummy variables
refine <- cbind(refine, dummy(refine$product_category, sep="_"))
refine <- cbind(refine, dummy(refine$company, sep="_"))

#export
write.csv(refine, "refine_cleaned.csv",row.names = FALSE)

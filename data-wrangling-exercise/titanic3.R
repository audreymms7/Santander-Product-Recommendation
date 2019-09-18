library(ggplot2)

#load data & check missing/empty values
titanic <- read.csv("titanic3_original.csv", fileEncoding="UTF-8-BOM")
str(titanic)
colSums(is.na(titanic)|titanic=="")

#embark - fill with "S"
titanic$embarked[titanic$embarked==""|is.na(titanic$embarked)] = "S"


#age - check to decide if fill with median/mean
ggplot(titanic, aes(x=age)) +                       
  geom_histogram(fill="skyblue", alpha=0.5) +
  geom_vline(aes(xintercept=median(age, na.rm=T)), colour='steelblue', linetype='dashed', size=2) +
  geom_vline(aes(xintercept=mean(age, na.rm=T)), colour='red', linetype='dashed', size=2) +
  ggtitle("Age distribution with mean and median ") +
  theme_bw() 
#looks like the age distibution is slightly right skewed; decide to use median

titanic$age[is.na(titanic$age)] = median(titanic$age, na.rm=T)


#boat - fill with "na"
titanic$boat <- as.character(titanic$boat)
titanic$boat[titanic$boat==""|is.na(titanic$boat)] = "na"


#cabin - create dummy variable 
titanic$has_cabin_number[titanic$cabin==""] <- 0
titanic$has_cabin_number[titanic$cabin!=""] <- 1

#export
write.csv(titanic, "titanic_cleaned.csv",row.names = FALSE)
# Explore the dataset with summary and str

summary(adult)
str(adult)

# Age histogram
ggplot(adult, aes(x=SRAGE_P))+
  geom_histogram(binwidth=2)

# BMI value histogram
ggplot(adult, aes(x=BMI_P))+
  geom_histogram(binwidth=2)

# Age colored by BMI, binwidth = 1
ggplot(adult, aes(x=SRAGE_P,fill=factor(RBMI)))+
  geom_histogram(binwidth=1)

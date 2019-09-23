### Prepare R

library(dplyr)
library(tidyr)
library(Amelia)
library(ggplot2)
install.packages("lubridate")
library(lubridate)
install.packages("reshape2")
library(reshape2)


set.seed(1)
my_theme <- theme_bw() +
  theme(axis.title=element_text(size=20,color="steelblue"),
        plot.title=element_text(size=28,color="steelblue"),
        axis.text =element_text(size=12,color="steelblue") )

my_theme_dark <- theme_dark() +
  theme(axis.title=element_text(size=20),
        plot.title=element_text(size=28),
        axis.text =element_text(size=16))

### First Glance

dta <- read.csv('Santander_Train2.csv', fileEncoding="UTF-8-BOM")
str(dta)
colSums(is.na(dta))

### Missing Value Imputation
##  age
ggplot(dta,aes(x=age))+
  geom_bar(aes(y = ..count..),position="dodge", fill="skyblue")+
  xlim(c(16,100))+
  my_theme+
  ggtitle("Age Distibution")

dta %>%
  filter(segmento!="")%>%
  ggplot(aes(segmento,age)) +                                                  
  geom_boxplot(aes(fill=factor(segmento)),alpha=0.5) +
  my_theme+
  ggtitle("Age distribution by client segment")

new.age <- dta %>%
  select(segmento) %>%
  merge(dta %>%
          group_by(segmento) %>%
          dplyr::summarise(med.age=median(age,na.rm=TRUE)),by="segmento") %>%
  select(segmento,med.age) %>%
  arrange(segmento)
dta <- arrange(dta,segmento)
dta$age[is.na(dta$age)] <- new.age$med.age[is.na(dta$age)]

##  antiguedad
summary(dta$antiguedad)
ggplot(dta, aes(x=antiguedad)) +                       
  geom_histogram(fill="skyblue", alpha=0.5) +
  geom_vline(aes(xintercept=median(antiguedad, na.rm=T)), colour='steelblue', linetype='dashed', size=2) +
  geom_vline(aes(xintercept=mean(antiguedad, na.rm=T)), colour='red', linetype='dashed', size=2) +
  xlim(c(-1,256))+
  ggtitle("Seniority distribution with mean and median ") +
  my_theme 

head(dta)
dta$fecha_dato <- as.Date(dta$fecha_dato)

dta$fecha_alta <- as.Date(dta$fecha_alta)

dta$fecha_alta[is.na(dta$fecha_alta)] <- median(dta$fecha_alta,na.rm=TRUE)

elapsed.months <- function(end_date, start_date) {
  12 * (year(end_date) - year(start_date)) + (month(end_date) - month(start_date))
}
recalculated.antiguedad <- elapsed.months(dta$fecha_dato,dta$fecha_alta)
dta$antiguedad <- recalculated.antiguedad

##  ind_nuevo
ant <- dta%>% 
  filter (is.na(ind_nuevo)) %>%
  select(antiguedad)
summary(ant)

dta$ind_nuevo[is.na(dta$ind_nuevo)] <- 0

##  Renta
summary(dta$renta)
dta %>%
  filter(!is.na(renta)) %>%
  group_by(nomprov) %>%
  summarise(med.income = median(renta)) %>%
  arrange(med.income) %>%
  mutate(prov=factor(nomprov,levels=nomprov)) %>%
  ggplot(aes(x=prov,y=med.income)) +
  geom_point(color="steelblue") +
  guides(color=FALSE) +
  xlab("Province") +
  ylab("Median Income") +
  my_theme +
  theme(axis.text.x=element_blank(), axis.ticks = element_blank()) +
  geom_text(aes(x=prov,y=med.income,label=prov),angle=90,hjust=-.25)+
  theme(
    panel.grid =element_blank(),
    axis.title =element_text(color="steelblue"),
    axis.text  =element_text(color="steelblue"),
    plot.title =element_text(color="steelblue")) +
  ylim(c(60000,180000)) +
  ggtitle("Income Distribution by Province")

new.incomes <- dta %>%
  select(nomprov) %>%
  merge(dta %>%
          group_by(nomprov) %>%
          dplyr::summarise(med.income=median(renta,na.rm=TRUE)),by="nomprov") %>%
  select(nomprov,med.income) %>%
  arrange(nomprov)
dta <- arrange(dta,nomprov)
dta$renta[is.na(dta$renta)] <- new.incomes$med.income[is.na(dta$renta)]
dta$renta[is.na(dta$renta)] <- median(dta$renta,na.rm=TRUE)

##  Indrel & other variables
table(dta$indrel)
dta$indrel[is.na(dta$indrel)] <- 1 
table(dta$ind_actividad_cliente)
dta$ind_actividad_cliente[is.na(dta$ind_actividad_cliente)] <- median(dta$ind_actividad_cliente,na.rm=TRUE)
dta <- dta %>% select (-cod_prov)
table(dta$tipodom)
dta <- dta %>% select (-tipodom)
table(dta$ind_nomina_ult1)
dta$ind_nomina_ult1[is.na(dta$ind_nomina_ult1)] <- median(dta$ind_nomina_ult1,na.rm=TRUE)
table(dta$ind_nom_pens_ult1)
dta$ind_nom_pens_ult1[is.na(dta$ind_nom_pens_ult1)] <- median(dta$ind_nom_pens_ult1,na.rm=TRUE)

### Empty Value Imputation

colSums(dta=="")
summary(dta$segmento) 

dta$indfall[dta$indfall==""]                 <- "N"
dta$tiprel_1mes[dta$tiprel_1mes==""]         <- "I"
dta$indrel_1mes[dta$indrel_1mes==""]         <- "1"
dta$indrel_1mes[dta$indrel_1mes=="1.0"]        <- "1"
dta$indrel_1mes[dta$indrel_1mes=="2.0"]        <- "2"
dta$indrel_1mes[dta$indrel_1mes=="3.0"]        <- "3"
dta$indrel_1mes[dta$indrel_1mes=="4.0"]        <- "4"

dta$canal_entrada[dta$canal_entrada==""]     <- "KHE"
dta$pais_residencia[dta$pais_residencia==""] <- "ES"
dta$sexo[dta$sexo==""]                       <- "V"
dta <- dta %>% select (-ult_fec_cli_1t)
dta$ind_empleado[dta$ind_empleado==""]       <- "N"
dta$indext[dta$indext==""]                   <- "N"
dta$indresi[dta$indresi==""]                 <- "S"
dta <- dta %>% select (-conyuemp)
dta$segmento[dta$segmento==""]               <- "02 - PARTICULARES"

str(dta)


### Export Clean Data
write.csv(dta, "Santander_cleaned.csv",row.names = FALSE)

### EDA
str(dta)
## Convert Data Type

dta$indrel <- as.factor(dta$indrel)
dta$ind_nuevo <- as.factor(dta$ind_nuevo)
dta$canal_entrada <- as.factor(dta$canal_entrada)
dta$ind_actividad_cliente <- as.factor(dta$ind_actividad_cliente)
dta$ind_nomina_ult1 <- as.integer(dta$ind_nomina_ult1)
dta$ind_nom_pens_ult1 <- as.integer(dta$ind_nom_pens_ult1)

## Convert age and income into brackets: "0 to 15","16 to 25","26 to 35","36 to 45","46 to 55","56 to 65","65+"
dta$age_group[dta$age > 65] <- "65+"
dta$age_group[dta$age > 55 & dta$age <= 65] <- "56~65"
dta$age_group[dta$age > 45 & dta$age <= 55] <- "46~55"
dta$age_group[dta$age > 35 & dta$age <= 45] <- "36~45"
dta$age_group[dta$age > 25 & dta$age <= 35] <- "26~35"
dta$age_group[dta$age > 15 & dta$age <= 25] <- "16~25"
dta$age_group[dta$age <= 15] <- "0~15"

levels(dta$segmento)[levels(dta$segmento)=="02 - PARTICULARES"] <- "Regular"
levels(dta$segmento)[levels(dta$segmento)=="01 - TOP"] <- "VIP"
levels(dta$segmento)[levels(dta$segmento)=="03 - UNIVERSITARIO"] <- "Student"

summary(dta$renta)
dta$income_group[dta$renta > 180000] <- "180k+"
dta$income_group[dta$renta > 135000 & dta$renta <= 180000] <- "135k~180k"
dta$income_group[dta$renta > 90000 & dta$renta <= 135000] <- "90k~135k"
dta$income_group[dta$renta > 45000 & dta$renta <= 90000] <- "45k~90k"
dta$income_group[dta$renta > 0 & dta$renta <= 45000] <- "Below 45k"

table(dta$income_group)

## count of client
dta %>% summarise(count = n_distinct(ncodpers))



## Product vs Age/Segment
str(dta)
prod_age_seg <- dta %>% 
                select(20,21:45)
str(prod_age_seg)
prod_age_seg2 <- prod_age_seg %>% gather(Prod, Counts, ind_ahor_fin_ult1:ind_recibo_ult1)%>% 
                 group_by(segmento, age_group, Prod) %>%
                 summarise(sum_cnts = sum(Counts))


ggplot(prod_age_seg2, aes(x=Prod, y=sum_cnts, fill=age_group))+
  geom_col()+
  facet_wrap(.~segmento)+
  ggtitle("Product ownership across Age and Segment")+
  my_theme +
  theme(axis.text.x = element_text(size=8,angle = 90))

##  Product vs Foreign workers
mosaicplot(~ indext + age_group, data=dta, main='Foreign/Domestic by age group', shade=TRUE)
prod_foreign <- dta %>% 
  select(14,21:44)
str(prod_foreign)
prod_foreign2 <- prod_foreign %>% gather(Prod, Counts, ind_ahor_fin_ult1:ind_recibo_ult1)%>% 
  group_by(indext,Prod) %>%
  summarise(sum_cnts = sum(Counts))

ggplot(prod_foreign2, aes(x=Prod, y=sum_cnts, fill=indext))+
  geom_col()+
  facet_wrap(.~indext)+
  scale_fill_manual(values = c("skyblue","red3"))+
  ggtitle("Product ownership for domestic/foreign clients")+
  my_theme +
  theme(axis.text.x = element_text(size=8,angle = 90))

##  Product vs Income

##  Product vs channel
table(dta$canal_entrada)
count(dta,canal_entrada, sort=T)
#   only plot top 7 channels
prod_chan <- dta %>% 
  select(15,21:44)
str(prod_chan)
prod_chan2 <- prod_chan %>% filter(canal_entrada %in% c("KHE","KAT","KFC","KHQ","KFA","KHK","KHM"))%>%
  gather(Prod, Counts, ind_ahor_fin_ult1:ind_recibo_ult1)%>% 
  group_by(canal_entrada,Prod) %>%
  summarise(sum_cnts = sum(Counts))

ggplot(prod_chan2, aes(x=Prod, y=sum_cnts, fill=canal_entrada))+
  geom_col()+
  facet_wrap(.~canal_entrada)+
  scale_fill_brewer(palette = "RdYlBu")+
  ggtitle("Product ownership by channel")+
  my_theme +
  theme(axis.text.x = element_text(size=8,angle = 90))

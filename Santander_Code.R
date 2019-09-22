## Prepare R

library(dplyr)
library(tidyr)
library(Amelia)
library(ggplot2)
library(lubridate)

set.seed(1)
my_theme <- theme_bw() +
  theme(axis.title=element_text(size=24,color="steelblue"),
        plot.title=element_text(size=36,color="steelblue"),
        axis.text =element_text(size=16,color="steelblue") )

my_theme_dark <- theme_dark() +
  theme(axis.title=element_text(size=24),
        plot.title=element_text(size=36),
        axis.text =element_text(size=16))

## First Glance

dta <- read.csv('Santander_Train2.csv', fileEncoding="UTF-8-BOM")
str(dta)
colSums(is.na(dta))

## Missing Value Imputation
#  age
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

#  antiguedad
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

#  ind_nuevo
ant <- dta%>% 
  filter (is.na(ind_nuevo)) %>%
  select(antiguedad)
summary(ant)

dta$ind_nuevo[is.na(dta$ind_nuevo)] <- 0

#  Renta
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

#  Indrel & other variables
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

## Empty Value Imputation

colSums(dta=="")
summary(dta$segmento) 

dta$indfall[dta$indfall==""]                 <- "N"
dta$tiprel_1mes[dta$tiprel_1mes==""]         <- "I"
dta$indrel_1mes[dta$indrel_1mes==""]         <- "1"
dta$indrel_1mes[dta$indrel_1mes=="1.0"]        <- "1"
dta$indrel_1mes[dta$indrel_1mes=="2.0"]        <- "2"
dta$indrel_1mes[dta$indrel_1mes=="3.0"]        <- "3"
dta$indrel_1mes[dta$indrel_1mes=="4.0"]        <- "4"

dta$pais_residencia[dta$pais_residencia==""] <- "ES"
dta$sexo[dta$sexo==""]                       <- "V"
dta <- dta %>% select (-ult_fec_cli_1t)
dta$ind_empleado[dta$ind_empleado==""]       <- "N"
dta$indext[dta$indext==""]                   <- "N"
dta$indresi[dta$indresi==""]                 <- "S"
dta <- dta %>% select (-conyuemp)
dta$segmento[dta$segmento==""]               <- "02 - PARTICULARES"

str(dta)


## Export Clean Data
write.csv(dta, "Santander_cleaned.csv",row.names = FALSE)
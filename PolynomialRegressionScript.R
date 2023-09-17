##importiamo rispettivamente le banche dati di cui abbiamo bisogno

library(readxl)
italia <- read_excel("dataset.xlsx", sheet = "Daily Arrivals to Italy")
View(italia)
library(readxl)
grecia <- read_excel("dataset.xlsx", sheet = "Daily Arrivals to Greece")
View(grecia)
library(readxl)
covid19 <- read_excel("dataset.xlsx", sheet = "Covid19")
View(dataset)

########PLOT CON LINEE ITALIA - GRECIA (SBARCHI)
png(file="plot.jpg")
plot(datanew$arrivi,type = "o", col = "red", xlab = "data", ylab = "arrivi",
     main = "Italia - Grecia")
lines(datanew$arrivi.1, type = "o", col = "blue")
dev.off()
#LOG (ITALIA - GRECIA) - POLINOMIO DEL TEMPO
attach(italia)
logitalia = log(italia$arrivi)
logitalia [!is.finite(logitalia)]=0
ti = length(logitalia)
time = 1:ti
time2 = time^2
time3 = time^3
detach(italia)
attach(grecia)
loggrecia = log(grecia$arrivi)
loggrecia [!is.finite(loggrecia)]=0
detach(grecia)
datanew =data.frame(italia,grecia,covid19, logitalia=logitalia,loggrecia=loggrecia)

#REGRESSIONE POLINOMIALE (PERIODO - COVID19)
fit1_italia <- lm(datanew$logitalia ~ datanew$covid19 + time)
fit2_italia <- lm(datanew$logitalia ~ datanew$covid19 + time +I(time2))
fit3_italia <- lm(datanew$logitalia ~ datanew$covid19 + time + I(time2) + I(time3))

fit1_grecia <- lm(datanew$loggrecia ~ datanew$covid19 + time)
fit2_grecia <- lm(datanew$loggrecia ~ datanew$covid19 + time +I(time2))
fit3_grecia <- lm(datanew$loggrecia ~ datanew$covid19 + time + I(time2) + I(time3))

andamento_grecia <- function(x) fit3_grecia$coefficient[5]*x^4 + fit3_grecia$coefficient[4]*x^3 + fit3_grecia$coefficient[3]*x^2 + fit3_grecia$coefficient[2]*x + fit3_grecia$coefficient[1]
plot(time, datanew$loggrecia, type="l", lwd=3)
andamento_2_grecia <- function(x) fit3_grecia$coefficient[5]*x^4 + fit3_grecia$coefficient[4]*x^3 + fit3_grecia$coefficient[3]*x^2 + fit3_grecia$coefficient[2]*x + fit3_grecia$coefficient[1]
curve(andamento_2_grecia, col="red", lwd=2)

andamento_italia <- function(x) fit3_italia$coefficient[3]*x^2 + fit3_italia$coefficient[2]*x + fit3_italia$coefficient[1]
plot(time, datanew$logitalia, type="l", lwd=3)
andamento_2_italia <- function(x) fit3_italia$coefficient[3]*x^2 + fit3_italia$coefficient[2]*x + fit3_italia$coefficient[1]
curve(andamento_2_italia, col="red", lwd=2)



plot(time, logitalia, type="l", lwd=3)
points(time, predict(fit1_italia), type="l", col="blue", lwd=2)
points(time, predict(fit2_italia), type="l", col="yellow", lwd=2)
points(time, predict(fit3_italia), type="l", col="red", lwd=2)

plot(time, loggrecia, type="l", lwd=3)
points(time, predict(fit1_grecia), type="l", col="blue", lwd=2)
points(time, predict(fit2_grecia), type="l", col="yellow", lwd=2)
points(time, predict(fit3_grecia), type="l", col="red", lwd=2)


#REGRESSIONE POLINOMIALE PERIODO(PRE COVID19)
library(readxl)
pre_covid19 <- read_excel("datasetprecovid19.xlsx", 
                                sheet = "Pre_Covid19")
View(pre_covid19)
attach(pre_covid19)
Tempo = length(loggrecia2)
TIME = 1:Tempo
TIME2 = TIME^2
TIME3 = TIME^3
attach(loggrecia2)
loggrecia2= log(pre_covid19$Grecia)
loggrecia2 [!is.finite(loggrecia2)]=0

fit_1_grecia <- lm(loggrecia2 ~  TIME)
fit_2_grecia <- lm(loggrecia2  ~  TIME +I(TIME2))
fit_3_grecia <- lm(loggrecia2  ~   TIME +I(TIME2) + I(TIME3))

andamento_1_grecia <- function(x) fit_3_grecia$coefficient[4]*x^3 + fit_3_grecia$coefficient[3]*x^2 + fit_3_grecia$coefficient[2]*x + fit_3_grecia$coefficient[1]
plot(TIME, loggrecia2 , type="l", lwd=3)
andamento2_grecia <- function(x)  fit_3_grecia$coefficient[4]*x^3 + fit_3_grecia$coefficient[3]*x^2 + fit_3_grecia$coefficient[2]*x + fit_3_grecia$coefficient[1]
curve(andamento2_grecia, col="red", lwd=2)


plot(TIME, loggrecia2 , type="l", lwd=3)
points(TIME, predict(fit_1_grecia), type="l", col="blue", lwd=2)
points(TIME, predict(fit_2_grecia), type="l", col="yellow", lwd=2)
points(TIME, predict(fit_3_grecia), type="l", col="red", lwd=2)

attach(pre_covid19)
logitalia2= log(pre_covid19$Italia)
logitalia2 [!is.finite(logitalia2)]=0

fit_1_italia <- lm(logitalia2 ~  TIME)
fit_2_italia <- lm(logitalia2  ~ TIME +I(TIME2))
fit_3_italia <- lm(logitalia2  ~  TIME +I(TIME2) + I(TIME3))

andamento_1_italia <- function(x) fit_2_italia$coefficient[3]*x^2 + fit_2_italia$coefficient[2]*x + fit_2_italia$coefficient[1]
plot(TIME, logitalia2 , type="l", lwd=3)
andamento2_italia <- function(x) fit_2_italia$coefficient[3]*x^2 + fit_2_italia$coefficient[2]*x + fit_2_italia$coefficient[1]
curve(andamento2_italia, col="red", lwd=2)


plot(TIME, logitalia2 , type="l", lwd=3)
points(TIME, predict(fit_1_italia), type="l", col="blue", lwd=2)
points(TIME, predict(fit_2_italia), type="l", col="yellow", lwd=2)
points(TIME, predict(fit_3_italia), type="l", col="red", lwd=2)

###############################################################################













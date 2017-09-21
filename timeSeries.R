#Time series R code
data("AirPassengers")
AP<- AirPassengers
class(AP)
start(AP)
end(AP)
frequency(AP)
summary(AP)
plot(AP)
cycle(AP)
aggregate(AP)
plot(aggregate(AP))
aggregate(AP, FUN = mean)
plot(aggregate(AP, FUN = mean))
boxplot(AP)
boxplot(AP~cycle(AP))


# Scraping Data from web and performing time series analysis
webdata<- "http://rci.rutgers.edu/~rwomack/UNRATE.csv"
webdata2<- "http://rci.rutgers.edu/~rwomack/CPIAUCSL.csv"

unemployment<- read.csv(webdata, row.names = 1)
uRate<- ts(unemployment$VALUE, start = c(1948, 1), frequency = 12)
inflation<- read.csv(webdata2, row.names = 1)
iRate<- ts(inflation$VALUE, start = c(1948, 1), frequency = 12)

uRate.July<- window(uRate, start = c(1980,7), frequency=TRUE)
time(uRate)
plot(uRate)
abline(reg = lm(uRate~time(uRate)))
decompose(uRate)
plot(decompose(uRate))
plot(iRate,uRate, col= c("blue", "red"))
ts.plot(iRate, uRate, col= c("blue", "red"))

acf(uRate)
acf(AP)
acf(ts.intersect(uRate, AP))
ts.union(uRate, AP)

plot(HoltWinters(uRate, alpha = 0.001, beta = 1, gamma = 0))
plot(HoltWinters(AP))
plot(HoltWinters(AP, alpha = 0.1, beta = 0.2, gamma = 0))

AP.hw<- HoltWinters(AP)
plot(AP.hw)
AP.predict<- predict(AP.hw, n.head= 10*12)
ts.plot(AP, AP.predict, lty=1:2)







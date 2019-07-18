library(usmap)
library(ggplot2)
library(plyr)
library(dplyr)

#library(data.table)
mywholedata <- read.csv("Users/chenkunyu/Desktop/wifeintern/Rate.csv")
myoverview <- read.csv("Users/chenkunyu/Desktop/wifeintern/USCS_OverviewMap.csv")
mystroke <- read.csv("Users/chenkunyu/Desktop/wifeintern/stroke_mortality.csv")
myname <- read.csv("Users/chenkunyu/Desktop/wifeintern/us_states.csv")
#count beneficiaries of each state

mydata <- subset(mywholedata, BusinessYear == "2016")
mystroke <- subset(mystroke, YEAR == "2016")
tempNumCount = ddply(mydata,  .(StateCode), summarize, count = length((StateCode)))
print(tempNumCount)

#calculate median cost
tempMedianData = ddply(mydata,  .(StateCode), summarize, median_cost = median(IndividualRate))
print(tempMedianData)

#calculate mean
tempMeanData = ddply(mydata,  .(StateCode), summarize, mean_cost = mean(IndividualRate))
names(tempMeanData) = c('state', 'mean')
print(tempMeanData)

plot_usmap(data=tempMeanData, values = "mean", lines = "red")+scale_fill_continuous(low = "white", high = "purple")

myoverview = left_join(myoverview, myname, by="Area")
mycancercol = left_join(myoverview, tempMeanData, by="state")
attach(mycancercol)
cor.test(mean, na.omit(AgeAdjustedRate), method = "spearm" )


mystrokecol = left_join(mystroke, tempMeanData, by="state")
attach(mystrokecol)
cor.test(mean, na.omit(RATE), method = "spearm")

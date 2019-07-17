mydata <- read.csv("/Users/chenkunyu/Desktop/Rate.csv")

#count beneficiaries of each state
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

mydata1 <- read.csv("/Users/chenkunyu/Desktop/USCS_OverviewMap.csv")






#install.packages('arules')
library('arules')
groceries = read.transactions('groceries.csv', sep = ',')
summary(groceries)
inspect(groceries[1:5])
itemFrequency(groceries[,1:3])
itemFrequencyPlot(groceries, support=.1)
itemFrequencyPlot(groceries, topN =15)
apriori(groceries)
# support comes from number of times bought over number of rows
#so 60 / 9835 = .006
groceriesrules = apriori(groceries,
                         parameter = list(support = 0.006,
                                          confidence = 0.25,
                                          minlen=2))
summary(groceriesrules)
inspect(groceriesrules[1:3])
inspect(sort(groceriesrules,by = 'support') [1:10])

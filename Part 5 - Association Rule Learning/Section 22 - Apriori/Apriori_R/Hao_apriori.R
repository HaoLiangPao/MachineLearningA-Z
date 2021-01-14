#Apriori


# Look at the data itself
#read data from the dataset （from French）
#install.packages('arules')
library('arules')
dataset = read.csv('Market_Basket_Optimisation.csv', header = FALSE)
dataset = read.transactions("Market_Basket_Optimisation.csv", sep = ',', rm.duplicates = TRUE)
summary(dataset)
##稀疏矩阵，density是1在0里面的
itemFrequencyPlot(dataset, topN = 10)

# Training Apriori on our dataset
# Step 1: decide the minimum support and minimum confidence
# Minimum Support: be sold at least 3 times a day - 3*7/7500
# Confidence: not itensial, will test and find out - 0.8(default)
rules = apriori(data = dataset, parameter = list(support=0.003, confidence=0.2))
# if little rules found, means confidence is too high!

# Visualizing the results(rules)
inspect(sort(rules, by = 'lift')[1:10])
 



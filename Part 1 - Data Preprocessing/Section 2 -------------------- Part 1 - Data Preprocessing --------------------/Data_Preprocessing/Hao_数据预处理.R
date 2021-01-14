# Data Processing

# Importing DataSet
dataset = read.csv("Data.csv")

# Take care of missing data
tryout = dataset$Age
tryout1 = dataset$Age[is.na(dataset$Age)]

dataset$Age[is.na(dataset$Age)] = mean(dataset$Age, na.rm = T)
dataset$Salary[is.na(dataset$Salary)] = mean(dataset$Salary, na.rm = T)

# Transform categorical data
dataset$Country = factor(dataset$Country,
                         levels = c("France", "Germany", "Spain"),
                         labels = c(1,2,3))
dataset$Purchased = factor(dataset$Purchased,
                         levels = c("Yes", "No"),
                         labels = c(0,1))

# Splitting the dataset into training set and testing set
install.packages('caTools')
library(caTools)
# Generate random number
set.seed(123)
# Create split pattern based on random number generated
split = sample.split(dataset$Purchased, 0.8)
# Subset the source dataset into actual training set and testing set
training_set = subset(dataset, split == TRUE)
testing_set = subset(dataset, split == FALSE)

# Feature Scaling - 不能对factor进行scaling，目前只能对数字进行scaling
training_set[,2:3] = scale(training_set[,2:3])
testing_set[,2:3] = scale(testing_set[,2:3])



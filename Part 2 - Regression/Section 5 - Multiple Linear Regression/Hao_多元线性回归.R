#Data Processing

#Importing DataSet
dataset = read.csv("50_Startups.csv")

#transform categorical data
dataset$State = factor(dataset$State,
                         levels = c("New York", "California", "Florida"),
                         labels = c(1,2,3))

#splitting the dataset into training set and testing set
install.packages('caTools')
library(caTools)
#generate random number
set.seed(123)
#create split pattern based on random number generated
split = sample.split(dataset$Profit, 0.8)
#subset the source dataset into actual training set and testing set
training_set = subset(dataset, split == TRUE)
testing_set = subset(dataset, split == FALSE)

#Fitting Multiple Linear Regression to the Trainning Set
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = training_set)

#Predicting the Test set Result
Y_pred = predict(regressor, newdata = testing_set)

#Building the Optimal Model using Backward Elimination
regressor = lm(formula = Profit ~.,
               data = training_set)
summary(regressor)
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
               data = training_set)
summary(regressor)
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = training_set)
summary(regressor)
regressor = lm(formula = Profit ~ R.D.Spend,
               data = training_set)
summary(regressor)





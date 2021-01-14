#Data Processing

#Importing DataSet
dataset = read.csv("Salary_Data.csv")

#splitting the dataset into training set and testing set
#install.packages('caTools')
library(caTools)
#generate random number
set.seed(123)
#create split pattern based on random number generated
split = sample.split(dataset$Salary, 2/3)
#subset the source dataset into actual training set and testing set
training_set = subset(dataset, split == TRUE)
testing_set = subset(dataset, split == FALSE)

#Fitting the simple linear regression to the training set
#P < 0.05 -> a relatively good model
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)
Y_pred = predict(regressor, newdata = testing_set)

library(ggplot2)
#Training Set
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'red') + 
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle("Salary vs Experience (Training Set)") + 
  xlab("Years of Experience") +
  ylab("Salary")
#Testing Set
ggplot() +
  geom_point(aes(x = testing_set$YearsExperience, y = testing_set$Salary),
             colour = 'red') + 
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle("Salary vs Experience (Testing Set)") + 
  xlab("Years of Experience") +
  ylab("Salary")



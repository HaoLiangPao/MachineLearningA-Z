#Data Processing

#Importing DataSet
dataset = read.csv("Position_Salaries.csv")
dataset = dataset[,2:3]

# Fitting Linear Regression to the Trainning Set
Lin_reg = lm(formula = Salary ~ Level,
               data = dataset)

# Fitting Polynomial Regression to the Trainning Set
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
Poly_reg = lm(formula = Salary ~ .,
             data = dataset)

# Visualizing the Linear Regression results
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
               colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(Lin_reg, newdata = dataset)),
              colour = "blue") + 
  xlab('Level') + 
  ylab('Salary')



# Visualizing the Polynomial Regression results
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(Lin_reg2, newdata = dataset)),
            colour = "blue") + 
  xlab('Level') + 
  ylab('Salary')

# Predicting a new result with Linear Regression
Y_pred_lin = predict(Lin_reg, data.frame(Level = 6.5))

# Predicting a new result with Polynomial Regression
Y_pred_Poly = predict(Poly_reg, data.frame(Level = 6.5, Level2 = 6.5^2, Level3 = 6.5^3, Level4 = 6.5^4))


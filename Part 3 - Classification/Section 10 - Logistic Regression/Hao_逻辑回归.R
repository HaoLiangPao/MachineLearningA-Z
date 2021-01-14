# Logistic Regression

# Import dataset
dataset = read.csv("Social_Network_Ads.csv")
dataset = dataset[,3:5]

# Splitting the dataset into training set and testing set
install.packages('caTools')
library(caTools)
# Generate random number
set.seed(123)
# Create split pattern based on random number generated
split = sample.split(dataset$Purchased, 0.75)
# Subset the source dataset into actual training set and testing set
training_set = subset(dataset, split == TRUE)
testing_set = subset(dataset, split == FALSE)

# Feature Scaling - 不能对factor进行scaling，目前只能对数字进行scaling
training_set[,1:2] = scale(training_set[,1:2])
testing_set[,1:2] = scale(testing_set[,1:2])

# Fitting Logistic Regression to the Training Set
Classifier = glm(# 所用的数据
                 formula = Purchased ~ .,
                 # 涉及核心算法
                 family = binomial,
                 # 提取数据的数据库
                 data = training_set)

# Predicting the Test set result
Newdata = testing_set[-3]
prob_pred = predict(Classifier, type = "response", newdata = testing_set[-3])
y_pred = ifelse(prob_pred > 0.5, 1, 0)

# Making the Confusion Matrix
cm = table(testing_set[,3], y_pred)

# Visualising the Training set results
# install.packages(ElemStatLearn)
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.0075)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.0075)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(Classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Classifier (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# Visualising the Test set results
# install.packages(ElemStatLearn)
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.0075)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.0075)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(Classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Classifier (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

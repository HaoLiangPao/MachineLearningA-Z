#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 12 16:01:47 2019

@author: lianghao
"""

#import libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#import dataset
dataset = pd.read_csv('Position_Salaries.csv')
#Matrix
X = dataset.iloc[:,1:2].values
#Factor
Y = dataset.iloc[:,2].values

#No need to seperate training set and testing set due to small number of data

# Fitting Multiple Regression to the Data Set
from sklearn.linear_model import LinearRegression
Lin_reg = LinearRegression()
Lin_reg.fit(X, Y)

# Fitting Polynomial Regression to the Data Set
from sklearn.preprocessing import PolynomialFeatures
poly_reg = PolynomialFeatures(degree = 4)
X_poly = poly_reg.fit_transform(X)

Lin_reg2 = LinearRegression()
Lin_reg2.fit(X_poly, Y)

# Visualizing the Linear Regression results
plt.scatter(X,Y, color = "red")
plt.plot(X,Lin_reg.predict(X), color = "blue")
plt.title("Truth or Bluff (Linear Regression)")
plt.xlabel("Working experience")
plt.ylabel("Salary")
plt.show()



# Visualizing the Polynomial Regression results
X_grid = np.arange(min(X), max(X), 0.1)
X_grid = X_grid.reshape(len(X_grid), 1)

plt.scatter(X,Y, color = "red")
plt.plot(X_grid,Lin_reg2.predict(poly_reg.fit_transform(X_grid)), color = "blue")
plt.title("Truth or Bluff (Polynomial Regression)")
plt.xlabel("Working experience")
plt.ylabel("Salary")
plt.show()

# Reshape the format of the data, so it can be used by our regressor
level = np.array([6.5])
level = level.reshape(-1,1)

# Predicting a new result with Linear Regression
Lin_reg.predict(level)

# Predicting a new result with Polynomial Regression
Lin_reg2.predict(poly_reg.fit_transform(level))

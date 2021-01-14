#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 29 15:36:10 2019

@author: lianghao
"""

#DataProcessing

#import libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#import dataset
dataset = pd.read_csv('Salary_Data.csv')
#all data except purchase result
X = dataset.iloc[:,0:-1].values
#purchase result
Y = dataset.iloc[:,-1].values

#spliting the dataset into training set and testing set
from sklearn.model_selection import train_test_split
# usually 0.25 - 0.4 for testing, rest is for trainning set
# random_state = 0 will give you same random dumber everytime
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 1/3, random_state = 0)

#Fitting simple linear regression to the Training Set
from sklearn.linear_model import LinearRegression
'''创建regressor，拟合器'''
regressor = LinearRegression()
#拟合过程
regressor.fit(X_train, Y_train)

#prediting the Test set Result
Y_pred = regressor.predict(X_test)

#visualizing the training set
plt.scatter(X_train, Y_train, color = 'red',)
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title("Salary VS Experience (Training Set)")
plt.xlabel("Years of Experience")
plt.ylabel("Salary")
plt.show()


plt.scatter(X_test, Y_test, color = 'red',)
'''no need to change anything here!'''
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title("Salary VS Experience (Testing Set)")
plt.xlabel("Years of Experience")
plt.ylabel("Salary")
plt.show()
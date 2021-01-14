#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 29 17:41:37 2019

@author: lianghao
"""

#DataProcessing

#import libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#import dataset
dataset = pd.read_csv('50_Startups.csv')
#Matrix
X = dataset.iloc[:,0:-1].values
#Factor
Y = dataset.iloc[:,4].values

#Change 'State' into dummy variables
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelEncoder_X = LabelEncoder()
#Step1: Create categories but put them in random order, which is not nessesary
X[:,3] = labelEncoder_X.fit_transform(X[:,3])
#Step2: Create categories but put them into certain orders.
from sklearn.preprocessing import OneHotEncoder
onehotencoder = OneHotEncoder(categorical_features = [3])
X = onehotencoder.fit_transform(X).toarray()
#Step3: Avoid Dummy Variables Trap
X = X[:,1:]

#spliting the dataset into training set and testing set
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, random_state = 0)

#Fitting Multiple Regression into the Training Set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, Y_train)

#Predicting the Test set results
Y_pred = regressor.predict(X_test)

#Building the optimal model using Backward Elimination 反向淘汰的准备工作，加一列1，因为原本没有常数项
import statsmodels.formula.api as sm
X_train = np.append(arr = np.ones((40,1)), values = X_train, axis = 1)
#Step1: set the significant level
X_opt = X_train[:,[0,1,2,3,4,5]]
#因为重新倒入了一个标准库？
regressor_OLS = sm.OLS(endog = Y_train, exog = X_opt).fit()
regressor_OLS.summary()
#Step4: 去掉最高的
X_opt = X_train[:,[0,1,3,4,5]]
regressor_OLS = sm.OLS(endog = Y_train, exog = X_opt).fit()
regressor_OLS.summary()
#Step4: 去掉最高的
X_opt = X_train[:,[0,3,4,5]]
regressor_OLS = sm.OLS(endog = Y_train, exog = X_opt).fit()
regressor_OLS.summary()
#Step4: 去掉最高的
X_opt = X_train[:,[0,3,5]]
regressor_OLS = sm.OLS(endog = Y_train, exog = X_opt).fit()
regressor_OLS.summary()
#Step4: 去掉最高的
X_opt = X_train[:,[0,3]]
regressor_OLS = sm.OLS(endog = Y_train, exog = X_opt).fit()
regressor_OLS.summary()

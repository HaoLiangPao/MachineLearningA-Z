#DataProcessing

#import libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#import dataset
dataset = pd.read_csv('Data.csv')
#all data except purchase result
X = dataset.iloc[:,0:-1].values
#purchase result
Y = dataset.iloc[:,-1].values

#take care of missing values
from sklearn.preprocessing import Imputer
imputer = Imputer(missing_values = "NaN", strategy = 'mean', axis = 0)
imputer = imputer.fit(X[:,1:3])
X[:,1:3] = imputer.transform(X[:,1:3])

#Encoding Categorical Values
from sklearn.preprocessing import LabelEncoder
labelEncoder_X = LabelEncoder()
#create categories but put them in random order, which is not nessesary
X[:,0] = labelEncoder_X.fit_transform(X[:,0])
#create categories but put them into certain orders.
from sklearn.preprocessing import OneHotEncoder
onehotencoder = OneHotEncoder(categorical_features = [0])
Z = onehotencoder.fit_transform(X).toarray()
#change true or false to 0&1
labelEncoder_Y = LabelEncoder()
Y = labelEncoder_Y.fit_transform(Y)


#spliting the dataset into training set and testing set
from sklearn.model_selection import train_test_split
# usually 0.25 - 0.4 for testing, rest is for trainning set
# random_state = 0 will give you same random dumber everytime
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, random_state = 0)

''' Euclidean Distance 欧式距离 is a very important relation to study '''
#Feature Scaling 特征缩放
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train_sc = sc_X.fit_transform(X_train)
'''已经拟合过了不需要再次拟合''' 
X_test_sc = sc_X.transform(X_test)


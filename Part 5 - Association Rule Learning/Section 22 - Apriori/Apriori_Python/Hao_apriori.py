#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug  6 11:32:15 2019

@author: lianghao
"""

# K-Means
# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('Market_Basket_Optimisation.csv', header = None)
transactions = []
for i in range(0,7501):
    transactions.append(str([dataset.values[i,j] for j in range(0,20)]))

# Training Apriori on dataset
# The apriori is imported from the file stored under the same address.
# apyori.py
from apyori import apriori
# We need to test these variables to see the final reasonable rules.
rules = apriori(transactions, min_support = 0.003, min_confidence = 0.8, 
                min_lift = 3, min_length = 2)

# Visualizing the results
result = list(rules)
myResult = [list[x] for x in results]
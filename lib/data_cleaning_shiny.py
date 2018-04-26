# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd
from sklearn.cross_validation import train_test_split

cooking = pd.read_csv("../output/cooking_data.csv")
colsums = cooking.sum(axis = 0).reset_index(drop=True)[:-1]
cooking_new = cooking.iloc[:,colsums.sort_values(ascending=False).index[:2000]]

label = pd.read_csv("../data/cooking.csv").iloc[:,1]
cooking_new.insert(0,'cuisine',label)
train_data, test_data = train_test_split(cooking_new, test_size = 0.3, 
                                         stratify = cooking_new.cuisine, random_state = 1)
train_data.to_csv('../output/logistic_shiny_train.csv', header=False, index=False)
test_data.to_csv('../output/logistic_shiny_test.csv', header=False, index=False)
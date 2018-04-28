# -*- coding: utf-8 -*-
"""
Data Cleaning for Shiny Logistic Regression Model
Lan Wen
"""

import pandas as pd
from sklearn.cross_validation import train_test_split
from imblearn.over_sampling import SMOTE

cooking = pd.read_csv("../output/cooking_data.csv")
X = cooking.iloc[:,range(len(cooking.columns)-1)]
Y = cooking.iloc[:,len(cooking.columns)-1]
sm = SMOTE(random_state=1)
X_sm, Y_sm = sm.fit_sample(X, Y)

df_X_sm = pd.DataFrame(X_sm)
df_X_sm.columns = cooking.columns[:6714]
df_Y_sm = pd.DataFrame(Y_sm)

cooking_new = pd.concat([df_Y_sm, df_X_sm], axis = 1)
colsums = cooking_new.sum(axis = 0).reset_index(drop=True)[1:]
cooking_rd = cooking_new.iloc[:,colsums.sort_values(ascending=False).index[:2000]]
cooking_rd.insert(0,'cuisine',df_Y_sm)

train_data, test_data = train_test_split(cooking_rd, test_size = 0.2, 
                                         stratify = cooking_rd.cuisine, random_state = 1)

train_data.to_csv('../output/logistic_shiny_train_update2.csv', index=False)
test_data.to_csv('../output/logistic_shiny_test_update2.csv', index=False)
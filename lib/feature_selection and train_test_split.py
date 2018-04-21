# -*- coding: utf-8 -*-
"""
Feature Selection and Train/Test Split
@author: lw2773
"""

import pandas as pd
import re
from sklearn.feature_extraction.text import CountVectorizer
#from sklearn.decomposition import PCA
from sklearn.cross_validation import train_test_split

def feature_selection(file):
    data = pd.read_csv(file)
    train = data.iloc[:,range(1,len(data.columns))]
    
    all_ingre = []
    for i in range(len(train.index)):
        ingre_i = re.sub("[,']","",train.ingredients[i])[1:-1]
        all_ingre.append(ingre_i.lower())
    
    vec = CountVectorizer(max_features = 2000)
    bag_of_words = vec.fit_transform(all_ingre).toarray()
    
    #pca = PCA(0.99)
    #pcs = pca.fit_transform(bag_of_words)
    #pca.n_components_
    
    pcs_df = pd.DataFrame(data = bag_of_words)
    pcs_df.insert(0,'cuisine',train.cuisine)
    return pcs_df

features_data = feature_selection("../data/cooking.csv")
train_data, test_data = train_test_split(features_data, test_size = 0.25, 
                                         stratify = features_data.cuisine, random_state = 1)

train_data.to_csv('../output/train_data_new.csv', header=False, index=False)
test_data.to_csv('../output/test_data_new.csv', header=False, index=False)
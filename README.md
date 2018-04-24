# ADS Project 5 : What shall we cook tonight ?
![image](figs/cooking.jpg)
Term: Spring 2018

+ Team # 7
+ **Project Title** : What shall we cook tonight? 
+ **Team members**
	+ Anshuma Chandak (ac4258)
	+ Hanying Ji (hj2473)
	+ Lan Wen (lw2773)
	+ Qianhui Wan (qw2243)
	+ Xueying Ding (xd2196)

 
+ **Project summary**: Food is an innate part of any culture or region. Every cuisine has some unique ingredients or some ingredients that are used in almost all of its dishes. If you visit Korea, the markets would be sprawled with kimchi and the smell of squids. The colourful and aromatic spice markets of India indicate the natural use of diverse spices in the Indian cooking. In this project, we predict the category of a dish's cuisine given a list of its ingredients. We are using Yummly's data which is arranged by cuisine, dish ID, and its ingredients. We started off with 6849 ingredients, and used the **bag-of-words model** to reduce the number of ingredients to 2000. Aiming to combine and use the knowledge from other projects in this course, and build a product that has high functionality and usability, we have divided this project into two parts:
	+ The first part is to use different algorithms (**Random Forests, XGBoost, SVM, Logistic Regression, Decision Tree, KNN**) to predict the category of a dish, and aim at improving the accuracy the prediction. Following is our algorithms summary, from which we can see that **Logistic Regression** outperforms others under this situation:
	
	![image](figs/Algorithms_Summary.JPG)
	
	+ The second part is to build an R Shiny app for exploratory data analysis, as well as recommend the cuisine and other related cuisines given a set of a ingredients.

The following word clouds show the different cuisines, and the assortment of ingredients in our data set (the size reflects the number of recipes): 

![image](figs/Rplot.png)  ![image](figs/ingredients.png)

	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 

+ Anshuma Chandak :
+ Hanying Ji :
+ Lan Wen : Bag-of-words model, train/test data split, train and test Random Forest model
+ Qianhui Wan :
+ Xueying Ding :

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.



References:
+ [Kaggle Competition: What's cooking](https://www.kaggle.com/c/whats-cooking)

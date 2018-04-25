##### summary of all cuisine
setwd("/Users/JHY/Documents/2018SpringCourse/Applied Data Science/Spring2018-Project5-grp_7/app/")
library(jsonlite)
train<-fromJSON("../data/train.json")
test<-fromJSON("../data/test.json")

ingredients<-unique(unlist(train$ingredients))
cuisine_type<-unique(unlist(train$cuisine))
cooking_data<-matrix(0,nrow=dim(train),ncol=length(ingredients))
colnames(cooking_data)<-ingredients
which_ingredients<-lapply(train$ingredients,function(ingre_each){
  ingredients%in%ingre_each
})
ingredient_TF<-lapply(which_ingredients,ifelse,1,0)
for(a in 1:nrow(cooking_data)){
  cooking_data[a,]<-ingredient_TF[[a]]
}
cooking_data<-data.frame(cooking_data)
cooking_data$cuisine<-train$cuisine
cuisine_type<-unique(train$cuisine)
info_AllCuisine<-c()
for(type in cuisine_type){
  temp<-cooking_data[train$cuisine==type,1:ncol(cooking_data)-1]
  info_OneCuisine<-colSums(temp)
  info_AllCuisine<-rbind(info_AllCuisine,info_OneCuisine)
}
rownames(info_AllCuisine)<-cuisine_type

## for wordcloud
ingre_freq<-data.frame(t(info_AllCuisine))
ingre_freq$names<-colnames(info_AllCuisine)

## specific ingredients for each cuisine

info_AllCuisine_1<-info_AllCuisine
info_AllCuisine_1[info_AllCuisine_1!=0]<-1



Top10_each<-apply(info_AllCuisine,1,function(x){names(sort(x,decreasing = TRUE)[1:10])})
#Top5_each_index<-unique(unlist(list(Top5_each)))
each_Cuisine<-c()
for(i in 1:nrow(info_AllCuisine)){
  each_Cuisine[[i]]<-info_AllCuisine[colnames(Top10_each)[i],Top10_each[,i]]
}
names(each_Cuisine)<-cuisine_type
       
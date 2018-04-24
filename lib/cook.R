##### summary of all cuisine
library(jsonlite)
setwd("/Users/JHY/Documents/2018SpringCourse/Applied Data Science/Spring2018-Project5-grp_7/lib/")
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
save(cooking_data,file="cooking_data.RData")


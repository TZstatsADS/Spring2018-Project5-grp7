##### summary of all cuisine

library(shiny)
library(shinydashboard)
library(slam)
library(RColorBrewer)
library(wordcloud2)
library(ggplot2)

load("./data/train.RData")

ingredients<-unique(unlist(train$ingredients))
cuisine_type<-unique(unlist(train$cuisine))
# cooking_data<-matrix(0,nrow=dim(train),ncol=length(ingredients))
# colnames(cooking_data)<-ingredients
# which_ingredients<-lapply(train$ingredients,function(ingre_each){
#   ingredients%in%ingre_each
# })
# ingredient_TF<-lapply(which_ingredients,ifelse,1,0)
# for(a in 1:nrow(cooking_data)){
#   cooking_data[a,]<-ingredient_TF[[a]]
# }
# cooking_data<-data.frame(cooking_data)
# cooking_data$cuisine<-train$cuisine
# save(cooking_data,file="./data/cooking_data.RData")
load("./data/cooking_data.RData")

# hist<-table(cooking_data$cuisine)
# hist<-data.frame(hist)
# save(hist,file="./data/hist.RData")


# info_AllCuisine<-c()
# for(type in cuisine_type){
#   temp<-cooking_data[train$cuisine==type,1:ncol(cooking_data)-1]
#   info_OneCuisine<-colSums(temp)
#   info_AllCuisine<-rbind(info_AllCuisine,info_OneCuisine)
# }
# rownames(info_AllCuisine)<-cuisine_type
# save(info_AllCuisine,file="./data/info_Allcuisine.RData")
load("./data/info_Allcuisine.RData")

# #correlation
# correlation <- cor(t(info_AllCuisine),use = "pairwise.complete.obs",method = "pearson")
# correlation <- round(correlation,4)
# weight_bestn <- function(data,n = 1){
#   neigh <- matrix(NA,nrow = 20,ncol = n)
#   for(i in 1:nrow(data)){
#     index <- order(abs(data[i,]),decreasing = TRUE)
#     index <- index[2:(n+1)]
#     #neigh[[i]] <- colnames(data)[index] 
#     neigh[i,] <- colnames(data)[index] 
#   }
#   return(neigh)
# }
# #n means how many outputs
# neigh <- weight_bestn(correlation,n = 2)
# #first column of df is input cuisine, other columns are output cuisines
# df <- cbind(rownames(correlation),neigh)
# save(df,file="./data/df.RData")
load("./data/df.RData")


## for wordcloud
# ingre_freq<-data.frame(t(info_AllCuisine))
# ingre_freq$names<-colnames(info_AllCuisine)
# save(ingre_freq,file="./data/ingre_freq.RData")
load("./data/ingre_freq.RData")

## specific ingredients for each cuisine
# info_AllCuisine_1<-info_AllCuisine
# info_AllCuisine_1[info_AllCuisine_1!=0]<-1
# save(info_AllCuisine_1,file="./data/info_AllCuisine_1.RData")
load("./data/info_AllCuisine_1.RData")

# 
# Top10_each<-apply(info_AllCuisine,1,function(x){names(sort(x,decreasing = TRUE)[1:10])})
# #Top5_each_index<-unique(unlist(list(Top5_each)))
# each_Cuisine<-c()
# for(i in 1:nrow(info_AllCuisine)){
#   each_Cuisine[[i]]<-info_AllCuisine[colnames(Top10_each)[i],Top10_each[,i]]
# }
# names(each_Cuisine)<-cuisine_type
#        

load("./data/logistic_model_shiny.RData")
# ingre2000<-names(sort(colSums(cooking_data[,-ncol(cooking_data)]),decreasing=TRUE)[1:2000])
# save(ingre2000,file="./data/ingre2000.RData")
load("./data/ingre2000.RData")
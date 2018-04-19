##### summary of all cuisine
cuisine_type<-unique(cooking_data$cuisine)
info_AllCusine<-c()
for(type in cuisine_type){
  temp<-cooking_data[cooking_data$cuisine==type,2:ncol(cooking_data)]
  info_OneCuisine<-colSums(temp)
  info_AllCusine<-rbind(info_AllCusine,info_OneCuisine)
}
rownames(info_AllCusine)<-cuisine_type

Top5_each<-apply(info_AllCusine,1,function(x){names(sort(x,decreasing = TRUE)[1:5])})
Top5_each_index<-unique(unlist(list(Top5_each)))

       
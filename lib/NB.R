##################################
####Naive Bayes###################
##################################

library(e1071)

NB_model<-naiveBayes(as.factor(cuisine)~.,data=train_data)
prediction_NB <- predict(NB_model, test_data[,-1],type="class")
table(prediction_NB,test_data$cuisine)
mean(prediction_NB!=test_data[,1]) # 0.6523532
mean(prediction_NB!=train_data[,1]) # 0.9329199


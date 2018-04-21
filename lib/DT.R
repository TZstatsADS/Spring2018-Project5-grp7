####### Decision Tree ##########
###############################

colnames(train_data)[1] <- "cuisine"
colnames(test_data)[1] <- "cuisine"
library(rpart)
library(rpart.plot)
library(caret)
set.seed(9000)
tree <- rpart(cuisine ~ ., train_data, method = "class", control = rpart.control(cp = 0.001, usesurrogate = 2))
prp(tree)

prediction <- predict(tree, test_data[,-1], type = "class")
table(prediction,test_data$cuisine)


mean(prediction!=test_data[,1])  #0.5555109
ALL(tree)


##############################
ALL=function(model){
  trainPred=predict(model, newdata = train_data, type = "class")
  trainTable=table(train_data$cuisine, trainPred)
  testPred=predict(model, newdata=test_data, type="class")
  testTable=table(test_data$cuisine, testPred)
  trainAcc=(trainTable[1,1]+trainTable[2,2]+trainTable[3,3])/sum(trainTable)
  testAcc=(testTable[1,1]+testTable[2,2]+testTable[3,3])/sum(testTable)
  message("Contingency Table for Training Data")
  print(trainTable)
  message("Contingency Table for Test Data")
  print(testTable)
  message("Accuracy")
  print(round(cbind(trainAccuracy=trainAcc, testAccuracy=testAcc),3))
}
##############################
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

prediction <- predict(tree, test_data, type = "class")
table(prediction,test_data$cuisine)

mean(prediction!=train_data[,1]) #0.870533
mean(prediction!=test_data[,1])  #0.5555109

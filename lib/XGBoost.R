library(glmnet)
library(xgboost)
library(dplyr)

xgb_variables<-as.matrix(train_data[,-1]) # Full dataset
xgb_variables<-xgb_variables*1.0


xgb_label<-as.factor(train_data$cuisine)
dat<-cbind(xgb_label,xgb_variables)


#levels(xgb_label)<-c(0:20)
#xgb_label<-as.integer(xgb_label)


colnames(dat)[1]<-"label"
new<- cbind((dat[,1]-1,dat)

#train and test set prep

set.seed(500)
# Train and test split
train_index<-sample(1:nrow(dat),0.7*nrow(dat))

xgb_variables<-as.matrix(dat[,-1]) # Full dataset
xgb_label<-dat[,1] # Full label

# Split train data
xgb_train<-xgb_variables[train_index,]
train_label<-xgb_label[train_index]
train_matrix<-xgb.DMatrix(data = xgb_train, label=train_label)

# Split test data
xgb_test<-xgb_variables[-train_index,]
test_label<-xgb_label[-train_index]
test_matrix<-xgb.DMatrix(data = xgb_test, label=test_label)


# Basic model
basic <- xgboost(data = train_matrix, label = train_label,
                max.depth=3,eta=0.01,nthread=2,nround=2,
                objective = "multi:softprob",
                eval_metric = "mlogloss",
                num_class = 21)

pred = predict(basic, test_matrix)
prediction<-matrix(pred,nrow = 21,ncol = length(pred)/21) %>%
  t() %>%
  data.frame() %>%
  mutate(label=test_label+1,max_prob=max.col(.,"last"))

## confusion matrix of test set
confusionMatrix(factor(prediction$label),factor(prediction$max_prob),mode = "everything")
# 53 % accuracy

################################
# Tune the model
xgb_params_5 = list(objective="multi:softprob",
                    eta = 0.01,
                    max.depth = 3,
                    eval_metric = "mlogloss",
                    num_class = 21)

# fit the model with arbitrary parameters
xgb_5 = xgboost(data = train_matrix, 
                label = train_label,
                params = xgb_params_5,
                nrounds = 20)

# cross validation
xgb_cv_5 = xgb.cv(params = xgb_params_5,
                  data = train_matrix, 
                  nrounds = 20,
                  nfold = 5,
                  showsd = T,
                  stratified = T,
                  verbose = F,
                  prediction = T)

# set up the cross validated hyper-parameter search
xgb_grid_5 = expand.grid(nrounds=c(20,25,50),
                         eta = c(1,0.1,0.01),
                         max_depth = c(2,4,6,8,10),
                         gamma=1,
                         colsample_bytree=0.5,
                         min_child_weight=2,
                         subsample = 1)

# pack the training control parameters
xgb_trcontrol_5 = trainControl(method = "cv",
                               number = 5,
                               verboseIter = T,
                               returnData = F,
                               returnResamp = "all",
                               allowParallel = T)

# train the model for each parameter combination in the grid

ptm <- proc.time() ## start the time
xgb_train_5 = train(x=train_matrix, y=train_label,
                    trControl = xgb_trcontrol_5,
                    tuneGrid = xgb_grid_5,
                    method = "xgbTree")

ptm2 <- proc.time()
ptm2- ptm ## stop the clock




head(xgb_train_5$results[with(xgb_train_5$results,order(RMSE)),],5)
# get the best model's parameters
xgb_train_5$bestTune


bst = xgboost(data=train_matrix,max.depth=10,eta=0.1,nthread=2,nround=50,colsample_bytree=0.5,min_child_weight=2,subsample=1,objective="multi:softprob",eval_metric="mlogloss",num_class=21)

pred = predict(bst, test_matrix)
prediction<-matrix(pred,nrow = 21,ncol = length(pred)/21) %>%
  t() %>%
  data.frame() %>%
  mutate(label=test_label+1,max_prob=max.col(.,"last"))

## confusion matrix of test set
confusionMatrix(factor(prediction$label),factor(prediction$max_prob),mode = "everything")

#67.83 accuracy

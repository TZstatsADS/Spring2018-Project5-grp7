load("../output/info_AllCuisine.RData")
correlation <- cor(t(info_AllCuisine),use = "pairwise.complete.obs",method = "pearson")
correlation <- round(correlation,4)

#function
weight_bestn <- function(data,n = 1){
  neigh <- matrix(NA,nrow = 20,ncol = n)
  for(i in 1:nrow(data)){
    index <- order(abs(data[i,]),decreasing = TRUE)
    index <- index[2:(n+1)]
    #neigh[[i]] <- colnames(data)[index] 
    neigh[i,] <- colnames(data)[index] 
  }
  return(neigh)
}

#n means how many outputs
neigh <- weight_bestn(correlation,n = 2)
#first column of df is input cuisine, other columns are output cuisines
df <- cbind(rownames(correlation),neigh)
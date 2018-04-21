train_data <- read.csv("../output/train_data_new.csv", header = FALSE, stringsAsFactors = FALSE)
save(train_data, file = "../output/train_data_new.RData")

test_data <- read.csv("../output/test_data_new.csv", header = FALSE, stringsAsFactors = FALSE)
save(test_data, file = "../output/test_data_new.RData")
train_data <- read.csv("../output/train_data.csv", header = FALSE, stringsAsFactors = FALSE)
save(train_data, file = "../output/train_data.RData")

test_data <- read.csv("../output/test_data.csv", header = FALSE, stringsAsFactors = FALSE)
save(test_data, file = "../output/test_data.RData")
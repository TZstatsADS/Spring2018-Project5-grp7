########################################################
#################Plot of most used ingredients############
#Word Cloud of most used ingredients#####################
########################################################
library(jsonlite)
train <- fromJSON("/Users/JHY/Downloads/train.json")
test <- fromJSON("/Users/JHY/Downloads/test.json")
test$cuisine <-NA
combi <- rbind(train,test)

#creat corpus
corpus<-Corpus(VectorSource(combi$ingredients))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, c(stopwords('english')))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- tm_map(corpus, stemDocument)
corpus <- Corpus(VectorSource(corpus))
frequencies <- DocumentTermMatrix(corpus)

freq <- colSums(as.matrix(frequencies))

library(wordcloud2)
set.seed(142)
#plot word cloud
wordcloud(names(freq), freq, min.freq =2500 , random.order=FALSE, colors = brewer.pal(8, "Dark2"))




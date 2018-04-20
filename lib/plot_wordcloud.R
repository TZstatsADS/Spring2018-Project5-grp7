########################################################
#################Plot of most used ingredients############
#Word Cloud of most used ingredients#####################
########################################################




install.packages('jsonlite')
library(jsonlite)
train <- fromJSON("/Users/anshuma/Downloads/train.json")
test <- fromJSON("/Users/anshuma/Downloads/test.json")
#add dependent variable
test$cuisine <- NA
#combine data set
combi <- rbind(train, test)
library(tm)
#create corpus
corpus <- Corpus(VectorSource(combi$ingredients))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, c(stopwords('english')))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- Corpus(VectorSource(corpus))
frequencies <- DocumentTermMatrix(corpus) 

freq <- colSums(as.matrix(frequencies))
length(freq)
ord <- order(freq)

sparse <- removeSparseTerms(frequencies, 1 - 3/nrow(frequencies))
word_f <- data.frame(word = names(freq), freq = freq)
library(ggplot2)
plot_in <- ggplot(subset(word_f, freq >10000), aes(x = word, y = freq))
plot_in <- plot_in + theme(axis.text.x=element_text(angle=45, hjust=1))
plot_in

#create wordcloud
library(wordcloud)
set.seed(142)
#plot word cloud
wordcloud(names(freq), freq, min.freq = 2500, scale = c(6, .1), colors = brewer.pal(4, "Spectral"))




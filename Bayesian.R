df = read.csv('sms_spam.csv')
str(df)

#convert to factor
df$type = factor(df$type)
str(df)

table(df$type)

#install.packages('tm')
library(tm)

df_corpus = VCorpus(VectorSource(df$text))
print(df_corpus)

#spam here
as.character(df_corpus[[20]])

#make everything lowercase
clean_corpus = tm_map(df_corpus,content_transformer(tolower))
as.character(clean_corpus[[20]])

#remove numbers
clean_corpus = tm_map(clean_corpus, removeNumbers)
as.character(clean_corpus[[20]])

#remove stop words
clean_corpus = tm_map(clean_corpus, removeWords, stopwords())
as.character(clean_corpus[[20]])

#remove punctuation
clean_corpus = tm_map(clean_corpus, removePunctuation)
as.character(clean_corpus[[20]])

#stem words
install.packages('SnowballC')
library(SnowballC)
#wordstem converts to the root words
wordStem(c('play','played'))

#stem words
clean_corpus = tm_map(clean_corpus, stemDocument)
as.character(clean_corpus[[20]])

#remove white spaces
clean_corpus = tm_map(clean_corpus, stripWhitespace)
as.character(clean_corpus[[20]])

#use lapply to see many lines
lapply(clean_corpus[3:5],as.character)

df_test_matrix = DocumentTermMatrix(clean_corpus)

#create tts
t_prop = .75
trainbound = round(nrow(df_test_matrix) * t_prop)
df_train = df_test_matrix[1:trainbound, ]
df_test = df_test_matrix[(trainbound+1):nrow(df_test_matrix), ]

#create target variables
df_train_target = df_test_matrix[1:trainbound, 1]
df_test_target = df_test_matrix[(trainbound+1):nrow(df_test_matrix), 1]

#install.packages("wordcloud")
library('wordcloud')

#wordcloud(clean_corpus, min.freq = 50, random.order = F)

spam = subset(df, type = 'spam')
ham = subset(df, type = 'ham')

#wordcloud(spam$text, max.word = 5, scale = c(5,.5))

#find words over 5 times
findFreqTerms(df_train, 5)
word_frequency = findFreqTerms(df_train, 5)

#get the dtm with words only 5 or more appearances to limit features
dtm_frequency_train = (df_train [ , word_frequency])
dtm_frequency_test = (df_train [ , word_frequency])

convert_counts = function(x){
  x = ifelse(x > 0, 'yes','no')
}

sms_train = lapply(dtm_frequency_train, margin = 2, convert_counts)

sms_test = lapply(dtm_frequency_test, margin = 2, convert_counts)

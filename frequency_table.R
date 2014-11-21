# frequency_table.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(tm)
library(RWeka)
library(data.table)
library(dplyr)

# ngram tokaniser
min_words <- 2L
max_words <- 2L
bigram_token <- function(x) NGramTokenizer(x, Weka_control(min = min_words, max = max_words))
min_words <- 3L
max_words <- 3L
trigram_token <- function(x) NGramTokenizer(x, Weka_control(min = min_words, max = max_words))

# sample data
sample_news %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace ) -> vc_news

# frequency unigrams
news_corpus %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE)
                      ) -> tdm_unigram

tdm_unigram %>%
  as.matrix %>%
  rowSums -> unigram_freq

# create corpus
vc_news %>%
  VectorSource %>%
  VCorpus -> news_corpus
inspect(news_corpus)

# bigram Term-Document Matrix
news_corpus %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE,
                                      tokenize = trigram_token)
                      ) -> tdm_trigram

# aggregate frequencies
tdm_trigram %>%
  as.matrix %>%
  rowSums -> freq_table

# normalise by unigram count
df2 <- sweep(df, 2, unigram_freq, "/")

# repeat by frequency
freq_table %>%
  names %>%
  rep( times = freq_table ) -> freq_table

freq_table %>%
  strsplit(split=" ") -> freq_table

freq_table <- do.call(rbind, Filter(lengthIs(3), freq_table))

freq_table %>%
  data.frame( stringsAsFactors = FALSE ) -> df
tail(df,100)




df %>%
  data.frame( stringsAsFactors = TRUE ) -> df
rownames(df) <- NULL
df



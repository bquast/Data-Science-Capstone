# construct_frequency_table.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(tm)
library(RWeka)
library(dplyr)

# load the sample data
load("sample.RData")

# ngram tokaniser
n <- 2L
bigram_token <- function(x) NGramTokenizer(x, Weka_control(min = n, max = n))
n <- 3L
trigram_token <- function(x) NGramTokenizer(x, Weka_control(min = n, max = n))

# check length function
lengthIs <- function(n) function(x) length(x)==n

# sample data
sample_news %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace ) -> vc_news

# frequency unigrams
vc_news %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE,
                                      wordLengths = c( 1, Inf) )
                      ) -> tdm_unigram

tdm_unigram %>%
  as.matrix %>%
  rowSums -> freq_unigram

news_levels <- unique(tdm_unigram$dimnames$Terms)

# bigram Term-Document Matrix
vc_news %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE,
                                      wordLengths = c( 1, Inf),
                                      tokenize = trigram_token)
                      ) -> tdm_trigram

# aggregate frequencies
tdm_trigram %>%
  as.matrix %>%
  rowSums -> freq_trigram

# repeat by frequency
freq_trigram %>%
  names %>%
  rep( times = freq_trigram ) -> freq_trigram

# split the trigram into three columns
freq_trigram %>%
  strsplit(split=" ") -> freq_trigram

# filter out those of less than three columns
freq_trigram <- do.call(rbind, 
                        Filter( lengthIs(3),
                                freq_trigram )
                        )

# transform to data.frame encode as factors
X1 <- factor(freq_trigram[,1], levels = news_levels)
X2 <- factor(freq_trigram[,2], levels = news_levels)
Y <- factor(freq_trigram[,3], levels = news_levels)

df_trigram <- data.frame(X1, X2, Y)
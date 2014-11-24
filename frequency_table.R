# frequency_table.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(tm)
library(RWeka)
library(data.table)
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
                                      removeNumbers = TRUE)
                      ) -> tdm_unigram

tdm_unigram %>%
  as.matrix %>%
  rowSums -> freq_unigram

# bigram Term-Document Matrix
vc_news %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE,
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
freq_trigram %>%
  data.frame( stringsAsFactors = TRUE ) -> df_trigram
head(df_trigram)
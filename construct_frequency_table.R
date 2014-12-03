# construct_frequency_table.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(tm)
library(RWeka)
library(dplyr)
library(magrittr)

# load the sample data
load("sample_data.RData")

# ngram tokaniser
n <- 2L
bigram_token <- function(x) NGramTokenizer(x, Weka_control(min = n, max = n))
n <- 3L
trigram_token <- function(x) NGramTokenizer(x, Weka_control(min = n, max = n))

# check length function
length_is <- function(n) function(x) length(x)==n

# contruct single corpus from sample data
vc_blogs <-
  sample_blogs %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace )

vc_news <-
  sample_news %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace )

vc_twitter <-
  sample_twitter %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace )

vc_all <- c(vc_blogs, vc_news, vc_twitter)

# frequency unigrams
tdm_unigram <-
  vc_all %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE,
                                      wordLengths = c( 1, Inf) )
                      )

freq_unigram <- 
  tdm_unigram %>%
  as.matrix %>%
  rowSums

# write all unigrams to a list
# in order to create uniform levels of factors
unigram_levels <- unique(tdm_unigram$dimnames$Terms)

# trigram Term-Document Matrix
tdm_trigram <-
  vc_all %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE,
                                      wordLengths = c( 1, Inf),
                                      tokenize = trigram_token)
                      )

# aggregate frequencies
tdm_trigram %>%
  as.matrix %>%
  rowSums -> freq_trigram

# repeat by frequency
freq_trigram %<>%
  names %>%
  rep( times = freq_trigram )

# split the trigram into three columns
freq_trigram %<>%
  strsplit(split=" ")

# filter out those of less than three columns
freq_trigram <- do.call(rbind, 
                        Filter( length_is(3),
                                freq_trigram )
                        )

# transform to data.frame encode as factors
df_trigram <- data.frame(X1 = factor(freq_trigram[,1], levels = unigram_levels),
                         X2 = factor(freq_trigram[,2], levels = unigram_levels),
                         Y  = factor(freq_trigram[,3], levels = unigram_levels) )

# save data frame
save( df_trigram, unigram_levels, file = "df_trigram.RData")
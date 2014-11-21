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
zin <- "dit is een paar lange nederlandse zin met niet al de veel de zelfde woorden maar wel ten minste een paar"

# frequency
zin %>%
  strsplit( split = " ") %>%
  table -> woorden
woorden

# create corpus
zin %>%
  VectorSource %>%
  VCorpus -> zin_corpus
inspect(zin_corpus)

# bigram Term-Document Matrix
zin_corpus %>%
  TermDocumentMatrix( control = list(tokenize = trigram_token) ) -> zin_tdm

# aggregate frequencies
zin_tdm %>%
  as.matrix %>%
  rowSums -> zin_freq_table

# repeat by frequency
zin_freq_table %>%
  names %>%
  rep( times = zin_freq_table ) -> zin_freq_table
zin_freq_table

zin_freq_table %>%
  strsplit(split=" ") %>%
  data.frame %>%
  t %>%
  data.frame( stringsAsFactors = TRUE ) -> zin_df
rownames(zin_df) <- NULL
zin_df
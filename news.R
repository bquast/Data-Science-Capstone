# news.R
# Bastiaan Quast
# bquast@gmail.com


# load the magrittr package for piping
library(magrittr)

# load the data
load("news.RData")

# load the text mining package 'tm'
library(tm)

# create the corpus
news %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus -> vc_news

vc_news %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE,
                                     removeNumbers=TRUE,
                                     stopwords = TRUE,
                                     removeSparseTerms=0.8
                                     )
                      ) -> tdm_news

tdm_news %>%
  findFreqTerms( lowfreq=100000 )

# save tdm and free space
tdm_news %>%
  save( file = "tdm_news.RData" )

rm( tdm_news )
gc()

# n-grams

# load the RWeka library
library(RWeka)

# construct bi-gram tokanizer and tri-gram tokanizer
BiGramTokenizer <- function(x) NGramTokenizer(x,
                                              Weka_control(min = 2, max = 2)
                                              )

TriGramTokenizer <- function(x) NGramTokenizer(x,
                                               Weka_control(min = 3, max = 3)
                                               )

# construct TDMs for bigrams
vc_news %>%
  TermDocumentMatrix(control = list(removePunctuation=TRUE,
                                    removeNumbers=TRUE,
                                    stopwords = TRUE,
                                    removeSparseTerms=0.8,
                                    tokenize = BiGramTokenizer
                                    )
                     ) -> tdm_bi_news

# list bi-grams with at least 500 occurances
tdm_bi_news %>%
  findFreqTerms( lowfreq=500 ) -> bi_news

bi_news

# save tdm bigrams and free space
tdm_bi_news %>%
  save( file = "tdm_bi_news.RData" )

rm(tdm_bi_news)
gc()

# construct TDMs for bigrams
vc_news %>%
  TermDocumentMatrix(control = list(removePunctuation=TRUE,
                                    removeNumbers=TRUE,
                                    stopwords = TRUE,
                                    removeSparseTerms=0.8,
                                    tokenize = TriGramTokenizer
                                    )
                     ) -> tdm_tri_news


# list tri-grams with at least 50 occurances
tdm_tri_news %>%
  findFreqTerms( lowfreq=50 ) -> tri_news

tri_news

# save tdm bigrams and free space
tdm_tri_news %>%
  save( file = "tdm_tri_news.RData" )

rm(tdm_tri_news)
gc()
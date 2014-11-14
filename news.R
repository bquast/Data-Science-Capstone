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
                                     removeSparseTerms=0.8
                                     )
                      ) -> tdm_news

tdm_news %>%
  findFreqTerms( lowfreq=100000 )

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

# construct TDMs for bi and tri grams
vc_news %>%
  TermDocumentMatrix(control = list(removePunctuation=TRUE,
                                    removeNumbers=TRUE,
                                    removeSparseTerms=0.8,
                                    tokenize = BiGramTokenizer
                                    )
                     ) -> tdm_bi_news

save( tdm_bi_news, file = "tdm_bi_news.RData")

vc_news %>%
  TermDocumentMatrix(control = list(removePunctuation=TRUE,
                                    removeNumbers=TRUE,
                                    removeSparseTerms=0.8,
                                    tokenize = BiGramTokenizer
                                    )
                     ) -> tdm_tri_news

save( tdm_tri_news, file = "tdm_tri_news.RData")

# list bi-grams with at least 500 occurances
tdm_bi_news %>%
  findFreqTerms( lowfreq=500 ) -> bi_news

# list tri-grams with at least 50 occurances
tdm_tri_news %>%
  findFreqTerms( lowfreq=50 ) -> tri_news


# tm.R
# Bastiaan Quast
# bquast@gmail.com

# load the magrittr package for piping
library(magrittr)

# load the data
load("sample.RData")

# load the text mining package 'tm'
library(tm)

# load create the corpus for each source
# blogs
sample_blogs %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus -> vc_blogs

vc_blogs %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE, removeNumbers=TRUE) ) -> tdm_blogs

tdm_blogs %>%
  findFreqTerms( lowfreq=1000 )

# news
news %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus -> vc_news

vc_news %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE, removeNumbers=TRUE, removeSparseTerms=0.8 ) ) -> tdm_news

tdm_news %>%
  findFreqTerms( lowfreq=100000 )

# twitter
twitter %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus -> vc_twitter

vc_twitter %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE, removeNumbers=TRUE) ) -> tdm_twitter

tdm_twitter %>%
  findFreqTerms( lowfreq=1000 )


# n-grams

# load the RWeka library
library(RWeka)

# construct bi-gram tokanizer and tri-gram tokanizer
BiGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TriGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

# find bigrams in blogs
tdm_bi_blogs <- TermDocumentMatrix(vc_blogs, control = list(tokenize = BiGramTokenizer))
tdm_tri_blogs <- TermDocumentMatrix(vc_blogs, control = list(tokenize = TriGramTokenizer))

# list bi-grams with at least 500 occurances
tdm_bi_blogs %>%
  findFreqTerms( lowfreq=500 ) -> bi_blogs

# list tri-grams with at least 50 occurances
tdm_tri_blogs %>%
  findFreqTerms( lowfreq=50 ) -> tri_blogs

# find bigrams in news
tdm_bi_news <- TermDocumentMatrix(vc_news, control = list(tokenize = BiGramTokenizer))
tdm_tri_news <- TermDocumentMatrix(vc_news, control = list(tokenize = TriGramTokenizer))

# list bi-grams with at least 500 occurances
tdm_bi_news %>%
  findFreqTerms( lowfreq=500 ) -> bi_news

# list tri-grams with at least 50 occurances
tdm_tri_news %>%
  findFreqTerms( lowfreq=50 ) -> tri_news

# find bigrams in twitter
tdm_bi_twitter <- TermDocumentMatrix(vc_twitter, control = list(tokenize = BiGramTokenizer))
tdm_tri_twitter <- TermDocumentMatrix(vc_twitter, control = list(tokenize = TriGramTokenizer))

# list bi-grams with at least 500 occurances
tdm_bi_twitter %>%
  findFreqTerms( lowfreq=500 ) -> bi_twitter

# list tri-grams with at least 50 occurances
tdm_tri_twitter %>%
  findFreqTerms( lowfreq=50 ) -> tri_twitter

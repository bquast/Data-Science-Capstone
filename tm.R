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
  VCorpus %>%
  tm_map( stripWhitespace ) -> vc_blogs

# news
sample_news %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace ) -> vc_news

# twitter
sample_twitter %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace ) -> vc_twitter

vc_all <- c(vc_blogs, vc_news, vc_twitter)

vc_all %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE,
                                     removeNumbers=TRUE,
                                     stopwords = TRUE,
                                     removeSparseTerms=0.8  )
                      ) -> tdm_sparse

vc_all %>%
  DocumentTermMatrix( control = list(removePunctuation=TRUE,
                                     removeNumbers=TRUE,
                                     stopwords = TRUE,
                                     removeSparseTerms=0.8  )
  ) -> dtm_sparse

tdm_sparse %>%
  save( file = "tdm_sparse.RData" )

rm(tdm_sparse)
gc()

# n-grams

# load the RWeka library
library(RWeka)

# construct bi-gram tokanizer and tri-gram tokanizer
BiGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TriGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

# find bigrams in blogs
vc_all %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE,
                                     removeNumbers=TRUE,
                                     stopwords = TRUE,
                                     removeSparseTerms=0.8,
                                     tokenize = BiGramTokenizer)
  ) -> tdm_bi_sparse

tdm_bi_sparse %>%
  save( file = "tdm_bi_sparse.RData" )

# list bi-grams with at least 5000 occurances
tdm_bi_sparse %>%
  findFreqTerms( lowfreq=2000 ) -> bi_grams_2000
bi_grams_2000

rm(tdm_bi_sparse)
gc()

vc_all %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE,
                                     removeNumbers=TRUE,
                                     stopwords = TRUE,
                                     removeSparseTerms=0.8,
                                     tokenize = TriGramTokenizer)
  ) -> tdm_tri_sparse


# list tri-grams with at least 50 occurances
tdm_tri_sparse %>%
  findFreqTerms( lowfreq=1 ) -> tri_grams
tri_grams

tdm_tri_sparse %>%
  save( file = "tdm_tri_sparse.RData" )

rm(tdm_tri_sparse)
gc()
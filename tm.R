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
sample_news %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus -> vc_news

vc_news %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE, removeNumbers=TRUE) ) -> tdm_news

tdm_news %>%
  findFreqTerms( lowfreq=1000 )

# twitter
sample_twitter %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus -> vc_twitter

vc_twitter %>%
  TermDocumentMatrix( control = list(removePunctuation=TRUE, removeNumbers=TRUE) ) -> tdm_twitter

tdm_twitter %>%
  findFreqTerms( lowfreq=1000 )
# frequency_table.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(tm)
library(dplyr)

# sample data
zin <- "een lange nederlandse zin met niet al de veel de zelfde woorden maar wel ten minste een"

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

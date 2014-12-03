# import_data.R
# Bastiaan Quast
# bquast@gmail.com
# ------------------

# load the stingi library for text manipulation
library(stringi)

# inspect the data
list.files("final")
list.files("final/en_US")

# import the blogs and twitter datasets in text mode
blogs <- readLines("final/en_US/en_US.blogs.txt", encoding="UTF-8")
twitter <- readLines("final/en_US/en_US.twitter.txt", encoding="UTF-8")

# import the news dataset in binary mode
con <- file("final/en_US/en_US.news.txt", open="rb")
news <- readLines(con, encoding="UTF-8")
close(con)
rm(con)

# drop non UTF-8 characters
twitter <- iconv(twitter, from = "latin1", to = "UTF-8", sub="")
twitter <- stri_replace_all_regex(twitter, "\u2019|`","'")
twitter <- stri_replace_all_regex(twitter, "\u201c|\u201d|u201f|``",'"')

# save the data to an .RData files
save(blogs, file="blogs.RData")
save(news, file="news.RData")
save(twitter, file="twitter.RData")
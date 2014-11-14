# Import.R
# Bastiaan Quast
# bquast@gmail.com
# ------------------

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

# clean the twitter dataset from non UTF-8 emoticons
blogs <- iconv(blogs, from = "latin1", to = "UTF-8", sub="")
news <- iconv(news, from = "latin1", to = "UTF-8", sub="")
twitter <- iconv(twitter, from = "latin1", to = "UTF-8", sub="")

# save the data to an .RData files
save(blogs, file="blogs.RData")
save(news, file="news.RData")
save(twitter, file="twitter.RData")
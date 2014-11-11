# Import.R
# Bastiaan Quast
# bquast@gmail.com
# ------------------

# inspect the data
list.files("final")
US_files <-list.files("final/en_US")
US_files

# import the blogs and twitter datasets in text mode
blogs <- readLines("final/en_US/en_US.blogs.txt", encoding="UTF-8")
twitter <- readLines("final/en_US/en_US.twitter.txt", encoding="UTF-8")

# import the news dataset in binary mode
con <- file("final/en_US/en_US.news.txt", open="rb")
news <- readLines(con, encoding="UTF-8")
close(con)

# clean the twitter dataset from non UTF-8 emoticons
twitter <- iconv(twitter, from = "latin1", to = "UTF-8", sub="")

# save the data to an .RData file
save(blogs, news, twitter, file="en_US.RData")
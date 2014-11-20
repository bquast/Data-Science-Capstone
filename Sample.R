# Sample.R
# Bastiaan Quast
# bquast@gmail.com

# load data
load("blogs.RData")
load("news.RData")
load("twitter.RData")

# sample data (100,000 of each)
sample_blogs   <- sample(blogs, 100)
sample_news    <- sample(news, 100)
sample_twitter <- sample(twitter, 100)

# save samples
save(sample_blogs, sample_news, sample_twitter, file= "sample.RData")
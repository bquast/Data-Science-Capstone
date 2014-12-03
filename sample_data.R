# sample_data.R
# Bastiaan Quast
# bquast@gmail.com

# load data
load("blogs.RData")
load("news.RData")
load("twitter.RData")

# sample data (100,000 of each)
sample_blogs   <- sample(blogs, 1000)
sample_news    <- sample(news, 1000)
sample_twitter <- sample(twitter, 1000)

# save samples
save(sample_blogs, sample_news, sample_twitter, file= "sample_data.RData")
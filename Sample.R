# Sample.R
# Bastiaan Quast
# bquast@gmail.com

# sample data (10,000 of each)
sample_blogs   <- sample(blogs, 10000)
sample_news    <- sample(news, 10000)
sample_twitter <- sample(twitter, 10000)

# save samples

save(sample_blogs, sample_news, sample_twitter, file= "sample.Rdata")
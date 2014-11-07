# Import.R
# Bastiaan Quast
# bquast@gmail.com
# ------------------

# inspect the data
list.files("final")
US_files <-list.files("final/en_US")
US_files

# import the data into the workspace
blogs <- readLines("final/en_US/en_US.blogs.txt")
twitter <- readLines("final/en_US/en_US.twitter.txt")

con <- file("final/en_US/en_US.news.txt", open="rb")
news <- readLines(con)
close(con)

# save the data to an .RData file
save(blogs, news, twitter, file="en_US.RData")
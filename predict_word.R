# predict_word.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(e1071)

# load the model
load("tri_naiveBayes.RData")

# create a test string
test_string <- "accused of"

# split it into separate words
test_split <- strsplit(test_string, split = " " )

# encode as a factor using the same levels
test_factor <- factor(unlist(test_split), levels=unigram_levels)

# transform to data frame
test_df <- data.frame(X1 = test_factor[1], X2 = test_factor[2])

# estimate using the model
predict(tri_naiveBayes, test_df)
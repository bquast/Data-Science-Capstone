# train_model.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(e1071)
library(dplyr)

# e1071 package
tri_naiveBayes <- naiveBayes( Y ~ X1 + X2 ,
                              df_trigram )

# save the model
save(tri_naiveBayes, file = "model.RData")
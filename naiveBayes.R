# naive Bayes
# Bastiaan Quast
# bquast@gmail.com

# load the packages
library(magrittr)
library(caret)
library(e1071)
library(klaR)


# load the data
load( "tdm_tri_sparse.RData" )

# filter leading and trailing white space
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
tri_grams %>% 
  trim -> tri_grams

# string split
tri_grams %>%
  strsplit(split = " ") -> tri_grams

# filter for lenght of 3 only
lengthIs <- function(n) function(x) length(x)==n
tri_grams <- do.call(rbind, Filter(lengthIs(3), tri_grams))
tri_grams %>%
  data.frame(stringsAsFactors=TRUE) -> tri_grams

sample_tri <- sample(tri_grams, 1000)

# naive Bayes (e1071)
classifier <- naiveBayes(tri_grams[,-3], tri_grams[,3])
classifier

table(predict(classifier, tri_grams[,-3]), tri_grams[,3], dnn=list('predicted','actual'))

cf <- confusionMatrix(predict(classifier,
                              newdata=tri_grams_500[,-3]),
                      tri_grams_500[,3]
                      )


# naive Bayes (klaR)
klar.model <- train(tri_grams_500[,-3],tri_grams_500[,3],'nb')

nb.res <- NaiveBayes(tri_grams_500[,3] ~ ., data=tri_grams_500)

nb.res

nb.pred <- predict(nb.res, tri_grams_50)

klar.cf <- confusionMatrix(predict(classifier,
                                   newdata=tri_grams_50[,-3]),
                           tri_grams_50[,3]
                           )




######
# now on tdm
classifier <- naiveBayes(as.matrix(tdm_sparse), tdm_sparse$dimnames$Terms)
classifier
klar.classif <- NaiveBayes(as.matrix(tdm_sparse), tdm_sparse$dimnames$Terms)

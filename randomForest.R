# randomForest.R
# Bastiaan Quast
# bquast@gmail.com

# load the packages
library(stringi)
library(tm)
library(RWeka)
library(randomForest)
library(magrittr)
library(caret)

# load the data



# string split and make data frame

# filter leading and trailing white space
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
tri_grams_500 <- trim(tri_grams_500)

# string split
tri_grams_500 <- strsplit(tri_grams_500, split = " ")

# filter for lenght of 3 only
lengthIs <- function(n) function(x) length(x)==n
tri_grams_500 <- do.call(rbind, Filter(lengthIs(3), tri_grams_500))
tri_grams_500 <- data.frame(tri_grams_500, stringsAsFactors=TRUE)

# 


# train the model
random.forest <- train(x = tri_grams_500[,-3],
                       y = tri_grams_500[,3],
                       tuneGrid=data.frame(mtry=2),
                       trControl=trainControl(method="none")
                       )

random.forest2 <- train(x = tri_grams_500[,-3],
                        y = tri_grams_500[,3],
                        trControl=trainControl(method="none")
)

random.forest3 <- train(x = tri_grams_500[,-3],
                        y = tri_grams_500[,3],
                        method="knn",
                        tuneLength = 10,
                        trControl=trainControl(method="cv")
)

# save the model
random.forest %>%
  save( file = "random.forest.RData" )

# test the model
tri_grams_500[,-3]
predict(random.forest, newdata=tri_grams_500[,-3])
tri_grams_500[,3]


# confusion matrix
confusionMatrix(predict(random.forest,
                        newdata=tri_grams_500[,-3]),
                tri_grams_500[,3]
                )
# train_model.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(caret)
library(e1071)
library(klaR)

e1071.model <- naiveBayes( x = zin_df[,-3], y = zin_df[,3] )
e1071.model

predict(e1071.model, zin_df[,-3])
predict(e1071.model, "paar")


e1071.cf <- confusionMatrix(predict(e1071.model,
                                   newdata=zin_df[,-3]),
                           zin_df[,3]
                           )
e1071.cf


klar.model <- NaiveBayes( x = zin_df[,-3], grouping = zin_df[,3] )
klar.model

predict(klar.model, newdata = zin_df[,-3] )

klar.cf <- confusionMatrix(predict(klar.model,
                                   grouping = zin_df[,-3])$class,
                           zin_df[,3]
                           )
klar.cf

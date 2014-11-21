# train_model.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(caret)
library(e1071)
library(klaR)

e1071.model <- naiveBayes( x = df[,-3], y = df[,3] )
e1071.model

predict(e1071.model, df[,-3])
predict(e1071.model, "paar")


e1071.cf <- confusionMatrix(predict(e1071.model,
                                   newdata=df[,-3]),
                           df[,3]
                           )
e1071.cf


klar.model <- NaiveBayes( x = df[,-3], grouping = df[,3] )
klar.model

predict(klar.model, grouping = df[,-3] )
predict(klar.model, grouping = "a" )

klar.cf <- confusionMatrix(predict(klar.model,
                                   grouping = df[,-3])$class,
                           df[,3]
                           )
klar.cf

# train_model.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(caret)
library(e1071)
library(klaR)

e1071.model <- naiveBayes( X3~. ,
                           df_trigram )
e1071.model

predict(e1071.model, df_trigram[,-3])
predict(e1071.model, "http")


e1071.cf <- confusionMatrix(predict(e1071.model,
                                   newdata=df_trigram[,-3]),
                           df_trigram[,3]
                           )
head(e1071.cf$table, 10)[,1:10]


klar.model <- NaiveBayes( x = df_trigram[,-3], grouping = df_trigram[,3] )
head(klar.cf$table, 10)[,1:10]

predict(klar.model, grouping = df_trigram[,-3] )
predict(klar.model, grouping = "a" )

klar.cf <- confusionMatrix( predict(klar.model,
                                    grouping = df_trigram[,-3])$class,
                            df_trigram[,3] )
klar.cf

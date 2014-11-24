# train_model.R
# Bastiaan Quast
# bquast@gmail.com

# load the libraries
library(caret)
library(e1071)
library(klaR)

# e1071 package
e1071.model <- naiveBayes( Y ~ X1 + X2 ,
                           df_trigram )

e1071.predictions <- predict(e1071.model, df_trigram[,-3])

test_factor <- factor(c("accused", "of"), levels=news_levels)
test_df <- data.frame(X1 =test_factor[1], X2 = test_factor[2])
test_df
predict(e1071.model, test_df)

e1071.cf <- confusionMatrix( e1071.predictions,
                             df_trigram[,3] )
head(e1071.cf$table, 10)[,1:10]

# klaR package
klar.model <- NaiveBayes( df_trigram[,3] ~ ., df_trigram )

klar.predictions <- predict(klar.model, grouping = test_factor )
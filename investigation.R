library(ElemStatLearn)
library(AppliedPredictiveModeling)
library(RGtk2)
library(rattle)
library(rpart.plot)
library(pgmm)
library(caret)
library(UsingR)
library(gbm)
library(randomForest)
library(sqldf)

data(diamonds)

hist(diamonds$price, breaks=30)

train = sample(1:dim(diamonds)[1],size=dim(diamonds)[1]/4,replace=F)
train_diamonds = diamonds[train,]
test_diamonds = diamonds[-train,]

set.seed(1337)
mod_rf <- randomForest(price ~ .,data = train_diamonds)
mod_rf
#getTree(mod_rf, 1, labelVar=TRUE)

mod_lm <- lm(formula = price ~ carat + cut + color + clarity, data = diamonds)
mod_lm

rfresult <- predict(mod_rf, test_diamonds)
lmresult <- predict(mod_lm, test_diamonds)

mean(diff(rfresult - test_diamonds$price))
mean(diff(lmresult - test_diamonds$price))

#so, while the mean diff is higher it is not enough to be concern
mod_lm

hist(diamonds$carat, breaks=30)

plot(diamonds$carat,diamonds$price)
abline(lm(diamonds$price ~ diamonds$carat),col = 'blue')

diamonds_test <- diamonds[which(diamonds$carat > .5),]

test <- diamonds[which(diamonds$cut == "Fair"),]

sqldf('select distinct clarity from diamonds')

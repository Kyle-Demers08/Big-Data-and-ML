install.packages('C50')
install.packages('OneR')
install.packages('RWeka')

library('RWeka')
library(C50)
library(OneR)

df = read.csv('credit.csv', stringsAsFactor = T)
str(df)
table(df$default)
prop.table(table(df$default))
table(df$employment_duration)
table(df$savings_balance)

RNGversion('3.5.2')
set.seed(123)
train_sample = sample(1000,900)
str(train_sample)
credit_train = df[train_sample,]
credit_test = df[-train_sample,]
prop.table(table(credit_test$default))
prop.table(table(credit_train$default))
str(credit_test)
credit_model = C5.0(credit_train[-17],credit_train$default) #data without target variable, targets
credit_model
credit_pred = predict(credit_model, credit_test)
library(gmodels)
CrossTable(credit_test$default, credit_pred,
           prop.chisq = F, prop.c = F, Prop.r = F,
           dnn = c('actual', 'predicted'))
summary(credit_model)
### Using 10 trials
credit_pred3 = predict(credit_model, credit_test,trials = 10)
CrossTable(credit_test$default, credit_pred3,
           prop.chisq = F, prop.c = F, Prop.r = F,
           dnn = c('actual', 'predicted'))
train_sample2 = sample(1000,750)
str(train_sample2)
credit_train2 = df[train_sample2,]
credit_test2 = df[-train_sample2,]
prop.table(table(credit_test2$default))
prop.table(table(credit_train2$default))
str(credit_test2)
credit_model2 = C5.0(credit_train2[-17],credit_train2$default) #data without target variable, targets
credit_model2
credit_pred2 = predict(credit_model2, credit_test2)
CrossTable(credit_test2$default, credit_pred2,
           prop.chisq = F, prop.c = F, Prop.r = F,
           dnn = c('actual', 'predicted'))

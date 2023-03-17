library(FNN)

#import data set
df = read.csv('employee.csv')
View(df)
str(df)
df =df[-6]
#set factor
table(df$Success)
df$Success = factor(df$Success, levels = c('Yes','No'), labels = c('Yes','No'))
str(df)

#table of proportions

round(prop.table(table(df$Success))*100, digits = 5)
View(df_train)
#summarize data
summary(df)

#create normalize function
normalize = function(x){return((x - min(x))/(max(x)-min(x)))}

#normalize the df
df_norm = as.data.frame(lapply(df[2:25], normalize))
str(df_norm)

#create tts
trainbound = round(nrow(df_norm) * 0.6)
df_train = df_norm[1:trainbound, ]
df_test = df_norm[(trainbound+1):nrow(df_norm), ]

#create target variables
df_train_target = df[1:trainbound, 1]
df_test_target = df[(trainbound+1):nrow(df_norm), 1]
length(df_train_target)
library(class)
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 13)
sqrt(nrow(df_train))
#install.packages('gmodels')
#had to install nbd
library(gmodels)
#get accuracy
CrossTable(df_test_target,df_test_pred,prop.chisq = F)
nrow(df_norm)

library(FNN)

#import data set
df = read.csv('wisc_bc_data.csv')
View(df)
str(df)

#remove id
df = df[-1]
str(df)

table(df$diagnosis)
df$diagnosis = factor(df$diagnosis, levels = c('B','M'), labels = c('Benign','Malignant'))
str(df)

#table of proportions

round(prop.table(table(df$diagnosis))*100, digits = 5)

#summarize data
summary(df)
summary(df[c('radius_mean','area_mean','smoothness_se')])

#create normalize function
normalize = function(x){return((x - min(x))/(max(x)-min(x)))}

#test normalize function
normalize(c(1,2,3))

#normalize the df
df_norm = as.data.frame(lapply(df[2:31], normalize))
str(df_norm)
summary(df_norm[c('radius_mean','area_mean','smoothness_se')])

#create tts
df_train = df_norm[1:469, ]
df_test = df_norm[470:569, ]

#create target variables
df_train_target = df[1:469, 1]
df_test_target = df[470:569, 1]
library(class)
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 21)

#install.packages('gmodels')
#had to install nbd
library(gmodels)
#get accuracy
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

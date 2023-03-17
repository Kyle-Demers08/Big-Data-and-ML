#imports
library(class)
library(gmodels)

#read in data
df = read.csv('wisc_bc_data.csv')
View(df)
#remove id
df = df[-1]
str(df)

#make target a factor
table(df$diagnosis)
df$diagnosis = factor(df$diagnosis, levels = c('B','M'), labels = c('Benign','Malignant'))
str(df)

#create normalize function
normalize = function(x){return((x - min(x))/(max(x)-min(x)))}


#normalize the df
df_norm = as.data.frame(lapply(df[2:31], normalize))
str(df_norm)

#create tts
df_train = df_norm[1:469, ]
df_test = df_norm[470:569, ]

#create target variables
df_train_target = df[1:469, 1]
df_test_target = df[470:569, 1]

#knn where k = 2
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 2) #where k is 2
#get results
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

#knn where k = 11
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 11) #where k is 11
#get results
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

#knn where k = 26
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 26)#where k is 26
#get results
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

#create a z - score standardization function
standardize = function(x){return((x - mean(x))/sd(x))}

#standardize the data
df_std = as.data.frame(lapply(df[2:31], standardize))
str(df_norm)

#create tts
df_train = df_std[1:469, ]
df_test = df_std[470:569, ]

#create target variables
df_train_target = df[1:469, 1]
df_test_target = df[470:569, 1]
#run a knn on k = 2 with standardized data
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 2) #where k is 2
#get results
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

#knn where k = 11
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 11) #where k is 11
#get results
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

#knn where k = 26
df_test_pred = knn(train = df_train,
                   test = df_test,
                   cl = df_train_target, #factor of true classifications for training set
                   k = 26)#where k is 26
#get results
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

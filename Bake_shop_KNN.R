library(FNN)

#import data set
df = read.csv('Bake_Shop_Data.csv')
df = df[sample(1:nrow(df)), ] #shuffle the data set
View(df)

#remove id
df = df[-1]
View(df)

#switch target variable to factor
df$Target = factor(df$Target, levels = c('stayed','left'), labels = c('Stayed','Left'))

#create numeric representation of categorical variables
df$Day = factor(df$Day, levels = c('Weekday','Saturday','Sunday'), labels = c('Weekday','Saturday','Sunday'))
df$School_event = factor(df$School_event, levels = c('no','yes', labels = c('no,yes')))
df$Day = as.numeric(df$Day)
df$School_event = as.numeric(df$School_event)
str(df)

#table of proportions for our target variable
round(prop.table(table(df$Target))*100, digits = 5)
#31% of people in our data frame leave 

#create normalize function
normalize = function(x){return((x - min(x))/(max(x)-min(x)))}

# make time variable into a number

#initialize an empty vectors
holder = c()
#for every item in the data frame, split into 2 different characters 
#based on their proximity to the :
for (i in df$Time){
  holder = append(holder,strsplit(i, ':'))
}
#initialize two lists for holding hours and numbers
hours =c()
minutes = c()
for (i in holder){
  hours = append(hours,unlist(i)[1]) #pull the hour number
  minutes = append(minutes,unlist(i)[2]) #pull the minute number
}
#now we can convert these to numbers
hours = as.numeric(hours) 
minutes = as.numeric(minutes)

#initialize a list to store time
time = c()
for (i in seq(length(hours))){
  hour = hours[i] * 60 #multiply hours to convert to minutes
  ts = hour + minutes[i] #hours + minutes gives total minutes since the start of the day
  time = append(time,ts) #put into a vector
}
df$Time = time #replace time feature with the new numeric version
View(df)
#normalize the df
df_norm = as.data.frame(lapply(df[1:3], normalize))
str(df_norm)

#create tts
df_train = df_norm[1:250, ]
df_test = df_norm[250:330, ]

#create target variables
df_train_target = df[1:250, 4]
df_test_target = df[250:330, 4]
library(class)
df_test_pred = knn(train = df_train, #training set
                   test = df_test, #testing set
                   cl = df_train_target, #factor of true classifications for training set
                   k = 17) #odd number near the square root of the length of observations

library(gmodels)

#get accuracy
CrossTable(df_test_target,df_test_pred,prop.chisq = F)

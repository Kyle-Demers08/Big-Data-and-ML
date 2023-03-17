library = 'kernlab'
df = read.csv('2020happiness.csv')
#create function
normalize = function(x){return((x - min(x))/(max(x)-min(x)))}
View(df)
#standardize data frame
df = as.data.frame(lapply(df[3:9],normalize))
summary(df)
#tts
df_train = df[1:114, ]
df_test = df[114:153, ]
library(neuralnet)
RNGversion('3.5.2')
set.seed(123)
happ_model = neuralnet(formula = Happiness ~ GDP.per.capita+
                             Social.support+ Healthy.life.expectancy +
                             Freedom.to.make.life.choices+ Generosity+
                             Perceptions.of.corruption, data = df_train,
                             hidden = 1)

plot(happ_model)
#drop target var
model_results = compute(happ_model, df_test[2:7])
#find predicted happiness
predicted_happ = model_results$net.result
#find correlation(predictive power)
cor(predicted_happ, df_test$Happiness)

happ_model2 = neuralnet(Happiness ~ GDP.per.capita+
                              Social.support+ Healthy.life.expectancy +
                              Freedom.to.make.life.choices+ Generosity+
                              Perceptions.of.corruption, data = df_train,
                              hidden = 5)
plot(happ_model2)
model_results2 = compute(happ_model2, df_test[2:7])
#find predicted happiness
predicted_happ2 = model_results2$net.result
#find correlation(predictive power)
cor(predicted_happ2, df_test$Happiness)

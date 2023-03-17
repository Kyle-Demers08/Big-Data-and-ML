library = 'kernlab'
concrete = read.csv('concrete.csv')
#create function
normalize = function(x){return((x - min(x))/(max(x)-min(x)))}
View(concrete)
#standardize data frame
df = as.data.frame(lapply(concrete,normalize))
summary(df$strength)
#tts
df_train = df[1:773, ]
df_test = df[774:1000, ]
library(neuralnet)
RNGversion('3.5.2')
set.seed(123)
library(neuralnet)
concrete_model = neuralnet(formula = strength ~ cement+
                           slag+ ash+ water+ superplastic+
                           coarseagg+ fineagg+ age, data = df_train)

plot(concrete_model)
#drop target var
model_results = compute(concrete_model, df_test[1:8])
#find predicted strengths
predicted_strength = model_results$net.result
#find correlation(predictive power)
cor(predicted_strength, df_test$strength)


concrete_model2 = neuralnet(formula = strength ~ cement+
                             slag+ ash+ water+ superplastic+
                             coarseagg+ fineagg+ age, data = df_train,
                           hidden = 5)
plot(concrete_model2)
#drop target var
model_results2 = compute(concrete_model2, df_test[1:8])
#find predicted strengths
predicted_strength2 = model_results2$net.result
#find correlation(predictive power)
cor(predicted_strength2, df_test$strength)

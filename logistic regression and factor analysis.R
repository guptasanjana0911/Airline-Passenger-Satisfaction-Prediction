#Required libraries
library(readr)
library(ggplot2)
library(corrplot)
library(factoextra)
library(FactoMineR)
library(psych)
library(DescTools)
library(pROC)

#importing the dataset and cleaning it:
data<-read.csv("C:/Users/USER/Desktop/msc_sanii/airplane.csv")
head(data)
str(data)

#Factoring the characteristic columns 
data$Gender <- as.factor(data$Gender)
data$Customer.Type <- as.factor(data$Customer.Type)
data$Type.of.Travel <- as.factor(data$Type.of.Travel)
data$Class <-as.factor(data$Class)
data$satisfaction <- as.factor(data$satisfaction)

str(data)

#Checking for null values and omitting the null values
colSums(is.na(data))
data<-na.omit(data)

#Removing unneccesary columns from the dataset:
new_data <- subset(data, select = -c(X, id, satisfaction))
colnames(new_data)
dim(new_data)

#converting into numeric 
numeric_data <- new_data[, sapply(new_data, is.numeric)]
str(numeric_data)

#Normalizing (Scaling) the data
scaled_data<-scale(numeric_data)
head(scaled_data)

#Covariance matrix
cor_matrix<-cor(scaled_data)
cor_matrix[1:5,1:5]

#Covariance Plot
corrplot(cor_matrix,
         method = "color",
         col = colorRampPalette(c("blue", "white", "purple"))(200))
corrplot(cor_matrix)

#Kaiser-Meyer-olkin
KMO(cor_matrix)

#Bartlett's test
cortest.bartlett(cor_matrix,n=nrow(scaled_data))

#Scree plot
eig=eigen(cor_matrix) 
plot(eig$values, type = "b",
     xlab = "Factor Number",
     ylab = "Eigenvalue")

#Factor analysis model
fa_model=factanal(scaled_data,4,rotation = "varimax") 
fa_model

#view
print(fa_model, digits = 3, cutoff = 0.4)

fa<-factanal(x=scaled_data,factors = 5,scores = "regression") 
scores =fa$scores 
head(scores)
dim(scores)

#factor diagram
fa.diagram(fa_model$loadings, cex = 0.9)


#logistic regression
dataframe=cbind(data,scores)
dim(dataframe)
view(dataframe)
boxplot(dataframe)

model <- glm( 
  satisfaction ~ Factor1 + Factor2 + Factor3 + Factor4  + Factor5 + 
    Gender + Customer.Type + Age + Type.of.Travel + Class + 
    Departure.Delay.in.Minutes + Arrival.Delay.in.Minutes, 
  family="binomial", data=dataframe 
) 

summary(model)

# Accuracy
prob <- predict(model, type = "response")
p <- ifelse(prob > 0.5, 1, 0)
m <- table(data$satisfaction, p)
Accuracy <- sum(diag(m)) / sum(m)
Accuracy

pred<-ifelse(prob>0.5,"satisfied","netural or dissatisfed")
pred<-as.factor(pred)

#confusion matrix
conf_matrix<-table(Actual=data$satisfaction,Predicted=pred)
conf_matrix

corrplot(as.matrix(conf_matrix),
         is.corr = FALSE,
         method = "color",
         addCoef.col = "black",
         tl.col = "black",
         col = colorRampPalette(c("white", "pink"))(200))

#ROC plot
roc_obj <- roc(data$satisfaction, prob)
plot(roc_obj, col="blue4", lwd=3)
auc(roc_obj)


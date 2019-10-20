# sample.split
#install.packages("caTools")
library(caTools)

# confusion matrix
#install.packages("caret")
library(caret)
#install.packages('e1071', dependencies=TRUE)

set.seed(312)

colnames(loan_data)

####
# Our selected variables
####

loan_data.selected_fields <- subset(
  loan_data, select = c(14, 18, 9, 20, 8, 7, 15, 3, 16, 12, 1, 22, 19, 32)
)

####
# Select 80% of the data for prediction
####
sample_data <- sample.split(
  loan_data.selected_fields$loan_status, 0.8
)

####
# Use the remaining 20% not selected as our model training data
# ( supervised learning )
####
loan_data.training.data <- subset(
  loan_data.selected_fields, sample_data == TRUE
)

####
# The 80% test data subset
####
loan_data.test.data <- subset(
  loan_data.selected_fields, sample_data == FALSE
)

####
# Model Definition:
#   loanstatus is predicted by all variables present in our training data
####
loan_data.model.full <- glm(
  loan_status ~ ., data = loan_data.training.data, family = "binomial"
)

summary(loan_data.model.full)

####
# Assess Accuracy
####

threshold = 0.5
prob_full <- predict(loan_data.model.full, newdata = loan_data.test.data, type = "response")
prob_cut <- ifelse(prob_full > threshold, 'Good', 'Bad')

cTab <- table(prob_cut, loan_data.test.data$loan_status)
v <- sum(diag(cTab)) / sum(cTab)

print(paste('Proportion correctly predicted = ', v))

####
# Assess Predicitng Power
####

confusionMatrix(as.factor(prob_cut), loan_data.test.data$loan_status, positive = 'Good')

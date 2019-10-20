####
# Correlation Matrix ( exclude factors )
####
cor(loan_data[, sapply(loan_data, class) != 'factor' ])
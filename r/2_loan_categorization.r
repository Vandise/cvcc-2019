# add support for piping data
#install.packages("dplyr")
library(dplyr)

# Charged off or default loans are "Bad"
loan_data$loan_status[
    loan_data$status == 'Charged Off' || loan_data$status == 'Default'
  ] <- 'Bad'

# Fully Paid are "Good"
loan_data$loan_status[
    loan_data$status == 'Fully Paid'
  ] <- 'Good'

# Factors allow us to give Names to a boolean in this case
# Much like enum (2 values = boolean in R though)
loan_data$loan_status <- as.factor(loan_data$loan_status)

# print out count of each loan status type
loan_data %>%
  group_by(loan_status) %>%
  summarise(no_rows = length(loan_status))

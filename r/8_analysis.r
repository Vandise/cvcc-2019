set.seed(312)

####
# Include the total paid field for analysis
####
loan_data.selected_fields <- subset(loan_data, select = c(14, 18, 9, 20, 21, 8, 7, 15, 3, 16, 12, 1, 22, 19, 32))
sample_data <- sample.split(loan_data.selected_fields$loan_status, 0.80)
loan_data.training.data <- subset(loan_data.selected_fields, sample_data == TRUE)
loan_data.test.data <- subset(loan_data.selected_fields, sample_data == FALSE)

prob_full <- predict(loan_data.model.full, newdata = loan_data.test.data, type = "response")

####
# Create a profit analysis on our model based from various thresholds
####
threshold_analysis <- data.frame(
  threshold = numeric(),
  fp_rate = numeric(),
  profits = numeric(),
  losses = numeric(),
  missed = numeric(),
  net = numeric(),
  accuracy = numeric()
)

prob_full <- predict(loan_data.model.full, newdata = loan_data.test.data, type = "response")

for( threshold in seq(0.01, 0.99, by = 0.01) ) {
  pred_cut <- stats::quantile(prob_full, threshold)
  predicted_status <- if_else(prob_full > pred_cut, 'Good', 'Bad')
  #actual <- lapply(loan_data.test.data$loan_status, as.character)
  actual <- loan_data.test.data$loan_status
  
  profit_tbl <- data.frame(
    status = actual,
    predicted_status,
    total_paid = as.numeric(loan_data.test.data$totalPaid),
    loan_amount = as.numeric(loan_data.test.data$amount)
  )
  
  fptp_tbl <- cbind(actual, predicted_status)
  
  approved_loans <- fptp_tbl[predicted_status == 'Good', ]
  
  # support for older version of R on my laptop
  approved_loans[,1] <- if_else(approved_loans[,1] == '2', 'Good', 'Bad')
  
  #
  # profits include only loans we've accurately predicted to be good / paid off
  #
  profits_set <- subset(profit_tbl, status == 'Good' & predicted_status == 'Good' )
  profits <- sum(profits_set$total_paid) - sum(profits_set$loan_amount)
  
  #
  # losses includes loans that are in a bad status, but we predicted as good
  #
  losses_set <- subset(profit_tbl, status == 'Bad' & predicted_status == 'Good')
  losses <- sum(losses_set$loan_amount) - sum(losses_set$total_paid)
  
  #
  # Potential income, good loans we predicted in bad status
  # won't classify as losses as we never took the risk of the loan
  #
  missed_set <- subset(profit_tbl, status == 'Good' & predicted_status == 'Bad')
  missed <- sum(missed_set$total_paid) - sum(missed_set$loan_amount)
  
  cTab <- table(predicted_status, loan_data.test.data$loan_status)
  accuracy <- sum(diag(cTab)) / sum(cTab)
  
  threshold_analysis[nrow(threshold_analysis) + 1,] = cbind(
    threshold = threshold,
    fp_rate = (sum(approved_loans == 'Bad') / length(approved_loans)),
    profits = profits,
    losses = losses,
    missed = missed,
    net = (profits - losses),
    accuracy = accuracy
  )
}

####
# Accuracy Optimization
####

threshold_analysis[which.max(threshold_analysis$accuracy), ]


####
# Profit Optimization
####

threshold_analysis[which.max(threshold_analysis$net), ]

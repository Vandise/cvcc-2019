####
# Loans that are currently being paid off, 
# late, or in grace period have to be removed.
# We don't have a status on them yet.
####
loan_data <- loan_data[
  !(loan_data$status %in% c('Current', 'Late (16-30 days)',
                            'Late (31-120 days)')),
  ]

####
# Invalid records ( NA's ) are removed
####
loan_data <- loan_data[!is.na(loan_data$amount), ]
loan_data <- loan_data[!is.na(loan_data$rate), ]
loan_data <- loan_data[!is.na(loan_data$payment), ]
loan_data <- loan_data[!is.na(loan_data$income), ]
loan_data <- loan_data[!is.na(loan_data$length), ]
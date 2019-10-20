# remove loanID from the dataset
# Note: we discussed removing totalPaid
#       for model analysis, we're keeping this in the dataset
#       but need to ensure it isn't included in the model.
loan_data <- loan_data[ ,
  -which(names(loan_data) %in% c("loanID"))
]
# read in the CSV data to a variable loan_data
# The CSV file has headers, which will be our dataframe keys
#   similar to a hash/associative array
loan_data <- read.csv(
  "/Users/banderson/local/cvdevgroup/cvcc-2019/data/loans.csv",
  header = T
)

# Summary of each variable
summary(loan_data)

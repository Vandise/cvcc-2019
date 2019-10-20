####
# Transform Employment values (from) to (to)
####
from <- c('n/a', '< 1 year', '1 year', '2 years', '3 years', '4 years', '5 years',
          '6 years', '7 years', '8 years', '9 years', '10+ years')
to <- c("missing", '< 1 year', '1 to 3 years', '1 to 3 years', '1 to 3 years', '4 to 6 years', '4 to 6 years', '4 to 6 years', '7 to 9 years', '7 to 9 years', '7 to 9 years', '10+ years')

loan_data$length <- mapvalues(loan_data$length, from = from, to = to)
loan_data$length <- as.factor(loan_data$length)

####
# Transform Income
####
loan_data$income_cat[ loan_data$income < 9700 ] <- "< 9700"
loan_data$income_cat[ loan_data$income >= 9700 & loan_data$income <= 39475 ] <- "9700 - 39475"
loan_data$income_cat[ loan_data$income > 39475 & loan_data$income <= 84200 ] <- "39476 - 84200"
loan_data$income_cat[ loan_data$income > 84200 & loan_data$income <= 160725 ] <- "84200 - 160725"
loan_data$income_cat[ loan_data$income > 160726 & loan_data$income <= 204101 ] <- "160726 - 204101"
loan_data$income_cat[ loan_data$income > 204101 & loan_data$income <= 510300 ] <- "204102 - 510300"
loan_data$income_cat[ loan_data$income > 510300 ] <- "> 510300"

loan_data$income_cat <- as.factor(loan_data$income_cat)

####
# Inferr ratios
####

m <- summary(loan_data$revolRatio)[[3]]

loan_data <- (loan_data %>% mutate(
  revolRatio = coalesce(revolRatio, m)
))

m <- as.integer(summary(loan_data$bcOpen)[[3]])

loan_data <- (loan_data %>% mutate(
  bcOpen = coalesce(bcOpen, m)
))

m <- as.double(summary(loan_data$bcRatio)[[3]])

loan_data <- (loan_data %>% mutate(
  bcRatio = coalesce(bcRatio, m)
))

####
# Severe Skewedness in Income
####

hist(loan_data$income, main="Figure 1 - Initial Income Histogram", xlab="Income")

loan_sd <- sd(loan_data$income)*sqrt((length(loan_data$income)-1)/(length(loan_data$income)))
loan_data$income_zscore <- (loan_data$income - mean(loan_data$income)) / loan_sd

summary(loan_data$income_zscore)

####
# Normalize income
####

loan_data$income_sqrt <- sqrt(loan_data$income)
# hist(loan_data$income_sqrt, main="Figure 4 - Sqrt of Income", xlab="Sqrt - Income")
# The New Science of Winning
## An Introduction to Data Science

---

# Who?

- Benjamin J. Anderson
- Contractor - Eau Claire Development LLC
- Lead Privacy Engineer - Viacom/CBS
- Instructor at CVTC
- github.com/Vandise
- Aspiring Data Scientist

^ Dozens of research papers, all of which have been inconclusive / failures

^ I like emulation and transforming data into information

---

# What?

- What is Data Science and why should I care?
- Who are Data Scientists?
- Technologies
- Statistical Analysis with R
- Supervised Machine Learning
	- Data Exploration, Transformation, Sanitization
	- Variable Selection
	- Model Definition and Training

——-

# So what is Data Science?

Textbook Definition:

- First defined in 1960 as “Datalogy”
- It’s a multi-disciplinary field like IT!
- It’s a “Buzzword”
- Traditionally called “Data Analyst”, “Mathematician”, “Statistician”, “DBA”
- Machine Learning is a small subset of the field

^ Datalogy - a combination of statistics and computer science

——-

# Why Should I Care?

- The worlds electronic data now exceeds 2.7 zettabytes
- Anticipated to grow 60x that in the next decade
- Businesses are now collecting and storing junk/“big” data
- Cheap cloud computational resources allow the analyzation of “big” data
- Analyzation of “big” data often leads to competitive insights/gain
	- Can also be misleading i.e. Media “Pivot to Video”

^ Detect trends

^ Detect issues before they happen ( correlation / causation )

^ Prediction

——-

# Who are Data Scientists?

![inline](img/ds_intro_lead.png)

^ Forget everything the media and internet tells you

——-

# Who are Data Scientists Cont.

- Disciplined Mathematicians/Statisticians
- Often proficient in Data Warehousing and Querying Techniques
- Programming experience
	- Not often “Engineers”
- Data Delegates / Effective Communicators
- Intuitive

^ Intuitive problem solvers

^ Delegates: data presentation

——-

# Technologies

- R
	- a funky statistical/functional programming language
- Python
	- Used because of its simplicity / ML support. Not always optimal in production
- SQL
- Cloud Computing
	- ie Amazon Redshift, Google BigQuery

——-


# Maths
## A Statistics Refresher

![inline](img/frown_face.png)

——-

## Statistics - Normal Distributions & the Empirical Rule


![inline](img/norm_dist_emp.png)

——-

## Statistics - Normal Distributions Cont


- 95% of Data is within 2 standard deviations from the mean
- 99.7% of Data is within 3
- If we were to try to predict a value, we have a 95% level of confidence ( chance ) the value will be within 2 standard deviations from the mean.
- Standard Deviation???

^ chance != confidence, but easiest to relate to

——-

## Statistics - Standard Deviation


- Denoted as Sigma ( σ ) for populations
- Denoted as *s* for samples
- It’s a measure of variation or dispersion of a set of data from the mean.
- The lower, the better, and the more accurate we can be with Normal Distribution predictions

——-


## Statistics - Standard Deviation

![inline](img/sd_formula.png)

- n = the total sample size
- x-hat is the sample mean


——-

## Statistics - Variables

A value with variable results.

- Categorical ( Qualitative )
	- Multiple values / categorizations

- Boolean ( Qualitative )
	- True/False

- Quantitative
	- A value that can be counted

——-

## Statistics - Variables


- Dependent
	- The outcome of an analysis, determined by one or many variables

There’s several others, but these are the most frequent

——-

## Statistics - Sensitivity, Specificity, Accuracy

- Sensitivity
	- True-positive rate, correctly identify a positive categorical variable

- Specificity
	- True-negative rate, correctly identify a negative categorical variable

- Accuracy
	- The rate in which we are able to predict a value within a specified threshold

^ threshold is a range of values where predicted behavior is expected

——-


# Problem Statement

A bank would like to be able to identify current loans that are at risk of defaulting.

- Conservative Approach - bank misses out on potential profit, but limits losses on loan defaults
- Aggressive Approach - bank doesn’t miss potential profits, but loses profits on loan defaults

——-

# So what do we do?

Depends on the clients requirements.

- Optimize for profit ( aggressive model )
- Balanced
- Optimize for accuracy ( conservative model )

——-

## Getting to know you(r) data

- 50,000 loan applications
- 32 variables

Don’t take my word for it, let R tell us what we need to know!

^ 1. Know Your Data

——-

## Getting to know you(r) data cont.

- Variables with NA’s?
- Identify “bad” loans / loans at risk of defaulting
- What variable type are we using when identifying loans as good/bad?

^ loan “status”
^ Charged Off = bad
^ Default = bad
^ Fully Paid = good

——-


## Loan Status Preparation

**Bad Loans**

- Charged Off
- Default

**Good Loans**

- Fully Paid


^ 2. Loan Status Preparation

——-

## What variables don’t we need?

loanID:

- This unique identifier, though relevant to the bank, is not needed by our model to predict which loans may default.

employment:

- Though being employed is a significant factor when approving a loan, this dataset also contains income, which is allows us to assume employment if larger than zero.

^ 3. Exclusion of Irrelevant Variables

——-

## What variables don’t we need? cont.

totalPaid:

- This variable can only be determined after a loan has been issued and will be excluded from the test data.

state:

- The state of the bank / applicant isn't expect to impact the applicants ability to manage payments on a loan.


Other variables such as “reason” and income “verified” may be insignificant, but may contribute to likelihood of defaulting.

——-

## So exclude variables on intuition?

- Don’t ever exclude variables on intuition on first glance

- Only variables that over correct the model
	- totalPaid would do this

- There are statistical test(s) to select which variables to use in our model.
	- we’ll go over them when we build our model

——-


## Transforming Data

- Statistics likes normal distributions
- Some data follows it naturally, other times, not.
- We can generally produce normal distributions through categorical variables and data transformations
- Ie sqroot, log, cubed root, nlog

Why?

- convenience, reducing skewness, relationships

^ http://fmwww.bc.edu/repec/bocode/t/transint.html



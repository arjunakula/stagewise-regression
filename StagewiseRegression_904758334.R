############################################################# 
## Stat 202A - Homework 4
## Author: 
## Date : 
## Description: This script implements stagewise regression
## (epsilon boosting)
#############################################################

#############################################################
## INSTRUCTIONS: Please fill in the missing lines of code
## only where specified. Do not change function names, 
## function inputs or outputs. You can add examples at the
## end of the script (in the "Optional examples" section) to 
## double-check your work, but MAKE SURE TO COMMENT OUT ALL 
## OF YOUR EXAMPLES BEFORE SUBMITTING.
##
## Very important: Do not use the function "setwd" anywhere
## in your code. If you do, I will be unable to grade your 
## work since R will attempt to change my working directory
## to one that does not exist.
#############################################################

######################################
## Function 1: Stagewise regression ##
######################################

swRegression <- function(X, Y, numIter = 3000, epsilon = 0.0001){
  
  # Perform stagewise regression (epsilon boosting) of Y on X
  # 
  # X: Matrix of explanatory variables.
  # Y: Response vector
  # numIter: Number of iterations ("T" in class notes)
  # epsilon: Update step size (should be small)
  #
  # Returns a matrix containing the stepwise solution vector 
  # for each iteration.
  
  #######################
  ## FILL IN WITH CODE ##
  #######################
  p = dim(X)[2]
  T = numIter
  beta = matrix(rep(0, p), nrow = p)
  db = matrix(rep(0, p), nrow = p)
  beta_all = matrix(rep(0, p*T), nrow = p)
  R = Y
  for (t in 1:T)
  {
    for (j in 1:p)
      db[j] = sum(R*X[, j])
    j = which.max(abs(db))
    beta[j] = beta[j]+db[j]*epsilon
    R = R - X[, j]*db[j]*epsilon
    beta_all[, t] = beta
  }
  
  #matplot(t(matrix(rep(1, p), nrow = 1)%*%abs(beta_all)), t(beta_all), type = 'l')
  
  ## Function should output the matrix beta_all, the 
  ## solution to the stagewise regression problem.
  ## beta_all is p x numIter
  return(beta_all)
  
}

# s = 10
# n = 1000
# p = 100
# X = matrix(rnorm(n*p),nrow=n)
# beta_true = matrix(rep(0,p), nrow = p)
# beta_true[1:s] = 1:s
# Y = X%*%beta_true + rnorm(n)
# 
# swRegression(X,Y)


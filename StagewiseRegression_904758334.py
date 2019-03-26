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
## Very important: Do not change the working directory
## in your code. If you do, I will be unable to grade your 
## work since Python will attempt to change my working directory
## to one that does not exist.
#############################################################

######################################
## Function 1: Stagewise regression ##
######################################

import numpy as np

def swRegression(X, Y, numIter = 3000, epsilon = 0.0001):
  
  # Perform stagewise regression (epsilon boosting) of Y on X
  # 
  # X: Matrix (np.array) of explanatory variables.
  # Y: Response vector (np.array)
  # numIter: Number of iterations ("T" in class notes)
  # epsilon: Update step size (should be small)
  #
  # Returns a matrix (np.array) containing the stepwise 
  # solution vector for each iteration
  
  #######################
  ## FILL IN WITH CODE ##
  #######################
  
  n,p = X.shape
  T = numIter
  beta = np.ones((p,1),float)*0
  db = np.ones((p,1),float)*0
  
  beta_all = np.ones((p*T,1),float)*0
  beta_all = beta_all.reshape((p,T))
  
  R = np.copy(Y)
  
  for t in range(0,T):
      for j in range(0,p):
          db[j] = np.sum(R*X[:,j])
  
      max_index = 0;
      max_value = -1000;
      for k in range(0,p):
          if(abs(db[k]) > max_value):
              max_value = abs(db[k]);
              max_index = k
            
      j = max_index
      beta[j] = beta[j]+db[j]*epsilon;
      R = R - X[:,j]*db[j]*epsilon;
      beta_all[:,t] = beta[:,0] 

  ## Function should output the matrix (np.array) beta_all, the 
  ## solution to the stagewise regression problem.
  ## beta_all is p x numIter
  return beta_all

#n = 2
#p = 3
#s = 2
#X = np.array([[0.5529790, -1.2592706, -0.1905513],[0.7024872, -0.3136742, -0.9590715]])
#Y = np.array([-2.0486022, 0.6229098])
#print swRegression(X,Y)

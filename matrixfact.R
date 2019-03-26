n = 200
p = 100
d = 3
sigma = .1
prob = .2
IT = 100
lambda = .1
W_true = matrix(rnorm(p*d), nrow = p)
Z_true = matrix(rnorm(n*d), nrow = d)
epsilon = matrix(rnorm(p*n)*sigma, nrow=p)
X = W_true%*%Z_true + epsilon
R = matrix(runif(p*n)<prob, nrow = p)
W = matrix(rnorm(p*d)*.1, nrow = p)
Z = matrix(rnorm(n*d)*.1, nrow = d)
for (it in 1:IT)
{
  for (i in 1:n)
  {
    WW = t(W)%*%diag(R[,i])%*%W+lambda*diag(d)
    WX = t(W)%*%diag(R[,i])%*%X[,i]
    A = rbind(cbind(WW, WX), cbind(t(WX), 0))
    AS = mySweep(A, d)
    Z[,i] = AS[1:d, d+1]
  }
  for (j in 1:p)
  {
    ZZ = Z%*%diag(R[j, ])%*%t(Z)+lambda*diag(d)
    ZX = Z%*%diag(R[j,])%*%X[j,]
    B = rbind(cbind(ZZ, ZX), cbind(t(ZX), 0))
    BS = mySweep(B, d)
    W[j,] = BS[1:d, d+1]
  }
  sd1 = sqrt(sum(R*(X-W%*%Z)^2)/sum(R))
  sd0 = sqrt(sum((1.-R)*(X-W%*%Z)^2)/sum(1.-R))
  print(cbind(sd1, sd0))
}
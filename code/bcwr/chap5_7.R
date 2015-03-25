fun <- function(theta, y){
  mu <- theta[1]
  sigma.y <- exp(theta[2])
  sigma.b <- exp(theta[3])
  Y <- apply(y, 1,  mean)
  n <- dim(y)[2]
  S <- apply(y, 1, var) * (n-1)
  loglike <- sum(dnorm(Y, mu, sqrt(sigma.y^2/n +sigma.b^2), log = T)+
             dgamma(S, shape = (n-1)/2, rate = 1/(2*sigma.y^2), log = T))
  return(loglike + theta[2] + theta[3])
}
y <- c(1545, 1440, 1440, 1520, 1580, 
       1540, 1555, 1490, 1560, 1495, 
       1595, 1550, 1605, 1510, 1560, 
       1445, 1440, 1595, 1465, 1545, 
       1595, 1630, 1515, 1635, 1625, 
       1520, 1455, 1450, 1480, 1445)
y <- matrix(y, nrow = 6, ncol = 5, byrow = T)
fit <- laplace(fun, c(1500, 3, 3), y)
laplace(fun, c(1500, 1, 1), y)
laplace(fun, c(1500, 10, 10), y)
qnorm(c(0.05, 0.95), fit$mode[2], fit$var[2, 2]^0.5)
qnorm(c(0.05, 0.95), fit$mode[3], fit$var[3, 3]^0.5)

exp(qnorm(c(0.05, 0.95), fit$mode[2], fit$var[2, 2]^0.5))
exp(qnorm(c(0.05, 0.95), fit$mode[3], fit$var[3, 3]^0.5))
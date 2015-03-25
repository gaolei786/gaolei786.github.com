fun <- function(theta, data){
  lambda <- exp(theta)
  n0 <- data[1]
  n1 <- data[2]
  n2 <- data[3]
  n3 <- data[4]
  val <- -lambda * (n0 + n1 + n2) + 
         (n1 + 2*n2 -1)* log(lambda) + 
         n3 * log(1-exp(-lambda)*(1+lambda+
         lambda^2/2)) + theta
  return(val)
}
data <- c(11, 27, 64, 128)
library(LearnBayes)
fit <- laplace(fun, 0, data)


tpar <- list(m = fit$mode, var = fit$var, 
             df = 2)
theta <- sir(fun, tpar, 1000, data)
lambda <- exp(theta)
mean(lambda)
sd(lambda)
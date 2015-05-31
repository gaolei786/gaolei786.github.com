fun <- function(theta, data){
  y <- data[, 1]
  sigma <- data[, 2]
  mu <- theta[1]
  tau <- exp(theta[2])
  val <- sum(dnorm(y, mean = mu, sd = (sigma^2 + tau^2)^0.5, log = T)) + 
         log(tau)
  return(val)
}
data <- data.frame(y = c(28, 8, -3, 7, -1, 1, 18, 12),
                   sigma = c(15, 10, 16, 11, 9, 11, 10, 18))
library(LearnBayes)
fit <- laplace(fun, c(2, 3), data)
mycontour(fun, c(-20, 40, -7, 4), data)
set.seed(123)
r <- gibbs(fun, start = c(10, 2), 10000, c(8, 1.4), data)
points(r[[1]])
J <- 8
y <- data[, 1]
sigma <- data[, 2]
probint <- NULL
thetaj <- NULL
for(j in 1:J) {
  tau <- exp(r[[1]][, 2])
  mu <- r[[1]][, 1]
  thetaj <- cbind(thetaj, (y[j]/sigma[j]^2+mu/tau^2)/(1/sigma[j]^2+1/tau^2))
  Vj <- 1/(1/sigma[j]^2+1/tau^2)
  probint <- cbind(probint,  rnorm(10000, thetaj[,j], Vj^0.5))
}
apply(probint, 2, median)
apply(probint, 2, mean)
apply(probint, 2, sd)

B <- NULL
for (j in 1:J) {
  B <- cbind(B, tau^(-2)/( tau^(-2)+sigma[j]^(-2)))
}
B.e <- apply(B, 2, mean)
sort(B.e)
order(B.e)

sum(apply(thetaj, 1, which.max) ==1)/10000




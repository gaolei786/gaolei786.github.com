library(LearnBayes)
y <- c(15, 11, 14, 17, 5, 11, 10, 4, 8, 
       10, 7, 9, 11, 3, 6, 1, 1, 4)
fun <- function(beta, y) {
  beta0 <- beta[1]
  beta1 <- beta[2]
  inde <- 1:18
  val <- y * (beta0 + beta1 * inde) - 
           exp(beta0 + beta1 * inde)
  val <- sum(val)
  return(val)
}

fit <- laplace(fun, c(0, 0), y)
mycontour(fun, c(2.2, 3.35, -0.2, -0.01), y)

tpar <- list(m = fit$mode, var = fit$var, df = 3)
beta <- sir(fun, tpar, 1000, y)
points(beta)
mean(beta[, 2])
var(beta[, 2])
  
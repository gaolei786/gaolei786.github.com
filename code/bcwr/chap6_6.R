
library(LearnBayes)
set.seed(123)
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

proposal <- list(var = fit$var, scale = 2)
r1 <- rwmetrop(fun, proposal, start = fit$mode, m = 10000,
              y)
points(r1$par)
mean(r1$par[, 2])
sd(r1$par[, 2])


mycontour(fun, c(2.2, 3.35, -0.2, -0.01), y)
proposal <- list(mu = fit$mode, var = fit$var, scale = 2)
r2 <- indepmetrop(fun, proposal, start = fit$mode, m = 10000,y)
points(r2$par)
mean(r2$par[, 2])
sd(r2$par[, 2])

fun1 <- function(x) {
  c(quantile(x, 0.025), mean(x), quantile(x, 0.975))
}
apply(r1$par, 2, fun1) 
apply(r2$par, 2, fun1) 
r1[[2]]
r2[[2]]

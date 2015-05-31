library(LearnBayes)
fun <- function(theta, data){
  s <- data[1]
  t <- data[2]
  t1 <- data[3]
  n <- data[4]
  theta1 <- theta[1]
  theta2 <- theta[2]
  val <- theta1 + theta2 - theta1 * s - 
           (t-n*(t1-exp(theta2)))/exp(theta1)
  return(val)
}

fit <- laplace(fun, c(0.5, 0.5), data = c(8, 15962989, 
          237217, 15))

mycontour(fun, c(12, 18, 3, 15), data = c(8, 15962989, 
          237217, 15))

proposal <- list(var = fit$var, scale = 2)
r <- rwmetrop(fun, proposal, start = fit$mode, m = 10000,
              data= c(8, 15962989, 237217, 15))
points(r$par)

theta1 <- r$par[, 1]
theta2 <- r$par[, 2]
beta <- exp(theta1)
t1 <- 237217
mu <- t1 - exp(theta2)
t0 <- 10^6
R.t0 <- exp(-(t0-mu)/beta)
mean(R.t0)
sd(R.t0)



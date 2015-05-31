library(LearnBayes)
data(cancermortality)
y <- cancermortality$y
n <- cancermortality$n

fun <- function(theta, data){
  y <- data$y
  n <- data$n
  K <- exp(theta[1])
  eta <- exp(theta[2])/(1+exp(theta[2]))
  val <-   -2 * log(1+K) +
               sum(lbeta(K * eta + y, K*(1-eta) + n - y) - 
               lbeta(K * eta, K * (1-eta))) + theta[1] + 
               theta[2] + log(1+2*exp(theta[2])) - 2 * log(1+exp(theta[2]))
  return(val)
}

fit <- laplace(fun, c(0, 0), data = cancermortality)
mycontour(fun, c(-2, 14, -8, -4), data = cancermortality)


r <- gibbs(fun, fit$mode, 10000, diag(fit$var)^0.5*2, cancermortality)
r$par
r$accept
points(r$par)

K <- exp(r$par[, 1])
eta <- exp(r$par[, 2])/(1+exp(r$par[, 2]))

quantile(K, c(0.05, 0.95))
quantile(eta, c(0.05, 0.95))

p <- NULL
for(j in 1:20) {
  aj <- K * eta + y[j] 
  bj <- K * (1 - eta) + n[j] - y[j]
  rb <- rbeta(10000, aj, bj)
  p <- cbind(p,rb )
  probint <- quantile(rb, c(0.05, 0.95))
  lines(log(n[j]) * c(1, 1), probint)
}

apply(p, 2, quantile, c(0.05, 0.95))

plot(log(n), y/n)


mean(log(K))
sd(log(K))

y1 <- rbinom(10000, 1083, p[, 1])
sum(y1 <= y[1])/10000
hist(y1)


y15 <- rbinom(10000, 53637, p[, 15])
hist(y15)
abline(v = y[15], lwd = 3)
sum(y15 <= y[15]) / 10000

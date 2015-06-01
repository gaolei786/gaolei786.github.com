library(LearnBayes)
set.seed(123)
jieduan <- function(m){
  rnormt = function(n, mu, sigma, lo, hi) {
    p = pnorm(c(lo, hi), mu, sigma)
    return(mu + sigma * qnorm(runif(n) * (p[2] - p[1]) + 
                                p[1]))
  }
  x <- c(rep(65, 14), rep(67, 30), rep(69, 49), rep(71, 70), rep(73, 33), rep(75, 15))
  mu <- 71
  sigma2 <- 2
  Mu <- array(1, c(m, 1))
  Sigma2 <- array(1, c(m, 1))
  X1 <- array(1, c(m, length(x)))
  for (i in 1:m){
    x1 <- rnormt(14, mu, sigma2^0.5, -Inf, 66)
    x2 <- rnormt(30, mu, sigma2^0.5, 66, 68)
    x3 <- rnormt(49, mu, sigma2^0.5, 68, 70)
    x4 <- rnormt(70, mu, sigma2^0.5, 70, 72)
    x5 <- rnormt(33, mu, sigma2^0.5, 72, 74)
    x6 <- rnormt(15, mu, sigma2^0.5, 74, Inf)
    x <- c(x1, x2, x3, x4, x5, x6)
    mu <- rnorm(1, mean(x), (sigma2/length(x))^0.5)
    sigma2 <- rigamma(1, length(x)/2, sum((x-mu)^2)/2)
    X1[i, ] <- x
    Mu[i] <- mu
    Sigma2[i] <- sigma2
  }
  par <- list(x1 = X1, mu = Mu, sigma2 = Sigma2)
  return(par)
}

r <- jieduan(1000)
plot(r[[2]], log(r[[3]]^0.5))
mean(r[[2]])
mean(log(r[[3]]^0.5))
sd(r[[2]])
sd(log(r[[3]]^0.5))


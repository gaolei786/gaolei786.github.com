set.seed(123)
jieduan <- function(x, c, m){
  rnormt = function(n, mu, sigma, lo, hi) {
    p = pnorm(c(lo, hi), mu, sigma)
    return(mu + sigma * qnorm(runif(n) * (p[2] - p[1]) + 
                                p[1]))
  }
  x1 <- 115
  x[1] <- x1
  mu <- 110
  sigma2 <- 2
  Mu <- array(1, c(m, 1))
  Sigma2 <- array(1, c(m, 1))
  X1 <- array(1, c(m, 1))
  for (i in 1:m){
    x1 <- rnormt(1, mu, sigma2^0.5, c, Inf)
    x[1] <- x1
    mu <- rnorm(1, mean(x), (sigma2/length(x))^0.5)
    sigma2 <- rigamma(1, length(x)/2, sum((x-mu)^2)/2)
    X1[i] <- x1
    Mu[i] <- mu
    Sigma2[i] <- sigma2
  }
  par <- list(x1 = X1, mu = Mu, sigma2 = Sigma2)
  return(par)
}

x <- c(110, 104, 98, 101, 105, 97, 106, 107, 84, 104)
par <- jieduan(x, 110, 10000)

plot(par$mu, type = 'l')
plot(par$x1, type = 'l')
plot(par$sigma2, type = 'l')
quantile(par$mu, c(0.05, 0.95))
quantile(par$sigma2^0.5, c(0.05, 0.95))

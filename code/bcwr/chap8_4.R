bfexh <- function(theta, datapar){
  y = datapar$data[, 1]
  n = datapar$data[, 2]
  K = datapar$K
  eta <- exp(theta)/(1+exp(theta))
  logf = function(K, eta, y, n)
    lbeta(K * eta + y, K*(1-eta) + n - y) - 
      lbeta(K * eta, K * (1 - eta))
  sum(logf(K, eta, y, n)) + log(eta * (1 - eta)) -
    lbeta(sum(y) + 1, sum(n-y) + 1)
}

data <- cbind(c(8, 4, 5, 12, 5, 7, 10, 5, 12, 
                9, 8, 7, 19, 11, 7), 
              c(15, 10, 7, 19, 11, 17, 19, 14, 
                23, 18, 24, 23, 26, 23, 16))
K <- c(10, 20, 50, 100)
log.marg <- function(K) {
  laplace(bfexch, 0, list(data = data, K = K))$int
}
library(LearnBayes)
BF <- exp(sapply(K, log.marg))
cbind(K, BF)
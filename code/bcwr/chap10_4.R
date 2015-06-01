set.seed(123)
library(LearnBayes)
mixture <- function(y, a1, b1, a2, b2, m){
  p <- 0.5
  lam1 <- 4
  lam2 <- 5
  z <- rep(1, length(y))
  P <- array(1, c(m, 1))
  Lam1 <- array(1, c(m, 1))
  Lam2 <- array(1, c(m, 1))
  Z <- array(1, c(m, length(y)))
  for(i in 1:m){
    fun1 <- function(k){
      prob1 <- p*dpois(y[k], lam1)/(p*dpois(y[k], lam1)+(1-p)*dpois(y[k], lam2))
      prob2 <- 1-prob1
      s <- sample(c(1,2), 1, replace = T, prob = c(prob1, prob2))
      return(s)
    }
    p <- rbeta(1, sum(z==1)+1, sum(z==2)+1)
    lam1 <- rgamma(1, shape = a1+sum(y[z==1]), rate = b1 + sum(z==1))
    lam2 <- rgamma(1, shape = a1+sum(y[z==2]), rate = b1 + sum(z==2))
    while(lam2 <= lam1){
      lam2 <- rgamma(1, shape = a1+sum(y[z==2]), rate = b1 + sum(z==2))
    }
    z <- sapply(1:length(y), fun1)
    P[i] <- p
    Lam1[i] <- lam1
    Lam2[i] <- lam2
    Z[i, ] <- z
    
  }
  par <- list(z = Z, lam1 = Lam1, lam2 = Lam2, p = P)
  return(par)
}

y <- c(24, 18, 21, 5, 5, 11, 11, 17, 6, 7, 20, 13, 4, 16, 19, 21, 4, 22, 8, 17)
a1 <- 1
a2 <- 1
b1 <- 1
b2 <- 1
par <- mixture(y, a1,b1 ,a2, b2, m = 10000)
mean(par$p)
sd(par$p)
mean(par$lam1)
sd(par$lam1)
mean(par$lam2)
sd(par$lam2)
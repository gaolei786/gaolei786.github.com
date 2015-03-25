library(LearnBayes)
#a
pd <- function(lambda) {
  0.5*dgamma(lambda, 1.5, 1000) + 
    0.5*dgamma(lambda, 7, 1000)
}
curve(pd, add = F,xlim = c(0, 0.015), 
      ylim = c(0, 400))

#b
gammapar <- rbind(c(1.5, 1000), c(7, 1000))
probs <- c(0.5, 0.5)
data <- list(y = 4, t=1767)
pgm <- poisson.gamma.mix(probs, gammapar, data)


#c
pd1 <- function(lambda) {
  pgm[[1]][1]*dgamma(lambda, pgm[[2]][1,1], pgm[[2]][1,2]) + 
    pgm[[1]][2]*dgamma(lambda, pgm[[2]][2,1], pgm[[2]][2,2])
}
curve(pd1, add = T, col = 2)

#d
set.seed(123)
inde <- rbinom(10000, 1, pgm[[1]][1])
g1 <- rgamma(10000, pgm[[2]][1,1], pgm[[2]][1,2])
g2 <- rgamma(10000, pgm[[2]][2,1], pgm[[2]][2,2])
g <- inde * g1 + (1-inde) * g2
lines(density(g))
sum(g > 0.005)/10000

#第一位专家





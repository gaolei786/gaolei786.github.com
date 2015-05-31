fun1 <- function(r){
  rj <- r[1]
  ra <- r[2]
  r1 <- dgamma(rj, 240, 4, log = T) + 
        dgamma(ra, 200, 4, log = T) +
        dpois(66, rj, log = T) + 
        dpois(48, ra, log = T)
  return(r1)
}
library(LearnBayes)
l1 <- laplace(fun1, c(40, 40))


fun2 <- function(r) {
  r1 <- dgamma(r, 220, 4, log = T) + 
        dpois(66, r, log = T)+
        dpois(48, r, log = T)
}
l2 <- laplace(fun2, 40)


exp(l1$int)/exp(l2$int)



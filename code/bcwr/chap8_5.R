data <- matrix(c(17, 90, 51, 15, 265, 143, 
                 31, 139, 71), byrow = T, 
               nrow = 3)
chisq.test(data)

a <- matrix(rep(1, 9), nrow = 3)
a
ctable(data, a)


log.K = seq(2, 7)
compute.log.BF <- function(log.K)
  log(bfindep(data, exp(log.K), 10000)$bf)
log.BF <- sapply(log.K, compute.log.BF)
BF <- exp(log.BF)
round(cbind(log.K, BF), 2)
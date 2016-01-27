source('log-log-1.R')
source('log-log-2.R')
source('log-log-3.R')
source('log-log-4.R')
source('log-log-5.R')
save(logultistar, logultstar, sigma2ultstar,
     sigma2star, logwthetastar, midu1, midu2, midu3, midu4, midu5, file = 'jieguo.RData')


load('jieguo.RData')

fun13 <- function(i){
  sum(dnorm(log(data[i, 1:(I+1-i)]), logultistar[i]+
          log(fun1(1:(I+1-i), exp(logwthetastar[1]), exp(logwthetastar[2]))), sigma2star^0.5,
        log = T))
}


r1 <- sum(sapply(1:I, fun13))

r2 <- sum(dnorm(logultistar, logultstar, sigma2ultstar^0.5, log = T))

r3 <- dnorm(logultstar, logu0, (sigma2ultstar/k0)^0.5, log = T)

r4 <- dinvchisq(sigma2ultstar, v0, sigma02, log = T)

r5 <- dinvchisq(sigma2star, v1, sigma12, log = T)

r6 <- dnorm(logwthetastar[1], 0, 100,log = T)+dnorm(logwthetastar[2], 0, 100,log = T)

r1 + r2 + r3 + r4 + r5 + r6 -log(midu1*midu2*midu3*midu4*midu5)
[1] -10.106







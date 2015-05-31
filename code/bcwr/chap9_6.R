data(breastcancer)
attach(breastcancer)
library(survival)
survreg(Surv(time, status) ~ factor(stain), dist = 'weibull')
start = c(1.07, 5.8, -0.99)
d <- cbind(time, status, stain)
fit <- laplace(weibullregpost, start, d)

proposal <- list(var = fit$var, scale = 1.5)
bayes.fit <- rwmetrop(weibullregpost, proposal, fit$mode, 10000,d)
bayes.fit[[2]]

med <- NULL
qua1 <- NULL
qua2 <- NULL
for (t in 0:300){
  z <- (log(t) - bayes.fit[[1]][, 2])/
           exp(bayes.fit[[1]][, 1])
  z <- exp(-exp(z))
  med <- c(med, median(z))
  qua1 <- c(qua1, quantile(z, 0.95))
  qua2 <- c(qua2, quantile(z, 0.05))
}
t <- 0:300
plot(t, med, type = 'l')
lines(t, qua1, lty = 2)
lines(t, qua2, lty = 2)


med <- NULL
qua1 <- NULL
qua2 <- NULL
for (t in 0:300){
  z <- (log(t) - bayes.fit[[1]][, 2]-bayes.fit[[1]][, 3])/
           exp(bayes.fit[[1]][, 1])
  z <- exp(-exp(z))
  med <- c(med, median(z))
  qua1 <- c(qua1, quantile(z, 0.95))
  qua2 <- c(qua2, quantile(z, 0.05))
}
t <- 0:300
plot(t, med, type = 'l')
lines(t, qua1, lty = 2)
lines(t, qua2, lty = 2)


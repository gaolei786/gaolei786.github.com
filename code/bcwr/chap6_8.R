set.seed(123456)
fun <- function(theta, y){
  lambda.A <- exp(theta[1])
  lambda.B <- exp(theta[2])
  sum(log(0.8*dexp(y, 1/lambda.A) + 
          0.2 * dexp(y, 1/lambda.B)))
}
library(LearnBayes)
y <- c(9.3, 4.9, 3.5, 26, 0.6, 1, 3.5, 26.9, 
       2.6, 20.4, 1, 10, 1.7, 11.3, 7.7, 14.1, 
       24.8, 3.8, 8.4, 1.1, 24.5, 90.7, 16.4, 
       30.7, 8.5, 5.9, 14.7, 0.5, 99.5, 35.2)
mycontour(fun, c(1, 4, -2, 8), y)


fit <- laplace(fun, c(3, 0), y)
proposal <- list(var = fit$var, scale = 2)
r <- rwmetrop(fun, proposal, start = fit$mode, m = 10000, y)
r[[2]]
points(r[[1]])
library(coda)
dimnames(r$par)[[2]] <- c('loglambdaA', 'loglambdaB')
xyplot(mcmc(r$par))
autocorr.plot(mcmc(r$par), auto.layout = F)
plot(density(r$par[, 1]), lwd = 2, xlab = 'log lambda A')
plot(density(r$par[, 2]), lwd = 2, xlab = 'log lambda B')


rgibbs <- gibbs(fun, start = fit$mode, 10000, c(0.43, 1.73), y)
mycontour(fun, c(1, 4, -2, 8), y)
points(rgibbs$par)
dimnames(rgibbs$par)[[2]] <- c('loglambdaA', 'loglambdaB')
xyplot(mcmc(rgibbs$par))
autocorr.plot(mcmc(rgibbs$par), auto.layout = F)
rgibbs$accept
plot(density(rgibbs$par[, 1]), lwd = 2, xlab = 'log lambda A')
plot(density(rgibbs$par[, 2]), lwd = 2, xlab = 'log lambda B')

par(mfrow = c(2, 2))
plot(density(r$par[, 1]), lwd = 2, xlab = 'log lambda A', main = '')
plot(density(r$par[, 2]), lwd = 2, xlab = 'log lambda B', main = '')
plot(density(rgibbs$par[, 1]), lwd = 2, xlab = 'log lambda A', main = '')
plot(density(rgibbs$par[, 2]), lwd = 2, xlab = 'log lambda B', main = '')

batchSE(mcmc(r$par), 30)
batchSE(mcmc(rgibbs$par), 30)


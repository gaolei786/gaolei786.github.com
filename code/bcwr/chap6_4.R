library(LearnBayes)
data <- c(36, 13, 23, 6, 20, 12, 23, 93, 
          98, 91, 89, 100, 90, 95, 90, 87)
mycontour(cauchyerrorpost, c(10, 110, 0, 5), data)

ll1 <- laplace(cauchyerrorpost, c(90, 1), data)
ll1

ll2 <- laplace(cauchyerrorpost, c(40, 3), data)
ll2

proposal <- list(var = ll1$var, scale = 3)
rr <- rwmetrop(cauchyerrorpost, proposal, 
               c(40,3), 10000, data)
rr[[2]]

library(coda)
dimnames(rr$par)[[2]] <- c('mu', 'log sigma')
xyplot(mcmc(rr$par[-(1:1000), ]))

par(mfrow = c(2, 1))
autocorr.plot(mcmc(rr$par[-(1:1000), ]), 
              auto.layout = F)

apply(rr$par[-(1:1000), ], 2, mean)
apply(rr$par[-(1:1000), ], 2, sd)

batchSE(mcmc(rr$par[-(1:1000), ]), 
              batchSize = 100)


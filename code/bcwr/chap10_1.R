library(LearnBayes)
data <- data.frame(x = c(16, 18, 20, 22, 24, 26, 28),
                   n = c(2, 7, 14, 26, 13, 14, 3),
                   y = c(0, 0, 6, 12, 7, 9, 3))
                   
fit <- laplace(logisticpost, c(0, 0), data)

mycontour(logisticpost, c(-19, 3, 0, 0.8), data)
r <- gibbs(logisticpost, start = c(0, 0), m = 1000, 
      scale = 0.45*diag(fit$var)^0.5, data)

plot(r[[1]][, 1], type = 'l')
plot(r[[1]][, 2], type = 'l')
plot(acf(r[[1]])

plot(r[[1]], type = 'l')



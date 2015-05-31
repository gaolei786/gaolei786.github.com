library(LearnBayes)
bradley.terry.post
fit <- laplace(bradley.terry.post, c(rep(0, 10), -0.1), baseball.1964)

proposal <- list(var = fit$var, scale = 0.5)
rw <- rwmetrop(bradley.terry.post, proposal, start = fit$mode,20000, baseball.1964)
hist(exp(rw[[1]][, 11]))

plot(rw[[1]][, 1:2])
abline(0, 1, col = 2)
plot(rw[[1]][, 1:3])
abline(0, 1, col = 2)

p21 <- exp(rw[[1]][, 2] - rw[[1]][, 1] )/(1+exp(rw[[1]][, 2] - rw[[1]][, 1] ))
hist(p21)
mean(rbinom(20000, 10, p21))




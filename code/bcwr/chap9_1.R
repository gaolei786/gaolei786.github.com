library(LearnBayes)
data(birthweight)
plot(birthweight[, c(1, 3)], col = birthweight[, 2]+1)

plot(birthweight[, c(2, 3)])

fit <- lm(weight ~ age + gender, data = birthweight, x = T, y=T)
summary(fit)

theta.sample <- blinreg(fit$y, fit$x, 5000)
names(theta.sample)

mean(theta.sample$beta[, 2])
sd(theta.sample$beta[, 2])

mean(theta.sample$beta[, 3])
sd(theta.sample$beta[, 3])

cov1 <- c(1, 36, 0)
cov2 <- c(1, 36, 1)
cov3 <- c(1, 40, 0)
cov4 <- c(1, 40, 1)
X1 <- rbind(cov1, cov2, cov3, cov4)
mean.draws <- blinregexpected(X1, theta.sample)

apply(mean.draws, 2, quantile, c(0.05, 0.95))

pred.draws <- blinregpred(X1, theta.sample)
apply(pred.draws, 2, quantile, c(0.05, 0.95))
libary(LearnBayes)
data(darwin)
fit <- robustt(darwin$difference, 1, 10000)
names(fit)

mean(fit[[1]])
sd(fit[[1]])

mean(log(fit[[2]])/2)

sd(log(fit[[2]])/2)
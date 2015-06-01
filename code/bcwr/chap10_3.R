library(LearnBayes)
data(calculus.grades)
attach(calculus.grades)
y <- grade
X <- cbind(1, prev.grade, act)
beta0 <- c(0, 0, 0)
c0 <- 100
P0 <- t(X) %*% X/c0
bayes.probit(y, X, 1000, list(beta = beta0, 
             P = P0))$log.marg

bayes.probit(y, X[, -2], 1000, list(beta = beta0[-2], 
             P = P0[-2, -2]))$log.marg

bayes.probit(y, X[, -3], 1000, list(beta = beta0[-3], 
             P = P0[-3, -3]))$log.marg

bayes.probit(y, X[, -c(2, 3)], 1000, list(beta = beta0[-c(2, 3)], 
             P = P0[-c(2, 3), -c(2, 3)]))$log.marg

fit <- bayes.probit(y, X[, -3], 1000, list(beta = beta0[-3], 
             P = P0[-3, -3]))

X1 <- cbind(1, c(0, 1))
rr <- bprobit.probs(X1, fit$beta)
boxplot(rr)


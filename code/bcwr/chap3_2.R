y <- c(751, 594, 1213, 1126, 819)
s <- sum(y)
n <- length(y)

theta <- rgamma(1000, n, s)
lambda <- 1/theta

sum(lambda > 1000)/1000
library(LearnBayes)
data(hearttransplants)
data <- hearttransplants
fun <- function(theta, data) {
  alpha <- exp(theta[1])
  beta <- exp(theta[2])
  y <- data[, 2]
  e <- data[, 1]
  val <- -94 * lgamma(alpha) + sum(alpha * log(beta) + lgamma(alpha + y) -
    (alpha + y) * log(beta + e)) - 2*log(alpha + 1) - 2*log(beta + 1) + 
    + log(alpha) + log(beta)
  return(val)
}
fit <- laplace(fun, c(4, 9), data)
fun(c(9, 8), data)


mycontour(fun, c(0.2, 5, 7, 12), data)

set.seed(123)
r <- gibbs(fun, start = c(2, 9), 10000, c(0.85, 0.85), data)
points(r[[1]])

alpha <- exp(r[[1]][, 1])
beta <- exp(r[[1]][, 2])
plot(log(data[, 1]), data[, 2]/data[, 1], pch = as.character(data[, 2]))
for (i in 1:94){
  lami <- rgamma(10000, data[i, 2] + alpha, data[i, 1] + beta)
  probint <- quantile(lami, probs = c(0.05, 0.95))
  lines(log(data[i, 1])*c(1, 1), probint)
}

  
  
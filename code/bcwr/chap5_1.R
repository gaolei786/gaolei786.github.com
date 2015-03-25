library(LearnBayes)
fun <- function(theta, data){
  y <- data[1]
  n <- data[2]
  mu <- data[3]
  sigma <- data[4]
  val <- y * theta - n*log(1+exp(theta)) -
           (theta-mu)^2/2/sigma^2
  return(val)
}
data = c(5, 5, 0, 0.25)
ll <- laplace(fun, 0.5, data)
1- pnorm(0, ll$mode, ll$var[1, 1]^0.5)

fun1 <- function(theta, data){
  y <- data[1]
  n <- data[2]
  mu <- data[3]
  sigma <- data[4]
  val <- y * theta - n*log(1+exp(theta)) -
           (theta-mu)^2/2/sigma^2 - 
           dnorm(theta, mu, sigma, log = T)
  return(val)
}
ll1 <- laplace(fun1, 0.2, data)
exp(fun1(ll1$mode, data))

set.seed(123)
theta <- rnorm(10000, mean = data[3], sd = data[4])
prob <- fun(theta, data) - dnorm(theta, data[3], data[4], log = T)- 
          fun1(ll1$mode, data)
prob <- exp(prob)
theta <- theta[runif(10000) < prob ]
sum(theta > 0) / length(theta)


set.seed(123)
theta <- rnorm(10000, mean = data[3], sd = data[4])
wt <- exp(fun(theta, data) - dnorm(theta, data[3], data[4], log = T))
probs <- wt / sum(wt)
theta <- sample(theta, size = 1000, prob = probs, replace = T)
sum(theta > 0) / length(theta)
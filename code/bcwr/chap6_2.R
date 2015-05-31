library(LearnBayes)
set.seed(123)
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

proposal <- list(var = ll$var, scale = 2)
start <- ll$mode
rr <- rwmetrop(fun, proposal, start, 10000, data) 
theta <- rr[[1]]
mean(theta)
sd(theta)
sum(theta > 0)/10000
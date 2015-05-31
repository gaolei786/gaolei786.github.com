fun <- function(theta, data){
  w <- data[, 1]
  y <- data[, 2]
  n <- data[, 3]
  mu <- theta[1]
  sigma <- exp(theta[2])
  m1 <- exp(theta[3])
  x <- (w - mu) / sigma
  p <- (exp(x)/(1+exp(x)))^m1
  a0 <- 0.25
  b0 <- 4
  r <- y * log(p) + (n - y) * log(1-p) + 
       a0 * theta[3] - exp(theta[3])/b0
  return(sum(r))
}
data <- data.frame(w = c(1.6907, 1.7242, 1.7552,
                         1.7842, 1.8113, 1.8369,
                         1.8610, 1.8839),
                   y = c(6, 13, 18, 28, 52, 53, 61,60),
                   n = c(59, 60, 62, 56, 63, 59, 62, 60))
proposal <- list(var = diag(c(0.00012, 0.033, 0.1)), 
                 scale = 0.7)
r1 <- rwmetrop(fun, proposal, start=c(1.8, -4.03, -1.01) , m = 10000, 
              data)
r1[[2]]
plot(r1[[1]][, 2], type = 'l')
fun1 <- function(x){
  quantile(x, c(0.025,  0.975))
}
apply(r1[[1]], 2, fun1)


fit <- laplace(fun, c(1.8, -4.03, -1.01), data)
proposal <- list(var = fit$var, 
                 scale = 0.7)
r2 <- rwmetrop(fun, proposal, start=c(1.8, -4.03, -1.01) , m = 10000, 
              data)
apply(r2[[1]], 2, fun1)
r2[[2]]
plot(r2[[1]][, 2], type = 'l')
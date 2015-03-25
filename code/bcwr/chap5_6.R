fun <- function(theta, y){
  lambda.A <- exp(theta[1])
  lambda.B <- exp(theta[2])
  sum(log(0.8*dexp(y, 1/lambda.A) + 
          0.2 * dexp(y, 1/lambda.B)))
}
library(LearnBayes)
y <- c(9.3, 4.9, 3.5, 26, 0.6, 1, 3.5, 26.9, 
       2.6, 20.4, 1, 10, 1.7, 11.3, 7.7, 14.1, 
       24.8, 3.8, 8.4, 1.1, 24.5, 90.7, 16.4, 
       30.7, 8.5, 5.9, 14.7, 0.5, 99.5, 35.2)
mycontour(fun, c(1, 4, -2, 8), y)


laplace(fun, c(3, 0), y)
laplace(fun, c(2,4), y)


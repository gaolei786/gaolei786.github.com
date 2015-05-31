library(LearnBayes)
fun <- function(beta, data){
  age <- data$Age
  y <- data$HR
  n <- data$AB
  beta0 <- beta[1]
  beta1 <- beta[2]
  beta2 <- beta[3]
  p <- exp(beta0 + beta1 * age + beta2*age^2)/
         (1+exp(beta0 + beta1 * age + beta2*age^2))
  val <-   sum(y * log(p) + (n-y) * log(1-p))
  return(val)
}
data(schmidt)
attach(schmidt)
HR/AB
plot(Age, HR/AB, pch = 16)
summary(lm(I(log(HR/AB/(1-HR/AB))) ~ Age + I(Age^2)))

fit <- laplace(fun, c(0,0,0), schmidt)
diag(fit$mode)^0.5
x <- 22:39
plot(x, -0.43+0.03*x-0.0005*x^2)


  
fun <- function(eta, data){
  125 * log(2 + exp(eta)/(1+exp(eta))) - 
    39 * log(1+exp(eta)) + 
    35 * log(exp(eta)/(1+exp(eta)))
}

ll <- laplace(fun, 0)

eta_int <- c(qnorm(0.025, ll$mode, ll$var[1,1]^0.5), 
             qnorm(0.975, ll$mode, ll$var[1,1]^0.5))
theta_int <- exp(eta_int) / (1+exp(eta_int))

set.seed(123)
fun1 <- function(eta, tpar){
  mean <- tpar[[1]]
  S = tpar[[2]]
  df <- tpar[[3]]
  val <- fun(eta) - dmt(eta, mean, S, df = df, log = T)
  return(val)
}
tpar <- list(m = ll[[1]], var = 3*ll[[2]], df = 2)
ll1 <- laplace(fun1, 0, tpar)
fun1(ll1$mode, tpar)
eta <- rejectsampling(fun, tpar, 65.55,  10000)
quantile(eta, c(0.025, 0.975))
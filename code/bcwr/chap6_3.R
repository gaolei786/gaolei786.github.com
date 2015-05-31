set.seed(123)
fun <- function(eta, data){
  125 * log(2 + exp(eta)/(1+exp(eta))) - 
    39 * log(1+exp(eta)) + 
    35 * log(exp(eta)/(1+exp(eta)))
}

ll <- laplace(fun, 0)

proposal <- list(var = ll$var, scale = 2)
start <- ll$mode
rr <- rwmetrop(fun, proposal, start, 10000, 0)

hist(rr[[1]], freq = F)
curve(dnorm(x,ll$mode,0.047^0.5) ,  add = T)

quantile(rr[[1]], c(0.025, 0.975))
exp(quantile(rr[[1]], c(0.025, 0.975)))/
  (1+exp(quantile(rr[[1]], c(0.025, 0.975))))

proposal2 <- list(var = ll$var, mu = ll$mode)
rr2 <- indepmetrop(fun, proposal2,  start, 10000, 0)
hist(rr2[[1]], freq = F)
curve(dnorm(x,ll$mode,0.047^0.5) ,  add = T)

quantile(rr2[[1]], c(0.025, 0.975))
exp(quantile(rr2[[1]], c(0.025, 0.975)))/
  (1+exp(quantile(rr2[[1]], c(0.025, 0.975))))





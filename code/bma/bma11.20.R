logpost <- function(logwtheta, dd){
  sigma2 <- dd[[1]]
  sigma2ult<- dd[[2]]
  logult<- dd[[3]]
  logulti<- dd[[4]]
  w <- exp(logwtheta[1])
  theta <- exp(logwtheta[2])
  logw <- logwtheta[1]
  logtheta <- logwtheta[2]
  ss <- 0
  for(i in 1:I){
    for (j in 1:(I+1-i)){
      ss <- ss+(log(data[i, j]) - 
                  logulti[i] - log(fun1(j, w, theta)))^2
    }
  }
  r <- -ss/(2*sigma2)  + dnorm(logw, 0, 100, log = T) + 
    dnorm(logtheta, 0, 100, log = T)
  return(r)
}
fit <- laplace(logpost, c(0, 0),dd )
proposal <- list(var = fit$var, scale = 2)
r <- rwmetrop(logpost, proposal, start = fit$mode, m = 10, dd)


sigma2ultstar <- mean(sigma2ult[1001:10000])



fun10 <- function(sigma2ultstar, logult, logulti){
  ziyoudu <- I+v0+1
  scale2 <- (sum((logulti - logult)^2)+k0*(logult - logu0)^2 + v0*sigma02)/
    (I+v0+1)
  
  scale <- scale2
  r <- dinvchisq(sigma2ultstar, df=ziyoudu, scale=scale)
  return(r)
}
midu3 <- fun10(sigma2ultstar, logultstar, 
               logultistar)


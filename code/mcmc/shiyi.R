library(LearnBayes)
library(MASS)
library(mvtnorm)
logpost <- function(x, par) { #瀹氫箟鐩爣鍒嗗竷鍑芥暟鐨勫鏁板舰寮?
  mean <- par$mean
  sigma <- par$sigma
  return(dmvnorm(x, mean, sigma, log = T))
}
mean <- c(1, 1)
sigma <- matrix(c(1, 0.9, 0.9, 1), nrow = 2,
                ncol = 2)
par <- list(mean = mean, sigma = sigma)
varcov <- diag(c(0.3, 0.3))
proposal <- list(var = varcov, scale = 2)
start <- c(-4, 8)
m = 5000
set.seed(123)
#par(mfrow = c(1, 2))
rwmetrop1 <- function (logpost, proposal, start, m, ...) 
{
  pb = length(start)
  MM <- array(0, c(m, 2 * pb))
  Mpar = array(0, c(m, pb))
  b = matrix(t(start))
  lb = logpost(start, ...)
  a = chol(proposal$var)
  scale = proposal$scale
  accept = 0
  for (i in 1:m) {
    bc = b + scale * t(a) %*% array(rnorm(pb), c(pb, 1))
    
    lbc = logpost(t(bc), ...)
    prob = exp(lbc - lb)
    if (is.na(prob) == FALSE) {
      if (runif(1) < prob) {
        lb = lbc
        b = bc
        accept = accept + 1
      } else {
        MM[i, ] <- c(b, bc)
      }
    }
    Mpar[i, ] = b
  }
  accept = accept/m
  stuff = list(par = Mpar, accept = accept, MM = MM)
  return(stuff)
}

s <- rwmetrop1(logpost, proposal, start, m, par)
mycontour(logpost, c(-4,5,-4,5),par, 
          xlim = c(-4, 10), ylim = c(-4, 10), add = T)
lines(s[[1]], col = rgb(0, 0, 0, 0.5))
mycontour1 <- function (logf, limits, data, ...) 
{
  LOGF = function(theta, data) {
    if (is.matrix(theta) == TRUE) {
      val = matrix(0, c(dim(theta)[1], 1))
      for (j in 1:dim(theta)[1]) val[j] = logf(theta[j, 
                                                     ], data)
    }
    else val = logf(theta, data)
    return(val)
  }
  ng = 50
  x0 = seq(limits[1], limits[2], len = ng)
  y0 = seq(limits[3], limits[4], len = ng)
  X = outer(x0, rep(1, ng))
  Y = outer(rep(1, ng), y0)
  n2 = ng^2
  Z = LOGF(cbind(X[1:n2], Y[1:n2]), data)
  Z = Z - max(Z)
  Z = matrix(Z, c(ng, ng))
  contour(x0, y0, Z, levels = -6, lwd = 1, 
          ...)
}

plot(0, type = 'n', xlim = c(-4, 6), ylim = c(-4, 6), xlab = '', ylab = '', 
     axes = F)
box()
lines(s[[1]][100:250,], col = rgb(0, 0, 0, 0.5), lwd = 2)
legend("topleft", legend = c("接受建议", "拒绝建议"), lty = c(1, 3), lwd = c(2, 1), 
       col = rgb(0, 0, 0, 0.5), bty = 'n' )

mycontour1(logpost, c(-4,5,-4,5),par, 
           xlim = c(-4, 10), ylim = c(-4, 10), add = T)
MM <- (s$MM)[100:250, ]
segments(MM[, 1], MM[, 2], MM[, 3], MM[, 4], col = rgb(0, 0, 0, 0.5), lty = 3)


windows()
x <- seq(-0.5, 2.5, length = 300)
y <- seq(-0.5, 2.5, length = 300)
fun <- function(x, y)  exp(5.5 * (100 - (25*(1-x)^2 * ifelse(x > 1, 1, 0) +
                       0.5*(1-x)^2 * ifelse(x <= 1, 1, 0)   + 50*(y-x^2)^2)))
z <- outer(x, y, fun)
contour(x, x, z, col = "pink",  method = "edge",
        vfont = c("sans serif", "plain"), nlevels = 20, xlim = c(-0.5, 1.5), 
        ylim = c(-0.5, 1.5))

plot(0, type = 'n', xlim = c(-0.5, 1.5), ylim= c(-0.5,1.5), axes = T,
  xlab = '', ylab = '')
box()

library(LearnBayes)
library(MASS)
library(mvtnorm)
logpost <- function(x) { #定义目标分布函数的对数形式
  return(log(fun(x[1], x[2])))
}
varcov <- diag(c(1, 1))
proposal <- list(var = varcov, scale = 0.1)
start <- c(0, 1)
m = 50000
set.seed(13)
#par(mfrow = c(1, 2))
s1 <- rwmetrop(logpost, proposal, start, m)
lines(s1[[1]][1:1000,],col =rgb(1, 0, 0, 0.25), lwd = 0.2)



start <- c(-0.5, -0.5)
m = 1000
set.seed(123)
#par(mfrow = c(1, 2))
s2 <- rwmetrop(logpost, proposal, start, m)
lines(s2[[1]], col = rgb(0, 1, 0, 0.25), lwd = 0.2)



start <- c(1, -0.5)
m = 1000
set.seed(123)
#par(mfrow = c(1, 2))
s3 <- rwmetrop(logpost, proposal, start, m)
lines(s3[[1]], col = rgb(0, 0, 1, 0.25), lwd = 0.2)
points(s1[[1]][1:10000, ], col = rgb(1, 0, 0, 0.25),  cex = 0.1)
points(s2[[1]], col = rgb(0, 1, 0, 0.25), cex = 0.1)
points(s3[[1]], col = rgb(0, 0, 1, 0.25), cex = 0.1)





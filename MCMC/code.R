library(grid)
mousedown<-function(buttons,x,y)   
{
  if(buttons==2) return(invisible(1))
  px<-c(px,x)
  py<-c(py,y)
  #devset()
  eventEnv$onMouseMove<-mousemove
  NULL
}
mousemove<-function(buttons,x,y)
{
  px<<-c(px,x)
  py<<-c(py,y)
  # devset()
  grid.points(x,y)
  NULL
}
mouseup<-function(buttons,x,y)
{
  eventEnv$onMouseMove<-NULL   
}

pushViewport(viewport())
px <- NULL
py <- NULL
setGraphicsEventHandlers(onMouseDown=mousedown,
                         onMouseUp=mouseup,prompt='Start to write')
eventEnv<-getGraphicsEventEnv()

getGraphicsEvent()

x <- 10*px
y <- 30 *py
rhs <- function(x, b0, b1, b2, b3, b4, b5, b6) {
  
  x*(b0 * x + b1 * x^2 + b2 * x^3 + b3 * x^4 + b4 * x^5 + b5 * x^6 + b6 * x^7)*(x-10)
}
ds <- data.frame(x = x, y = y)
m1 <- nls(y ~ rhs(x, b0, b1, b2, b3, b4, b5, b6), data = ds)

save(x1, y1, file = "shuju.RData")



x1 <- seq(0, 10, length = 200)
#par(mfrow = c(1, 2))
plot(x, y, type = "p")
plot(x, y, type = "n")
lines(x1, predict(m1, list(x = x1)), col = "2", lwd = 3)
y1 <- predict(m1, list(x = x1))




load("shuju.RData")
plot(x1, y1, type = 'l', ylim = c(0,15), axes = F, xlab = '', ylab = '')
axis(1)
axis(2)
#box()
segments(0, 0, 10, 0)


plot(x1, y1, type = 'n', axes = F, xlab = '', ylab = '', ylim = c(0, 15))
axis(1)
axis(2)
polygon(x1, y1, col = "grey")
polygon(x1[c(50, 50, 51:55, 55)], c(0, y1[50:55], 0), border = 1,
   density = 10, angle = 45)

plot(x1, y1, type = 'n', axes = F, xlab = '', ylab = '', ylim = c(0, 15))
axis(1)
axis(2)
polygon(x1, y1, col = "grey")
x2 <- c(0, 10, 10, 0)
y2 <- c(0, 0, 15, 15)
polygon(x2, y2, border = rgb(0, 0, 0, 0.5), lwd =2)


plot(x1, y1, type = 'n', axes = F, xlab = '', ylab = '', ylim = c(0, 15))
axis(1)
axis(2)
polygon(x1, y1, col = "grey")
x2 <- c(0, 10, 10, 0)
y2 <- c(0, 0, 15, 15)
polygon(x2, y2, border = rgb(0, 0, 0, 0.5), lwd =2)
x3 <- runif(1000, 0, 10)
y3 <- runif(1000, 0, 15)
points(x3, y3, cex = 0.2, pch = 16, col = rgb(0, 0, 0, 0.5))

x3 <- runif(5000, 0, 10)
y3 <- runif(5000, 0, 15)
points(x3, y3, cex = 0.2, pch = 3, col = rgb(0, 0, 0, 0.5))



set.seed(123)
X <- matrix(runif(2*3000), ncol = 2)
plot(0, type = "n", axes = F, xlim = c(-0.15, 1.05), ylim = c(-0.15, 1.05),
     xlab = '', ylab = '', xaxs = "i")

theta <- seq(0, pi/2, length = 500)
x1 <- c(cos(theta), 0)
y1 <- c(sin(theta), 0)
polygon(x1, y1, col = rgb(0, 0, 0, 0.15), border = rgb(0, 0, 0, 0.55) )
segments(seq(0, 1, length = 5), rep(0, 5), seq(0, 1, length = 5), 
         rep(-0.02, 5))
text(seq(0, 1, length = 5), rep(-0.05, 5), seq(0, 1, length = 5), cex = 0.7)
segments(rep(-0.02, 5), seq(0, 1, length = 5),rep(0, 5) , seq(0, 1, length = 5))
text(rep(-0.05, 5),seq(0, 1, length = 5), seq(0, 1, length = 5), cex = 0.7)
x2 <- c(0, 1, 1, 0)
y2 <- c(0, 0, 1, 1)
polygon(x2, y2, border = rgb(0, 0, 0, 0.55) )

inde <- which(X[, 1]^2 + X[, 2]^2 <= 1)
length(inde)/3000 * 4
points(X, cex = 0.3, pch = 15, col = rgb(0, 0, 0, 0.65))



library(LearnBayes)
###################################################################
#                定义目标函数，还有合适的scale参数等
#
###################################################################

d <- list(int.lo = c(-Inf, 66, 68, 70, 72, 74),
     int.hi = c(66, 68, 70, 72, 74, Inf), 
     f = c(14, 30, 49, 70, 33, 15))
    
groupeddatapost <- function(theta, data) {
  dj <- function(f, int.lo, int.hi, mu, sigma) {
    f * log(pnorm(int.hi, mu, sigma) - pnorm(int.lo, mu, sigma))
  }
  mu <- theta[1]
  sigma <- exp(theta[2])
  sum(dj(data$f, data$int.lo, data$int.hi, mu, sigma))
}
start <- c(7, 7)
fit <- laplace(groupeddatapost, start, d)
proposal <- list(scale = 2, var = fit$var)
###################################################################

###################################################################
#                  定义MH算法，稍加修改，让他能够演示路径
#
###################################################################
plot.metrop <- function (logpost, proposal, start, m, ...) 
{
    pb = length(start)
    Mpar = array(0, c(m, pb))
    b = matrix(t(start))
    lb = logpost(start, ...)
    a = chol(proposal$var)
    scale = proposal$scale
    accept = 0
    for (i in 1:m) {
        start.point <- b
        bc = b + scale * t(a) %*% array(rnorm(pb), c(pb, 1))
        lbc = logpost(t(bc), ...)
        prob = exp(lbc - lb)
        if (is.na(prob) == FALSE) {
            if (runif(1) < prob) {
                lb = lbc
                b = bc
                accept = accept + 1
            }
        }
        Mpar[i, ] = b
        lines(c(start.point[1], b[1]), c(start.point[2], b[2]), col = 2)
        Sys.sleep(0.05)
        
    }
    accept = accept/m
    stuff = list(par = Mpar, accept = accept)
    return(stuff)
}

###################################################################
#            观察动态过程
#
###################################################################
mycontour(groupeddatapost, c(69, 71, 0.6, 1.3), d, 
  xlab = "mu", ylab = "logsigma")
start <- c(69, 0.6)
#start <- c(69, 1.3)
r <- plot.metrop(groupeddatapost, proposal, start, 2000, d)
mycontour(groupeddatapost, c(69, 71, 0.6, 1.3), d, 
  xlab = "mu", ylab = "logsigma")
points(r$par)









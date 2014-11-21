########################################################################
#      定义目标分布函数-混合正态分布形式，自定义rwmetrop算法函数（与learnBayes基本一致）
#      建议分布采用随机游走，参数由scale控制
#
########################################################################
target <- function(x, mu1 = 0,
    lamda1 = 2, mu2 = 10, lamda2 = 2) {
    d <- 0.3 * dnorm(x, mu1, lamda1) + 
        0.7 * dnorm(x, mu2, lamda2)
    return(d)
}
plot(0, 0, type = 'n', xlim = c(-10, 20), ylim = c(0, 0.15), axes = F, xlab = '', ylab = '')
curve(target, from = -10, to=20, add = T, lwd = 2, col = rgb(0, 0, 0, 0.5))
abline(h=0)
axis(1, line=-0.73)
axis(2)
set.seed(12)
x0 <- 10
points(x0, 0, pch=13, col = 2)
proposal <- x0 +  rnorm(1, 0, 3)
points(proposal, 0, pch=13, col = 4)
pi.x0 <- target(x0)
segments(x0, 0, x0, pi.x0, col = 2, lwd = 2)
pi.proposal <- target(proposal)
segments(proposal, 0, proposal, pi.proposal, col = 4, lwd = 2)
prob <- pi.proposal / pi.x0
prob


old <- par(mar=c(1, 1, 1, 1) + 0.1, mfrow = c(2, 1))
plot(0, 0, type = 'n', xlim = c(-10, 20), ylim = c(0, 0.15), axes = F, xlab = '', ylab = '')
curve(target, from = -10, to=20, add = T, lwd = 2, col = rgb(0, 0, 0, 0.5))
abline(h=0)
axis(2)
points(x0, 0, pch=13, col = 2)
points(proposal, 0, pch=13, col = 4)
segments(x0, 0, x0, pi.x0, col = 2, lwd = 2)
segments(proposal, 0, proposal, pi.proposal, col = 4, lwd = 2)



plot(0, 0, type = 'n', xlim = c(0, 1), ylim = c(0, 1), axes = F, xlab = '', ylab = '')
segments(0, 0.5, 1, 0.5, col = rgb(0, 0, 0, 0.5), lwd = 2)
segments(0, 0.50, 0, 0.55, col = rgb(0, 0, 0, 0.5), lwd = 2)
segments(1, 0.50, 1, 0.55, col = rgb(0, 0, 0, 0.5), lwd = 2)
segments(prob, 0.50, prob, 0.55, col = rgb(0, 0, 0, 0.5), lwd = 2)
text(0, 0.4, "0")
text(1, 0.4, "1")
text(prob, 0.4, round(prob,2 ))
r <- runif(1)
points(r, 0.5, pch = 15, col = 20)
text(r, 0.4, round(r, 3))


windows()
x1 <- x0
plot(0, 0, type = 'n', xlim = c(-10, 20), ylim = c(0, 0.15), axes = F, xlab = '', ylab = '')
curve(target, from = -10, to=20, add = T, lwd = 2, col = rgb(0, 0, 0, 0.5))
abline(h=0)
axis(1, line=-0.73)
axis(2)
points(x1, 0, pch=13, col = 2)
proposal <- x1 +  rnorm(1, 0, 3)
points(proposal, 0, pch=13, col = 4)
pi.x1 <- target(x1)
segments(x1, 0, x0, pi.x1, col = 2, lwd = 2)
pi.proposal <- target(proposal)
segments(proposal, 0, proposal, pi.proposal, col = 4, lwd = 2)
prob <- pi.proposal / pi.x0
prob



old <- par(mar=c(1, 1, 1, 1) + 0.1, mfrow = c(2, 1))
plot(0, 0, type = 'n', xlim = c(-10, 20), ylim = c(0, 0.15), axes = F, xlab = '', ylab = '')
curve(target, from = -10, to=20, add = T, lwd = 2, col = rgb(0, 0, 0, 0.5))
abline(h=0)
axis(2)
points(x1, 0, pch=13, col = 2)
points(proposal, 0, pch=13, col = 4)
segments(x0, 0, x0, pi.x1, col = 2, lwd = 2)
segments(proposal, 0, proposal, pi.proposal, col = 4, lwd = 2)



plot(0, 0, type = 'n', xlim = c(0, 1), ylim = c(0, 1), axes = F, xlab = '', ylab = '')
segments(0, 0.5, 1, 0.5, col = rgb(0, 0, 0, 0.5), lwd = 2)
segments(0, 0.50, 0, 0.55, col = rgb(0, 0, 0, 0.5), lwd = 2)
segments(1, 0.50, 1, 0.55, col = rgb(0, 0, 0, 0.5), lwd = 2)
segments(prob, 0.50, prob, 0.55, col = rgb(0, 0, 0, 0.5), lwd = 2)
text(0, 0.4, "0")
text(1, 0.4, "1")
text(prob, 0.4, round(prob,2 ))
r <- runif(1)
points(r, 0.5, pch = 15, col = 20)
text(r, 0.4, round(r, 3))






windows()
x2 <- proposal
plot(0, 0, type = 'n', xlim = c(-10, 20), ylim = c(0, 0.15), axes = F, xlab = '', ylab = '')
curve(target, from = -10, to=20, add = T, lwd = 2, col = rgb(0, 0, 0, 0.5))
abline(h=0)
axis(1, line=-0.9)
axis(2)
points(x2, 0, pch=13, col = 2)









op <- par(mfrow = c(1, 1))
MH <- function(target, scale, start, m, ...) {
    MH.sample <- rep(0, m)
    MH.sample[1] <- start
    accept <- NULL
    for (i in 2:m) {
        start1 <- start +  rnorm(1, 0, 3)
        print(start1)
        dstart <- target(start, ...)
        dstart1 <- target(start1, ...)
        
        prob <- dstart1 / dstart

        if(runif(1) < prob) {
            start <- start1
            accept <- accept + 1
        }
        MH.sample[i] <- start
    }
    accept <- accept / m
    stuff <- list(sample = MH.sample, accept = accept)
    return(stuff)
}
########################################################################
#                运行一次观察模拟效果
#
########################################################################
set.seed(12)
result <-MH(target = target, scale = 3, start = 10, m = 20, mu1 = 0,
    lamda1 = 2, mu2 = 10, lamda2 = 2)
plot(result$sample, type = 'b', ylim = c(-10, 15), xlab = '', ylab = '')
set.seed(12)
result <-MH(target = target, scale = 3, start = 10, m = 10000, mu1 = 0,
    lamda1 = 2, mu2 = 10, lamda2 = 2)
plot(result$sample[seq(1, 1000, by = 1)], type = 'l', ylim = c(-10, 15), xlab = '', ylab = '')
lines(seq(1, 1000, by = 40),result$sample[seq(1, 1000, by = 40)], type = 'b', ylim = c(-10, 15), xlab = '', ylab = '',col=2,lwd = 2)


hist(result$sample, breaks = 20, freq = F, xlab = '', ylab = '',main ="")

curve(target(x, mu1 = 0, lamda1 = 2, mu2 = 10,
    lamda2 = 2), from = -7, to = 17, add = T, col = 2, lwd = 3)
acf(result$sample, main = '')
set.seed(12)
result <-MH(target = target, scale = 3, start = 10, m = 100000, mu1 = 0,
    lamda1 = 2, mu2 = 10, lamda2 = 2)
acf((result$sample)[seq(1, 100000, by = 40)], main  = '')

par(mfrow=c(2,1))
result <-MH(target = target, scale = 3, start = 80, m = 1000, mu1 = 0,
    lamda1 = 2, mu2 = 10, lamda2 = 2)
plot(result$sample, type = 'l', ylim = c(-80, 80), xlab = '', ylab = '')
abline(v=100, col = 2, lwd = 4)
result <-MH(target = target, scale = 3, start = -70, m = 1000, mu1 = 0,
    lamda1 = 2, mu2 = 10, lamda2 = 2)
plot(result$sample, type = 'l', ylim = c(-80, 80), xlab = '', ylab = '')
abline(v=100, col = 2, lwd = 4)


########################################################################
#                   模拟次数越多，模拟越好
#
########################################################################


op <- par(mfrow = c(2, 2))
sim.no <- c(10, 100, 1000, 10000)
for (m in sim.no) {
    result <-MH(target = target, scale = 10, start = 2, m = m, mu1 = 0,
        lamda1 = 2, mu2 = 10, lamda2 = 2)
    hist(result$sample, breaks = 20, freq = F, main = paste("模拟次数:", m))
    c <- curve(target(x, mu1 = 0, lamda1 = 2, mu2 = 10,
        lamda2 = 2), from = -7, to = 17, add = T, col = 2)
    
    Sys.sleep(3)
}

########################################################################
#           随机游走的scale越小模拟越细致，但是样本值之间独立性减弱
#           随机游走的scale越大模拟越疏松，样本值之间独立性增强，
#           随着次数增大，其模拟效果也会变好
#
########################################################################
op <- par(mfrow = c(1, 1))
scale <- c(1, 10, 100)
for (scale in scale) {
    result <-MH(target = target, scale = scale, start = 2, m = 1000, mu1 = 0,
        lamda1 = 2, mu2 = 10, lamda2 = 2)
    h <- hist(result$sample, breaks = 20, freq = F, main = paste("模拟次数:", m))
    h.x <- c(min(h$breaks)-3, min(h$breaks), h$breaks, max(h$breaks) + 3)
    h.d <- c(0, 0, h$density, 0, 0)
    c <- curve(target(x, mu1 = 0, lamda1 = 2, mu2 = 10,
        lamda2 = 2), from = -7, to = 17, add = T, col = 2)
    c.x <- c$x
    c.y <- c$y
    r.x <- seq(-7, 17, length = 2)
    r.y <- r.x
    r.z <- array(0, c(2, 2))
    r.z[2, 2] <- -0.0001
    
    persp(r.x, r.y, r.z, border = NA, shade = 1, col = "white",
        ylim = c(-7, 17), xlim = c(0, 4), zlim = c(0, 0.2), box = F
        ,theta = 45) -> res
    lines(trans3d(x = 0, y = h.x, z = h.d, pmat = res), col = 3, type = 's')
    lines(trans3d(x = 4, y = c.x, z = c.y, pmat = res), col = 2)
    lines(trans3d(x = seq(0, 4, length = 1000), y = result$sample,z = 0, pmat = res),
        col = 4)
    Sys.sleep(5)
}

########################################################################
#
#      模拟次数变大时，即使scale很大，效果也会好转
########################################################################  

    
result <-MH(target = target, scale = scale, start = 2, m = 10000, mu1 = 0,
        lamda1 = 2, mu2 = 10, lamda2 = 2)
plot(result$sample, type = 'l')
h <- hist(result$sample, breaks = 20, freq = F, main = paste("模拟次数:", m))
curve(target(x, mu1 = 0, lamda1 = 2, mu2 = 10,
    lamda2 = 2), from = -7, to = 17, add = T)





        
        
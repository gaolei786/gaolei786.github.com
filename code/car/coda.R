phi07 <- read.table('S1[8].txt', header = F, sep = '')
plot(phi07[, 1:2], type = 'l', xlim = c(1000, 51000), xlab = '样本轨迹', 
     ylab=expression(phi[0][7]), col = rgb(0, 0, 0, 0.5))
seq(1050, 51000, by = 50)
q90 <- NULL
m <- NULL
t0 <- seq(51, 49950, length = 200)
for(t in t0){
  q90 <- rbind(q90, quantile(phi07[(t-50):(t+50), 2], c(0.05, 0.95)))
  m <- c(m, mean(phi07[(t-50):(t+50), 2]))
  
}
lines(t0+1000, m, lty = 3, lwd = 2)
polygon(c(990, 21000, 21000, 990, 990), c(-0.2, -0.2, 1.2, 1.2, -0.2),
        lty = 2, col = rgb(0, 0, 0, 0.1))
rect(21000, 0.5, 55000, 1.2)
arrows(36000, 0.1, 36000, 0.4, length = 0.15, angle = 30)

par(fig=c(0.32,1, 0.25,  1), new = T)
plot(phi07[20001:50000, 1:2], type = 'l',xlab = '',
      col = rgb(0, 0, 0, 0.5), axes = F, ylab = '', xlim = c(21000, 51000))
# lines(t0+1000, m, lty = 3, lwd = 2)

segments(21000,mean(phi07[20001:50000, 2]), 51000,
         mean(phi07[20001:50000, 2]) ,lty = 3, lwd = 2 )

par(mfrow = c(1, 2))
acf(phi07[20001:50000,2], main = '')
acf(phi07[seq(20001, 50000, by = 30),2], main = '')
phi07 <- phi07[seq(20001, 50000, by = 30),]


hist(phi07[, 2], freq = F, main = '', 
     xlab = '', breaks = 15, ylim = c(-1, 17), ylab = '')
points(mean(phi07[, 2]), -0.9, pch = 17, cex = 1.3)
points(quantile(phi07[, 2], probs = 0.025), -0.9, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
points(quantile(phi07[, 2], probs = 0.975), -0.9, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
m <- mean(phi07[, 2])
q1 <- quantile(phi07[, 2], probs = 0.025)
q2 <- quantile(phi07[, 2], probs = 0.975)
segments(m, 0, m, 5, lwd = 2, lty = 3)
segments(q1, 0, q1, 5, lwd = 2, lty = 3)
segments(q2, 0, q2, 5, lwd = 2, lty = 3)
box()
lines(density(phi07[,2]))
legend('topright',legend = c("样本均值", "2.5%(97.5%)分位数") ,
       pch=c(17, 24), pt.bg =  rgb(0, 0, 0, 0.3), cex = 0.7)



fun <- function(x){
  q <- quantile(x, probs = c(0.025, 0.05, 0.975))
  r <- c(mean(x), sd(x), q, q[3]-q[1])
  return(r)
}
x3.19poi <- read.table('X3.19poi.txt', header = F)
x3.19odp <- read.table('X3.19odp.txt', header = F)
x3.19car <- read.table('X319car.txt', header = F)
fun(x3.19poi[, 2])
fun(x3.19odp[, 2])
fun(x3.19car[, 2])

T3poi <- read.table('T3poi.txt', header = F)
T3odp <- read.table('T3odp.txt', header = F)
T3car <- read.table('T3car.txt', header = F)
fun(T3poi[, 2])
fun(T3odp[, 2])
fun(T3car[, 2])

Tpoi <- read.table('Tpoi.txt', header = F)
Todp <- read.table('Todp.txt', header = F)
Tcar <- read.table('Tcar.txt', header = F)
fun(Tpoi[, 2])
fun(Todp[, 2])
fun(Tcar[, 2])

r <- rbind(fun(Tpoi[, 2]), 
      fun(Todp[, 2]), 
      fun(Tcar[, 2]))
write.table(r, file = 'clipboard', sep = '\t')







# x3.19car <- x3.19car[seq(1, 30000, by = 30), ]
# T3car <- T3car[seq(1, 30000, by = 30), ]
# Tcar <- Tcar[seq(1, 30000, by = 30), ]
hist(x3.19car[, 2], freq = F, main = '', ylab = '', xlab = '',
     ylim = c(-0.0004, 0.004), breaks = 15)
points(mean(x3.19car[, 2]), -0.0003, pch = 17, cex = 1.3)
points(quantile(x3.19car[, 2], probs = 0.025), -0.0003, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
points(quantile(x3.19car[, 2], probs = 0.975), -0.0003, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
m <- mean(x3.19car[, 2])
q1 <- quantile(x3.19car[, 2], probs = 0.025)
q2 <- quantile(x3.19car[, 2], probs = 0.975)
segments(m, 0, m, 0.0015, lwd = 2, lty = 3)
segments(q1, 0, q1, 0.0015, lwd = 2, lty = 3)
segments(q2, 0, q2, 0.0015, lwd = 2, lty = 3)
# abline(v = mean(x3.19car[, 2]), lwd = 2, lty = 2)
# abline(v=quantile(x3.19car[, 2], probs = 0.025), lwd = 2, lty = 3)
# abline(v=quantile(x3.19car[, 2], probs = 0.975), lwd = 2, lty = 3)
box()
lines(density(x3.19car[, 2]))
legend('topright',legend = c("样本均值", "2.5%(97.5%)分位数") ,
       pch=c(17, 24), pt.bg =  rgb(0, 0, 0, 0.3), cex = 0.7)


hist(T3car[, 2], freq = F, main = '', ylab = '', xlab = '',
     ylim = c(-0.0001, 0.0015))
points(mean(T3car[, 2]), -0.0001, pch = 17, cex = 1.3)
points(quantile(T3car[, 2], probs = 0.025), -0.0001, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
points(quantile(T3car[, 2], probs = 0.975), -0.0001, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
m <- mean(T3car[, 2])
q1 <- quantile(T3car[, 2], probs = 0.025)
q2 <- quantile(T3car[, 2], probs = 0.975)
segments(m, 0, m, 0.0005, lwd = 2, lty = 3)
segments(q1, 0, q1, 0.0005, lwd = 2, lty = 3)
segments(q2, 0, q2, 0.0005, lwd = 2, lty = 3)
lines(density(T3car[, 2]))
box()
legend('topright',legend = c("样本均值", "2.5%(97.5%)分位数") ,
       pch=c(17, 24), pt.bg =  rgb(0, 0, 0, 0.3), cex = 0.7)


hist(Tcar[, 2], freq = F, main = '', ylab = '', xlab = '', 
     ylim = c(-0.15e-05, 1.5e-05), xlim = c(1350000, 1600000))
abline(h=0)
points(mean(Tcar[, 2]), -0.1e-05, pch = 17, cex = 1.3)
points(quantile(Tcar[, 2], probs = 0.025), -0.1e-05, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
points(quantile(Tcar[, 2], probs = 0.975), -0.1e-05, 
       pch = 24, cex = 1.1, bg = rgb(0, 0, 0, 0.3))
m <- mean(Tcar[, 2])
q1 <- quantile(Tcar[, 2], probs = 0.025)
q2 <- quantile(Tcar[, 2], probs = 0.975)
segments(m, 0, m, 0.5e-05, lwd = 2, lty = 3)
segments(q1, 0, q1, 0.5e-05, lwd = 2, lty = 3)
segments(q2, 0, q2, 0.5e-05, lwd = 2, lty = 3)
# abline(v = mean(Tcar[, 2]), lwd = 2, lty = 2)
# abline(v=quantile(Tcar[, 2], probs = 0.025), lwd = 2, lty = 3)
# abline(v=quantile(Tcar[, 2], probs = 0.975), lwd = 2, lty = 3)
lines(density(Tcar[, 2]))
box()
legend('topright',legend = c("样本均值", "2.5%(97.5%)分位数") ,
       pch=c(17, 24), pt.bg =  rgb(0, 0, 0, 0.3), cex = 0.7)




resi <- read.table('resi4.txt',sep = '', header = F)
resi <- resi[, 2]
I <- 21
par(mar = c(1, 1, 1, 1))
plot(0, type = 'n', xlim = c(-1,I+1), ylim=c(-1,I+1),
     ylab = "", axes = F,xlab = "")
mm <- 1
data.unscaled.resi1 <- matrix(NA, nrow = I+1, ncol = I+1)
for (i in 0:I) {
  for (j in 0:(I-i)){
    data.unscaled.resi1[i+1, j+1] <- resi[mm]
    if(resi[mm]>0){
      text(j,I-i,"+")
    } else if(resi[mm]<0) {
      #       text(j,I-i,"-", col = 2)
      text(j,I-i,"-")
    } else {
      text(j,I-i,"o")
    }
    mm <- mm+1
  }
  
}
for(i in 0:I){
  text(-1,I-i,i,cex = 0.7)
}
for(j in 0:I){
  text(j,I+1.5,j,cex = 0.7)
}

x <- c(-0.5, -0.5, 0.5, 4.5,4.5, 0)
y <- c(-0.5, 4.3, 4.3, 0.3, -0.4, -0.4)
x <- c(-0.5, -0.5, 0.5, 0.5, 1.5, 1.5, 2.5, 2.5, 3.5, 3.5, 4.5, 4.5, -0.5)
y <- c(-0.5, 4.5, 4.5, 3.5, 3.5, 2.5, 2.5, 1.5, 1.5, 0.5, 0.5, -0.5, -0.5)
# abline(v=0)
# abline(h=21)
polygon(y, I-x, lty = 3)
x <- c(8.5, 8.5, 5.5, 5.5, 6.5, 6.5, 11.5, 11.5, 12.5, 12.5, 8.5)
y <- c(-0.5, 0.5, 0.5, 2.5, 2.5, 3.5, 3.5, 1.5, 1.5, -0.5, -0.5)
polygon(y, I-x, lty = 3)

x <- c(15.5, 15.5, 12.6, 12.6, 14.5, 14.5, 16.5, 16.5, 17.5, 17.5, 
       18.5, 18.5, 15.5)
y <- c(-0.5, 0.5, 0.5,   4.5, 4.5, 3.5, 3.5, 2.5, 2.5, 1.5, 1.5, -0.5, 
       -0.5)
polygon(y, I-x, lty = 3)

x <- c(4.5, 4.5, 3.5, 3.5, 7.5, 7.5, 4.5)
y <- c(8.5, 9.5, 9.5, 10.5, 10.5, 8.5, 8.5)
polygon(y, I-x, lty = 3)

x <- c(6.5, 6.5, 5.5, 5.5, 7.5, 7.5, 6.5)
y <- c(4.5, 5.5, 5.5, 8.3, 8.3, 4.5, 4.5)
polygon(y, I-x, lty = 3)








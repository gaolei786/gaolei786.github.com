 




load(file="odpgai2121.RData")

odpgai1 <- Mack.boot.result1
odpgai2 <- Mack.boot.result2
odpgai3 <- Mack.boot.result3

bzcgai <- apply(odpgai3, 2, sd)
bzcgai
sd(apply(odpgai3, 1, sum)) 

cut <- seq(1271699, 1636343, length = 40)
odpgai.sum <- apply(odpgai3, 1, sum)
hgai <- hist(odpgai.sum, breaks = cut, freq = F)
dgai <- density(odpgai.sum, breaks = cut)

load(file="odpboot2121.RData")

odp1 <- Mack.boot.result1  
odp2 <- Mack.boot.result2  
odp3 <- Mack.boot.result3 

odp.sum <- apply(odp3, 1, sum)

summary(odp.sum)

fun <- function(df){
  m <- mean(df)
  msep <- sd(df)
  sdv <- msep/m
  qq <- quantile(df, 0.75)-quantile(df, 0.25)

  return(c(m,msep,sdv,qq))
}
abs(fun(odp.sum)-fun(odpgai.sum))/fun(odp.sum)


d1 <- NULL
d1 <- rbind(d1, fun(odp3[,7]))
d1 <- rbind(d1, fun(odpgai3[,7]))

d1 <- rbind(d1, fun(odp3[,14]))
d1 <- rbind(d1, fun(odpgai3[,14]))


d1 <- rbind(d1, fun(odp3[,21]))
d1 <- rbind(d1, fun(odpgai3[,21]))

d1 <- rbind(d1, fun(odp.sum))
d1 <- rbind(d1, fun(odpgai.sum))



write.csv(t(d1), file = "d1.csv")







min(odp.sum)
max(odp.sum)


bzc <- apply(odp3, 2, sd)
bzc
sd(apply(odp3, 1, sum)) 


summary(odp.sum)




summary(odpgai3[,7])
sd(odpgai3[,7])
summary(odp3[,7])
sd(odp3[,7])
hist(odpgai3[,7], freq = F)
lines(density(odpgai3[,7]), col = 2)
lines(density(odp3[,7]))



# par(mfrow = c(1,3), mar = c(4,2,3,1))
plot(odpgai1[[1]][14,], type='n', xlab = "", ylab = "",
     axes = F)
lines(1:9,odpgai1[[1]][14,1:9], type='b' )
axis(2, at = seq(0, 120000, length = 4), labels =seq(0, 120000, length = 4),
     padj=1)
mtext("增量赔款", 2, line = 1.6, cex = 1.3)
mtext("进展�?", 1, line = 1.6, cex = 1.3)

axis(1, at = seq(1, 22, by = 2), labels = seq(0, 21, by = 2),
     padj = -0.9)
for ( i in 1:100) {
  lines(9:22, odpgai1[[i]][14,9:22], col = rgb(0,0,0,0.3))
}
legend('topright', lty = c(1,1),pch=c(1,NA),
       legend = c("已知�?","模拟�?"), cex = 1.1)
box()
par(fig=c(0.2,0.75, 0.3,  0.9), new = T)
x1 <- c(0, rep(1:22, each = 2), 0)
y1 <- rep(0:22, each = 2)
plot(x1, y1, type = 'n', xlab = '', ylab = '', axes = F)
polygon(x1, y1, col = rgb(0,0,0,0.1))
rect(0:8,rep(8, 9),1:9,rep(9, 9))
rect(8:21,rep(8, 15),9:22,rep(9, 15), lty = 3)
rect(0, 0, 22, 22)





# 2 -----------------------------------------------------------------------
sanbu <- NULL
for ( i in 1:2000) {
  sanbu <- rbind(sanbu, odpgai1[[i]][14,])
}
dd <- apply(sanbu, 2, quantile, c(0.05, 0.95))
dd1 <- apply(sanbu, 2, mean)

plot(odpgai1[[1]][14,], type='n', xlab = "", ylab = "",
     axes = F)
lines(1:9,odpgai1[[1]][14,1:9], type='b' )
axis(2, at = seq(0, 120000, length = 4), labels =seq(0, 120000, length = 4),
     padj=1)
mtext("增量赔款", 2, line = 1.6, cex = 1.3)
mtext("进展�?", 1, line = 1.6, cex = 1.3)

axis(1, at = seq(1, 22, by = 2), labels = seq(0, 21, by = 2),
     padj = -0.9)
box()
lines(9:22, dd[1, 9:22], lty = 3)
points(9:22, dd[1, 9:22], pch = 8, cex = 0.5)
lines(9:22, dd[2, 9:22], lty = 3, pch = 3)
points(9:22, dd[2, 9:22],  pch = 8, cex = 0.5)
lines(9:22,dd1[9:22])
points(9:22,dd1[9:22],  pch = 8, cex = 0.5)
legend('topright', lty = c(1,1,3),pch=c(1,8,8),
       legend = c("已知�?","均�?","90%区间的上下界"), cex = 1.1)
par(fig=c(0.25,0.7, 0.2,  0.8), new = T)
plot(9:10,odpgai1[[1]][14,9:10], type='n',
     axes = F, xlab = '', ylab = '', ylim = c(1000, 25000), xlim = c(9, 12))
for ( i in 1:1000) {
  lines(9:10, odpgai1[[i]][14,9:10], col = rgb(0,0,0,0.3))
}
box()
zeng10 <- NULL
for (i in 1:2000){
  zeng10 <- c(zeng10, odpgai1[[i]][14,10])
}
h <- hist(zeng10, freq = NULL, breaks = 15, plot = F)
for (i in 1:14) {
  y <- c(h$mids[i]-1000, h$mids[i]-1000, h$mids[i]+1000, h$mids[i]+1000)
  x <- c(10, 10 + 15000*h$density[i], 10 + 15000*h$density[i],
         10 )
  polygon(x, y, col = rgb(0,0,0,0.1))
}
qua <- quantile(zeng10, c(0.05, 0.95))
m <- mean(zeng10)
segments(10, qua[1], 11.8, qua[1], lty = 3 , lwd = 2)
segments(10, qua[2], 11.8, qua[2], lty = 3 , lwd = 2)
segments(10, m, 11.8, m, lty = 1 , lwd = 2, col = rgb(0,0,0,0.8))


# 3 -----------------------------------------------------------------------



# 4 -----------------------------------------------------------------------
summary(odpgai3[,14])
sd(odpgai3[,14])
summary(odp3[,14])
sd(odp3[,14])
hgai<- hist(odpgai3[,14], freq = F, main = "", xlab = "未决赔款",
     ylab = "密度", ylim = c(0, 5e-5), breaks = 25)
h<- hist(odp3[,14], freq = F, main = "", xlab = "未决赔款",
            ylab = "密度", ylim = c(0, 5e-5), breaks = 25)
dgai <- density(odpgai3[,14])
d <- density(odp3[,14])
xgai <- rep(hgai$breaks, each = 2)
ygai <- c(0, rep(hgai$density, each = 2), 0)
x <- rep(h$breaks, each = 2)
y <- c(0, rep(h$density, each = 2), 0)

plot(xgai, ygai, type = 'l', ylim = c(-5e-05,5e-05), 
     xlab = '',
     ylab = '', axes = F)
mtext( '13事故年未决赔�?', 1, line = 1.6, cex = 1.3)
mtext("密度", 2, line = 1.6, cex = 1.3)
lines(x, y, lty = 2)
box()
axis(1, c(5e+4, 7e+4, 9e+4),c(5e+4, 7e+4, 9e+4), padj = -0.7)
axis(2,c(-3e-5, 0, 3e-5),c(3e-5, 0, 3e-5), padj= 1)
abline(h=-0.1e-06)
lines(dgai$x,-dgai$y-0.2e-06)
lines(d$x,-d$y-0.2e-06, lty = 2)

legend('topright', lty = c(1,2),
       legend = c("分块Bootstrap","传统Bootstrap"), cex = 1.1)





# 单个事故年分�? -----------------------------------------------------------------

summary(odpgai3[,21])
sd(odpgai3[,21])
summary(odp3[,21])
sd(odp3[,21])
par(mfrow=c(1,2))

plot(odpgai1[[1]][21,],  type='n', xlab = "进展�?", ylab = "增量赔款",
     axes = F)
axis(2)
box()
axis(1, at = seq(1, 22, by = 2), labels = seq(0, 21, by = 2))
for ( i in 1:100) {
  lines(odpgai1[[i]][21,], col = rgb(0,0,0,0.3))
}
# sanbu <- NULL
# for ( i in 1:2000) {
#   sanbu <- rbind(sanbu, odpgai1[[i]][21,])
# }
# dd <- apply(sanbu, 2, quantile, c(0.05, 0.95))
# dd1 <- apply(sanbu, 2, mean)
# plot(odpgai1[[1]][21,], type='n', xlab = "进展�?", ylab = "增量赔款",
#      axes = F)
# axis(2)
# box()
# axis(1, at = seq(1, 22, by = 2), labels = seq(0, 21, by = 2))
# lines(2:22, dd[1, 2:22], lty = 3)
# lines(2:22, dd[2, 2:22], lty = 3)
# lines(dd1)

hist(odpgai3[,21], freq = F,  main = "", xlab = "事故年i=20的未决赔�?",
     ylab = "密度", ylim = c(0, 3.5e-5), breaks = 26)
lines(density(odpgai3[,21]), col = rgb(0,0,0,0.9))
lines(density(odp3[,21]),lty=2)


# 总分�? ---------------------------------------------------------------------


summary(odpgai.sum)
sd(odpgai.sum)
summary(odp.sum)
sd(odp.sum)
hist(odpgai.sum, freq = F, breaks = 25)
lines(density(odpgai.sum), col = 2)
lines(density(odp.sum))

# 作图 ----------------------------------------------------------------------

hgai <- hist(odpgai.sum, breaks = cut, freq = F)
dgai <- density(odpgai.sum, breaks = cut)
xgai <- rep(hgai$breaks, each = 2)
ygai <- c(0, rep(hgai$density, each = 2), 0)
plot(xgai, ygai, type = 'l', ylim = c(-9e-06,9e-06), 
     xlab = '',
     ylab = '', axes = F)
box()
axis(1, padj = -0.7)
axis(2, c(-5e-6,0, 5e-6), c(5e-6,0, 5e-6), padj = 1)
mtext("总未决赔�?",1,  line = 1.6, cex = 1.3)
mtext("密度",2, line = 1.6, cex = 1.3 )
min(odpgai.sum)
max(odpgai.sum)
mean(odpgai.sum)




 h <- hist(odp.sum, breaks = cut, , plot = F, freq = F)
d <- density(odp.sum, breaks = cut)
mean(odp.sum)
x <- rep(h$breaks, each = 2)
y <- c(0, rep(h$density, each = 2), 0)
lines(x, y, lty = 2)
summary(odp.sum)

# plot(xgai, ygai, type = 'n')
abline(h=-0.1e-06)
lines(dgai$x,-dgai$y)
lines(d$x,-d$y, lty = 2)

legend('topright', lty = c(1,2),
       legend = c("分块Bootstrap","传统Bootstrap"), cex = 1.1)

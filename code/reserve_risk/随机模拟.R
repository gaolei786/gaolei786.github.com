
# 加载包 ---------------------------------------------------------------------
library(MASS)
library(ggplot2)

# CDR的模拟 ------------------------------------------------------------------
CDR <- NULL
mm <- 5000
set.seed(123)
for (kk in 1:mm) {
  Theta <- mvrnorm(1, vDJ, TDJ)
  epsilon <- mvrnorm(J, Theta, V)
  fun <- function(i) {
    data1[i+1, J-i+1] * exp(epsilon[i, J-i+2])
  }
  newdiag <- sapply(1:J, fun)
  for (i in 1:J) {
    data1[i+1, J-i+2] <-   newdiag[i]
  }
  fun <- function(i) {
    X <- NULL
    for (j in 0:(J-i+1)) {
      if (i == 0) {
        X <- c(X, data1[i+1, j+1])
      
      } else {
        X <- c(X, data1[i+1, j+1])
        X <- (X)
      }
    }
    return((log(X)))
  } 
  X1.J1 <- sapply(0:I, fun)

  fun <- function(i) {
     t(B1.i[[max(c(i-1), 0)+1]])%*% solve(Sigma11.i[[max(c(i-1), 0)+1]]) %*%
     X1.J1[[i+1]]  
  }

  ll1 <- lapply(0:J, fun)
  ll <- ll1[[1]]
  for(i in 1:J) {
    ll <- ll1[[i+1]] + ll
  }
  vDJ1 <- TDJ1 %*% (solve(T) %*% v + ll) 
  fun <- function(i) {
    if(i !=1 ){
      exp(Gamma.i[[i-1+1]] %*% vDJ1 + Gamma.i[[i-1+1]] %*% TDJ1 %*% t(Gamma.i[[i-1+1]]) / 2+
      t(e.i[[i-1+1]]) %*% Sigma21.i[[i-1+1]] %*% solve(Sigma11.i[[i-1+1]]) %*% 
      X1.J1[[i+1]] + t(e.i[[i-1+1]]) %*% Sigma22.i.p[[i-1]] %*% e.i[[i-1+1]] / 2)
    } else {
      data1[i+1, 10]
    }
  }
  i <- 2
  PiJ1 <- sapply(1:I, fun)
  CDR <- rbind(CDR, PiJ1-PiJ)
}
save(CDR, file = "CDR.RData")


# CDR样本特征 -------------------------------------------------------------------
summary(CDR.sum)
CDR.sum <- apply(CDR, 1, sum)
min(CDR.sum)/1000
quantile(CDR.sum, 0.005)/1000
mean(CDR.sum)/1000
sd(CDR.sum)/1000 *qnorm(0.005)
max(CDR.sum)/1000
apply(CDR,2, sd)/1000
summary(CDR)
round(sd(apply(CDR, 1, sum))/1000, 5)
write.table(apply(CDR,2, sd)/1000, file = "moni1.csv",  sep = "\t", row.names = F)


# CDR经验分布 -----------------------------------------------------------------
options(digits=2)
hd <- hist(CDR.sum, breaks = 50, freq = F)
inde <- which(CDR.sum<=quantile(CDR.sum, 0.005))
plot((1:5000)[-inde], CDR.sum[-inde], xlim = c(0, 8000), 
   col = rgb(0, 0, 0, 0.2), cex = 0.7, ylim = c(-4.5*10^6, 4*10^6),
   xlab = '', ylab = '', axes=F)
axis(side=1,at=c(0,1000,2000,3000,4000,5000),labels=c(0,1000,2000,3000,4000,5000))
box()
axis(2)
axis(3,at=c(5100,6000,7000,8000), labels=c('0','1.3e-7','2.7e-7','4.0e-7'))
de <- density(CDR.sum)
# lines(de$y*7.5*10^9+5100, de$x, col = rgb(0, 0, 0, 0.6), lwd = 2)
abline(v = 5100, col = rgb(0, 0, 0, 0.6), lwd = 2)
points(inde, CDR.sum[inde], pch = 8,col = rgb(0, 0, 0, 0.7), cex = 0.7)
#abline(h = quantile(CDR.sum, 0.005), col = rgb(0, 0, 0, 0.6), lwd = 2)
segments(0, quantile(CDR.sum, 0.005), 5100, quantile(CDR.sum, 0.005),
   col = rgb(0, 0, 0, 0.6), lwd = 2)
segments(0,mean(CDR.sum), 5100, mean(CDR.sum),
   col = rgb(0, 0, 0, 0.6), lwd = 2)
abline(v = 0 , col = rgb(0, 0, 0, 0.6), lwd = 2)
inde2 <- which(de$x<= quantile(CDR.sum, 0.005))
# polygon(c(de$y[inde2]*7.5*10^9+5100, 5100), c(de$x[inde2[-length(inde2)]], 
#     quantile(CDR.sum, 0.005),quantile(CDR.sum, 0.005)), col =rgb(0, 0, 0, 0.6)  )
text(6200, quantile(CDR.sum, 0.005)-600000, expression(alpha==0.005))
mean(CDR.sum)
for(i in 1:43){
  y <- c(hd$mids[i]-100000, hd$mids[i]-100000, hd$mids[i]+100000, hd$mids[i]+100000)
  x <- c(0, hd$density[i],hd$density[i],0 )*7.5*10^9+5100
  polygon(x,y)
}
segments(5100, quantile(CDR.sum, 0.005), 7000, quantile(CDR.sum, 0.005),
         col = rgb(0, 0, 0, 0.6), lwd = 2, lty = 2)





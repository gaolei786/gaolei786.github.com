library(ChainLadder)
library(CARBayes)
library(lawstat)
I <- 21
data <- read.table("data2121.csv", sep = ",")
data <- data[-1, ]
data <- data[,-1]
x1 <- NULL
x2 <- NULL
Y <- NULL
for(i in 1:(I+1)){
  for(j in 1:(I+1)){
    if(j > I+2-i){
      Y <- c(Y, NA)
    }else{
      Y <- c(Y, data[i,j])
    }
    x1 <- c(x1, i)
    x2 <- c(x2, j)
    
  }
}
Y <- rbind(NULL, Y)
# write.table(Y, file = 'Y.txt', sep = ',')
K <- length(x2)


Y.i <- NULL
for(i in 1:(I+1)){
  for(j in 1:(I+1)){
    if(j <= I+2-i){
      Y.i <- c(Y.i, NA)
    }else{
      Y.i <- c(Y.i, data[I+2-j,j])
    }
    
  }
}
Y.i <- rbind(NULL, Y.i)
# write.table(Y.i, file = 'Y.i.txt', sep = ',')

K <- length(x2)
C <- NULL
adj <- NULL
num <- NULL
for(i in 1:K)
{
  num1 <- 0
  for(j in 1:K)
  {
    temp <- (x1[i] - x1[j])^2 + (x2[i] - x2[j])^2
    
    if(temp==1){
      adj <- c(adj, j)
      num1 <- num1 + 1
    }
  }
  num <- c(num, num1)
  C <- c(C, rep(1/num1, num1))
}
num <- rbind(NULL, num)
# write.table(num, file = 'num.txt', sep = ',')

adj <- rbind(NULL, adj)
# write.table(adj, file = 'adj.txt', sep = ',')

C <- rbind(NULL, C)
write.table(C, file = 'C.txt', sep = ',')

library(lawstat)
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



qq <- quantile(resi, probs = 1:2/4)
plot(0, type = 'n', xlim = c(-1,I+1), ylim=c(-1,I+2),
     ylab = "", axes = F,xlab = "")
for (i in 0:I) {
  for (j in 0:(I-i)){
    rr <- data.unscaled.resi1[i+1,j+1]
    if(rr < qq[1]){
      col <- 1/7
    }else if(rr < qq[2]){
      col <- 4/7
    }else {
      col <- 6/7
    }
    rect(j-0.5, (I+1-i)-0.5, j+0.5, (I+1-i)+0.5,  col = gray(1-col))
  }
}
segments(-0.5, 0.5, 21.5, 0.5, lty = 2)
segments(21.5, 0.5, 21.5, 22.5, lty = 2)

for(i in 0:I){
  text(-0.2, I+1-i, i, pos = 2, cex =0.7)
}
for(j in 0:I){
  text(j, 21.8, j, pos = 3, cex =0.7)
}
rect(15-0.5, 6-0.5, 15+0.5, 6+0.5, col = gray(1-1/7) )
text(15+0.3, 6, "<-0.5716", pos = 4, cex = 0.8)
rect(15-0.5, 4.5-0.5, 15+0.5, 4.5+0.5, col = gray(1-3/7) )
text(15+0.3, 4.5, "-0.5716~-0.1369", pos = 4, cex = 0.8)
rect(15-0.5, 3-0.5, 15+0.5, 3+0.5, col = gray(1-4/7) )
text(15+0.3, 3, "-0.1369~0.5343", pos = 4, cex = 0.8)



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
    
    if(temp == 1){
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
#write.table(C, file = 'C.txt', sep = ',')
library(ChainLadder)

i <- 1
I <- 9
J <- 9
data <- read.table("data1.txt", sep = "")
rownames(data) <- 0:I
colnames(data) <- 0:I
data <- cbind(expand.grid(0:I, 0:I), as.vector(as.matrix(data)))
data[, 3] <- ifelse(data[, 3] == 0, NA, data[, 3])
data <- data[!is.na(data[[3]]), ]
names(data) <- c("accyear", "devyear", "value")
data <- as.triangle(data, origin = "accyear", dev = "devyear", value = "value")
Mack.data <- MackChainLadder(data, est.sigma="Mack")
f <- Mack.data$f
sigma2 <- Mack.data$sigma^2
R0 <- summary(Mack.data)$Totals[4, 1]

fun2 <- function(j) {
  if (j < (J-1)) {
    return((data[I-j +1, j+1]/sum(data[1:(I-j+1), j+1]))^2*
    sigma2[j+1]/f[j+1]^2/sum(data[1:(I-j),j+1]))
  } else {
    return(0)
  }
}
fun1 <- function(i) {
  r1 <- sigma2[I-i+1]/f[I-i+1]^2/sum(data[1:(i), I-i+1]) 
  r2 <- sum(sapply((I-i+1):(J-1), fun2))
  return(r1 +r2)
}

delta.J <- sapply(1:I, fun1)
fun4 <- function(j) {
  if (j < (J-1)) {
    return((data[I-j +1, j+1]/sum(data[1:(I-j+1), j+1]))^2*
    sigma2[j+1]/f[j+1]^2/data[I-j+1, j+1])
  } else {
    return(0)
  }
}

fun3 <- function(i) {
  sum(sapply((I-i+1):(J-1), fun4))
}
phi.J <- sapply(1:I, fun3)

omegan <- sapply(1:I, function(i) sigma2[I-i+1] / f[I-i+1]^2 / data[i + 1, I-i+1])
Ga <- phi.J + omegan
(Mack.data$Full[2:(I+1),(I+1)]^2*(omegan))^0.5
(Mack.data$Full[2:(I+1), (I+1)]^2*(Ga + delta.J))^0.5

options(digits=20)
write.table((Mack.data$Full[2:(I+1), (I+1)]^2*(Ga + delta.J))^0.5/1000, file = "mack1.csv", 
    sep = "\t", row.names = F)

(Mack.data$Full[2:(I+1), (I+1)]^2*(phi.J + delta.J))^0.5
fun5 <- function(i) {
  r1 <- data[i+1, I-i+1]/sum(data[1:(i+1),I-i+1])*sigma2[I-i+1]/f[I-i+1]^2/
    sum(data[1:i, I-i+1]) 
  r2 <- sum(sapply((I-i+1):(J-1), fun2))
  return(r1 + r2)
}

Lambda <- sapply(1:I, fun5 )
C.ultimate <- Mack.data$Full[2:(I+1),(I+1)]
(2*sum(cumsum(C.ultimate[I:1])[(I-1):1]*(phi.J[1:(I-1)] + Lambda[1:(I-1)])*C.ultimate[1:(I-1)])+
sum((Mack.data$Full[2:(I+1), (I+1)]^2*(phi.J + delta.J))))^0.5

alpha <- phi.J + sapply(1:I, function(i) sigma2[I-i+1]/(f[I-i+1])^2/sum(data[1:(i+1), I-i+1]))

(2*sum((alpha[1:(I-1)]+Lambda[1:(I-1)])*C.ultimate[1:(I-1)]*cumsum(C.ultimate[I:1])[(I-1):1])+
sum(Mack.data$Full[2:(I+1), (I+1)]^2*(Ga + delta.J)))^0.5


(2*sum((alpha[1:(I-1)]+Lambda[1:(I-1)])*C.ultimate[1:(I-1)]*cumsum(C.ultimate[I:1])[(I-1):1])+
sum(Mack.data$Full[2:(I+1), (I+1)]^2*(Ga + delta.J)))^0.5/1000
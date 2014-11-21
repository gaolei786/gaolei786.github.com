data1 <- read.table("data1.txt", header = F)
I <- 9
J <- 9

fun1 <- function(j) {
  if (j == 0) {
    sd(log(data1[, j+1]))
  } else{
    sd(log(data1[1+(0:(I-j)), j+1] / data1[1+(0:(I-j)), j-1+1]))
  } 
}

sigma.j <- sapply(0:(J-1), fun1)
sigma.j <- c(sigma.j, min(sigma.j[J]^2/sigma.j[J-1]^2, sigma.j[J-1]^2)^0.5)


V <- diag(sigma.j^2)

B <- as.matrix(read.table("data4.csv", header = F, sep = ","))

Sigma <- B%*%V%*%t(B)
Sigma11.i <- list()
Sigma12.i <- list()
Sigma21.i <- list()
Sigma22.i <- list()

for(i in 0:I) {
  if(i == 0) {
    Sigma11.i[[i+1]] <- Sigma
    Sigma12.i[[i+1]] <- NULL
    Sigma21.i[[i+1]] <- NULL
    Sigma22.i[[i+1]] <- NULL
  } else { 
    Sigma11.i[[i+1]] <- Sigma[1:(J-i+1), 1:(J-i+1)]
    Sigma22.i[[i+1]] <- Sigma[(J-i+1+1):(J+1), (J-i+1+1):(J+1)]
    Sigma12.i[[i+1]] <- Sigma[1:(J-i+1),(J-i+1+1):(J+1)]
    Sigma21.i[[i+1]] <- Sigma[(J-i+1+1):(J+1),1:(J-i+1)]
  }
}
Sigma11.i[[1]]
Sigma11.i[[2]]


B1.i <- list()
B2.i <- list()
for(i in 0:J) {
  if(i == 0) {
    B1.i[[i+1]] <- B
    B2.i[[i+1]] <- B[((J-i)+1):((J-i)+1), ]
  } else {
    B1.i[[i+1]] <- B[1:(J-i+1), ]
    B2.i[[i+1]] <- B[(J-i+1+1):(J+1), ]
  }
}


## 下面来求$E[P_{i,J}|D_{J}]$
T <- diag(rep(100000000, J+1))  #$s^2_{m] \Rightarrow \infty$
v <- rep(1, J+1) #T比较大，会掩盖v

fun <- function(i) {
  print(i)
  print(t(B1.i[[i+1]]))
  print(solve(Sigma11.i[[i+1]]))
  if (i != J) {
    t(B1.i[[i+1]]) %*% solve(Sigma11.i[[i+1]]) %*% B1.i[[i+1]]
  } else {
    matrix(B1.i[[i+1]], ncol = 1) %*%  solve(Sigma11.i[[i+1]]) %*% 
      B1.i[[i+1]]
  }
}
ll <- lapply(0:J, fun)
ll1 <- ll[[1]]
for (i in 1:J) {
  ll1 <- ll[[i+1]] + ll1
}

TDJ <- solve(solve(T) + ll1) #$T(D_J)$的计算

fun <- function(i) {
  X <- NULL
  for (j in 0:(J-i)) {
    if (i == 0) {
      X <- c(X, data1[i+1, j+1])
      
    } else {
      X <- c(X, data1[i+1, j+1])
      X <- (X)
    }
  }
  return(log(X))
  
}

      
X1.J <- sapply(0:I, fun)

fun <- function(i) {
  print(i)
  if (i != J) {
    t(B1.i[[i+1]])%*% solve(Sigma11.i[[i+1]]) %*% X1.J[[i+1]]
  } else {
    matrix(B1.i[[i+1]], ncol = 1) %*% solve(Sigma11.i[[i+1]]) %*% 
      X1.J[[i+1]]
  }   
}

ll1 <- lapply(0:J, fun)
ll <- ll1[[1]]
for(i in 1:J) {
  ll <- ll1[[i+1]] + ll
}

vDJ <- TDJ %*% (solve(T) %*% v + ll) 

fun <- function(i) {
  e <- rep(0, i)
  e[i] <- 1
  return(e)
} 
  
e.i <- sapply(1:I, fun)
e.i <- c(0, e.i)


fun <- function(i) {
  print(i)
  e.i[[i+1]] %*% (B2.i[[i+1]] - Sigma21.i[[i+1]] %*% solve(Sigma11.i[[i+1]]) %*%
  B1.i[[i+1]])
}
Gamma.i <- lapply(1:J, fun)
Sigma21.i[[1]] <- Sigma[1, ]
Sigma12.i[[1]] <- Sigma[1, ]
Sigma22.i[[1]] <- Sigma[J+1, J+1]
Gamma.i <- c(list(B2.i[[1]] - Sigma21.i[[1]] %*% solve(Sigma11.i[[1]]) %*%
             B1.i[[1]]), Gamma.i)

fun <- function(i) {
  print(i)
  Sigma22.i[[i+1]] - Sigma21.i[[i+1]] %*% solve(Sigma11.i[[i+1]]) %*% Sigma12.i[[i+1]]
}
Sigma22.i.p <- lapply(1:I, fun)

fun <- function(i) {
  exp(Gamma.i[[i+1]] %*% vDJ + Gamma.i[[i+1]] %*% TDJ %*% t(Gamma.i[[i+1]]) / 2+
  t(e.i[[i+1]]) %*% Sigma21.i[[i+1]] %*% solve(Sigma11.i[[i+1]]) %*% 
  X1.J[[i+1]] + t(e.i[[i+1]]) %*% Sigma22.i.p[[i]] %*% e.i[[i+1]] / 2)
}
PiJ <- sapply(1:I, fun)


fun <- function(i) {
  PiJ[i] - data1[i+1, J-i+1]
}
sapply(1:I, fun)
sum(sapply(1:I, fun))


fun <- function(i) {

  t(B1.i[[max(c(i-1, 0))+1]]) %*% solve(Sigma11.i[[max(c(i-1, 0))+1]]) %*%
  B1.i[[max(c(i-1, 0))+1]]
}

ll <- lapply(0:J, fun)
ll1 <- ll[[1]]
for (i in 1:J) {
  ll1 <- ll[[i+1]] + ll1
}

TDJ1 <- solve(solve(T) + ll1) #$T(D_J1)$的计算



e.ip <- e.i
e.ip[[1]] <- 1
fun <- function(i) {
  fun1 <- function(i1) {
    if (i1 == 1) {
      
      x <- Gamma.i[[i-1+1]] %*% TDJ1 %*% t(B1.i[[max(c(i1-1, 0))+1]]) %*% 
           solve(Sigma11.i[[max(c(i1-1, 0))+1]]) 
      return(x[length(x)])
    } else {
      x <- Gamma.i[[i-1+1]] %*% TDJ1 %*% t(B1.i[[max(c(i1-1, 0))+1]]) %*% 
           solve(Sigma11.i[[max(c(i1-1, 0))+1]]) 
      return(x[ length(x)] )
    }    
  }
  mm <- (sapply(1:I, fun1))
  if(i==1) {
    x <- t(e.ip[[i]]) %*% Sigma21.i[[i-1+1]] %*% solve(Sigma11.i[[i-1+1]])
    mm[[i]] <- mm[[i]] + x[length(x)]
  } else {
    x <- t(e.ip[[i]]) %*% Sigma21.i[[i-1+1]] %*% solve(Sigma11.i[[i-1+1]])
    mm[[i]] <- mm[[i]] + x[ length(x)]
  }
  return(unlist(mm))
    
}

i <- 2
L.i <- lapply(1:I, fun)

Sigma.i <- list()
Sigma.i[[1]] <- Sigma22.i.p[[1]]
Sigma <- array(0, dim = c(J, J))
Sigma[1, 1] <- Sigma.i[[1]]
E.i <- list()
E.i[[1]] <- NULL
Gamma.k <- B2.i[[2]] - Sigma21.i[[2]] %*% solve(Sigma11.i[[2]]) %*% B1.i[[2]]
#Gamma.k <- NULL
for (i in 2:I) {
  e.i.1 <- rep(0, i)
  e.i.1[1] <- 1
  E.i[[i]] <- rbind(e.i.1)
  Sigma.i[[i]] <- E.i[[i]] %*% Sigma22.i.p[[i]] %*% t(E.i[[i]])
  Sigma[i,i] <- Sigma.i[[i]]
  Gamma.k <- rbind(Gamma.k, 
              t(e.i.1) %*% (B2.i[[i+1]] - Sigma21.i[[i+1]] %*% solve(Sigma11.i[[i+1]]) %*% B1.i[[i+1]])
              )
     
  
}
L.i[[1]] <- rep(0, 9)
L.i[[1]][1] <- 1
fun <- function(i) {
  PiJ[i]^2 * (exp(t(L.i[[i]]) %*% Gamma.k %*% TDJ %*% t(Gamma.k) %*% L.i[[i]] + L.i[[i]] %*% Sigma %*% L.i[[i]])-1)
}

i <- 2
cdr.mesp <- sapply(1:J, fun)^0.5/1000

msepsum1 <- sum(sapply(1:J, fun))

ki <- combn(1:J, 2)

fun <- function(i1) {
  k <- ki[1, i1]
  i <- ki[2, i1]
  PiJ[i] * PiJ[k] * (exp(L.i[[i]] %*% Sigma %*% L.i[[k]] +
  L.i[[i]] %*% Gamma.k %*% TDJ %*% t(Gamma.k) %*% L.i[[k]])-1) +
  PiJ[k] * PiJ[i] * (exp(L.i[[k]] %*% Sigma %*% L.i[[i]] +
  L.i[[k]] %*% Gamma.k %*% TDJ %*% t(Gamma.k) %*% L.i[[i]])-1)
}


write.table(cdr.mesp, file = "jiexi1.csv", 
    sep = "\t", row.names = F)
options(digits=20)
cdr.msepsum <- (msepsum1 + sum(sapply(1:ncol(ki), fun)))^0.5/1000 




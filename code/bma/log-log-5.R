set.seed(123)
library(ChainLadder)
library(geoR)
library(LearnBayes)
library(mvtnorm)
I <- 9
data <- read.table("data357848.txt", sep = "")
rownames(data) <- 0:I
colnames(data) <- 0:I
data <- cbind(expand.grid(0:I, 0:I), as.vector(as.matrix(data)))
data[, 3] <- ifelse(data[, 3] == 0, NA, data[, 3])
data <- data[!is.na(data[[3]]), ]
names(data) <- c("accyear", "devyear", "value")
data <- as.triangle(data, origin = "accyear", dev = "devyear", value = "value")
data <- incr2cum(data)



# log=log全部模拟 -------------------------------------------------------------
logu0 <- log(3901463)
k0 <- 0.00000001
v0 <- 0.05
sigma02 <- 2
v1 <- 0.05
sigma12 <- 2




logwtheta <- matrix(0, nrow = 10000, ncol = 2)





logwtheta[1, ] <- c(0.1, 0.1)
I <- 10

fun1 <- function(j, w, theta){
  return((j-0.5)^w/((j-0.5)^w+theta^w))
}
logpost <- function(logwtheta, dd){
  sigma2 <- dd[[1]]
  sigma2ult<- dd[[2]]
  logult<- dd[[3]]
  logulti<- dd[[4]]
  w <- exp(logwtheta[1])
  theta <- exp(logwtheta[2])
  logw <- logwtheta[1]
  logtheta <- logwtheta[2]
  ss <- 0
  for(i in 1:I){
    for (j in 1:(I+1-i)){
      ss <- ss+(log(data[i, j]) - 
                  logulti[i] - log(fun1(j, w, theta)))^2
    }
  }
  r <- -ss/(2*sigma2)  + dnorm(logw, 0, 100, log = T) + 
    dnorm(logtheta, 0, 100, log = T)
  return(r)
}

dd <- list(sigma2star, sigma2ultstar, logultstar, logultistar)
fit <- laplace(logpost, c(0, 0),dd )
mycontour(logpost, c(-0.5, 1, 0.5, 2), dd)


for(k in 2:10000){
  pro <- rmvnorm(1, mean=logwtheta[k-1, ], sigma = 2*fit$var)
  acc <- min(c(1, exp(logpost(pro, dd)-logpost(logwtheta[k-1, ],dd))))
  
  if (runif(1)<acc){
    logwtheta[k, ] <- pro
  } else{
    logwtheta[k, ] <- logwtheta[k-1, ]
  }  
  print(paste(k, '五'))
}



save( logwtheta, file = '10000-5次.RData')
# load('10000-5次.RData')
logwthetastar <- apply(logwtheta[1001:10000, ], 2, mean)

fun12 <- function(logwtheta){
  acc <- min(c(1, exp(logpost(logwthetastar, dd)-logpost(logwtheta,dd))))
  r <- acc*dmvnorm(logwthetastar, mean =logwtheta, sigma = 2*fit$var )
  return(r)
}
fenzi <- mean(apply(logwtheta[1001:10000, ], 1, fun12))
r <- rmvnorm(9000, logwthetastar, 2*fit$var)
fun13 <- function(logwtheta){
  acc <- min(c(1, exp(logpost(logwtheta, dd)-logpost(logwthetastar,dd))))
  
}
fenmu <- mean(apply(r, 1, fun13))
midu5 <- fenzi/fenmu


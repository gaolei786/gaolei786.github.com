
set.seed(12)
library(ChainLadder)
library(geoR)
library(LearnBayes)
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




sigma2 <- rep(0, 10000)
logwtheta <- matrix(0, nrow = 10000, ncol = 2)





sigma2[1] <- 2
logwtheta[1, ] <- c(0.1, 0.1)
I <- 10
fun1 <- function(j, w, theta){
  return(1-exp(-((j-0.5)/theta)^w))
}
fun5 <- function(sigma2ult, logult, logulti, logwtheta){
  w <- exp(logwtheta[1])
  theta <- exp(logwtheta[2])
  ziyoudu <- v1 + I*(I+1)
  ss <- 0
  for(i in 1:I){
    for (j in 1:(I+1-i)){
      ss <- ss+(log(data[i, j]) - 
                  logulti[i] - log(fun1(j, w, theta)))^2
    }
  }
  scale2 <- (v1 * sigma12 + ss)/(v1+I*(I+1))
  scale <- scale2
  r <- rinvchisq(1, df=ziyoudu, scale=scale)
  return(r)
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
fun6 <- function(sigma2, sigma2ult, logult, logulti, logwtheta){
  dd <- list(sigma2, sigma2ult, logult, logulti)
  fit <- laplace(logpost, c(0, 0),dd )
  proposal <- list(var = fit$var, scale = 2)
  print(proposal)
  r <- rwmetrop(logpost, proposal, start = fit$mode, m = 10, dd)
  print(r[[1]][10, ])
  return(r[[1]][10, ])
}

for(k in 2:10000){
  sigma2[k] <- fun5(sigma2ultstar, logultstar, logultistar, logwtheta[k-1, ])
  logwtheta[k, ] <- fun6(sigma2[k], sigma2ultstar, logultstar, logultistar, logwtheta[k-1, ])
  print(paste(k, '四'))
}

# 
save( sigma2, logwtheta, file = '10000-4次.RData')
# load('10000-4次.RData')


sigma2star <- mean(sigma2[1001:10000])

fun11 <- function(mm,sigma2star, sigma2ult, logult, logulti, logwtheta){
  w <- exp(logwtheta[mm, 1])
  theta <- exp(logwtheta[mm, 2])
  ziyoudu <- v1 + I*(I+1)
  ss <- 0
  for(i in 1:I){
    for (j in 1:(I+1-i)){
      ss <- ss+(log(data[i, j]) - 
                  logulti[i] - log(fun1(j, w, theta)))^2
    }
  }
  scale2 <- (v1 * sigma12 + ss)/(v1+I*(I+1))
  scale <- scale2
  r <- dinvchisq(sigma2star, df=ziyoudu, scale=scale)
  return(r)
}
midu4 <- mean(sapply(1001:10000, fun11, sigma2star, sigma2ultstar, logultstar,
                    logultistar, logwtheta))


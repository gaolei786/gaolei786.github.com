set.seed(123)
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

logulti <- matrix(0, nrow = 10000, ncol = I+1)
logult <- rep(0, 10000)
sigma2ult <- rep(0, 10000)
sigma2 <- rep(0, 10000)
logwtheta <- matrix(0, nrow = 10000, ncol = 2)


logulti[1, ] <- rep(log(3901463), I+1)
logult[1] <- log(3901463)
sigma2ult[1] <- 4
sigma2[1] <- 2
logwtheta[1, ] <- c(0.1, 0.1)
I <- 10

fun1 <- function(j, w, theta){
  return((j-0.5)^w/((j-0.5)^w+theta^w))
}
fun2 <- function(i, logult, sigma2ult, sigma2, logwtheta){
  w <- exp(logwtheta[1])
  theta <- exp(logwtheta[2])
  junzhi <- (1/sigma2*(I+1-i) * mean(log(data[i, 1:(I+1-i)])-
                                       log(fun1(1:(I+1-i), w, theta)))+
               1/sigma2ult*logult)/(1/sigma2*(I+1-i)+1/sigma2ult)
  fangcha <- 1/(1/sigma2*(I+1-i)+1/sigma2ult)
  r <- rnorm(1, junzhi, fangcha^0.5)
  return(r)
}
fun3 <- function(logulti, sigma2ult, sigma2, logwtheta){
  w <- exp(logwtheta[1])
  theta <- exp(logwtheta[2])
  junzhi <- (k0 / sigma2ult * logu0 + I/sigma2ult * mean(logulti))/
    (k0 / sigma2ult+I/sigma2ult)
  fangcha <- 1/(k0 / sigma2ult+I/sigma2ult)
  r <- rnorm(1, junzhi, fangcha^0.5)
  return(r)
}
fun4 <- function(logult, logulti, sigma2, logwtheta){
  ziyoudu <- I+v0+1
  scale2 <- (sum((logulti - logult)^2)+k0*(logult - logu0)^2 + v0*sigma02)/
    (I+v0+1)
  
  scale <- scale2
  r <- rinvchisq(1, df=ziyoudu, scale=scale)
  return(r)
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
  
  logulti[k, ] <-   sapply(1:(I), fun2, 
                          logult[k-1], sigma2ult[k-1],
                          sigma2[k-1 ], logwtheta[k-1, ])
  
  logult[k] <- fun3(logulti[k, ], sigma2ult[k-1], sigma2[k-1], logwtheta[k-1, ])

  sigma2ult[k] <- fun4(logult[k], logulti[k, ], sigma2[k-1], logwtheta[k-1, ])

  sigma2[k] <- fun5(sigma2ult[k], logult[k], logulti[k, ], logwtheta[k-1, ])

  logwtheta[k, ] <- fun6(sigma2[k], sigma2ult[k], logult[k], logulti[k, ], logwtheta[k-1, ])
  print(logwtheta[k, ])
  print(paste(k, '一'))

}
save(logulti, logult, sigma2ult, sigma2, logwtheta, file = '10000次.RData')
# load('10000次.RData')




logultistar <- apply(logulti[1001:10000, ], 2, mean)


fun7 <- function(mm, logult, sigma2ult, sigma2, logwtheta){
  
  funnei <- function(i, logult, sigma2ult, sigma2, logwtheta){
    w <- exp(logwtheta[1])
    theta <- exp(logwtheta[2])
    junzhi <- (1/sigma2*(I+1-i) * mean(log(data[i, 1:(I+1-i)])-
                                         log(fun1(1:(I+1-i), w, theta)))+
                 1/sigma2ult*logult)/(1/sigma2*(I+1-i)+1/sigma2ult)
    fangcha <- 1/(1/sigma2*(I+1-i)+1/sigma2ult)
    r <- dnorm(logultistar[i], junzhi, fangcha^0.5)
    return(r)
  }
  
  r <- prod(sapply(1:I, funnei, logult[mm], sigma2ult[mm], sigma2[mm], logwtheta[mm, ]))
  return(r)
  
}

# sapply(1:I, fun7, logult, sigma2ult, sigma2, logwtheta)
# apply(sapply(1:I, fun7, logult, sigma2ult, sigma2, logwtheta), 1, prod)
ss <- sapply(1001:10000, fun7, logult, sigma2ult, sigma2, logwtheta)
midu1 <- mean(sapply(1001:10000, fun7, logult, sigma2ult, sigma2, logwtheta))



library(ChainLadder)
I <- 21
data <- read.table("data2121.csv", sep = ",")
data <- data[-1, ]
data <- data[,-1]
rownames(data) <- 0:I
colnames(data) <- 0:I
data <- cbind(expand.grid(0:I, 0:I), as.vector(as.matrix(data)))
data[, 3] <- ifelse(data[, 3] == 0, NA, data[, 3])
data <- data[!is.na(data[[3]]), ]
names(data) <- c("accyear", "devyear", "value")
data <- as.triangle(data, origin = "accyear", dev = "devyear", value = "value")
data <- incr2cum(data)
Mack.data <- MackChainLadder(data, est.sigma="Mack")
f <- Mack.data$f[1:I]
R0 <- summary(Mack.data)$Totals[4, 1]
sum(data[1:I, 2]) / sum(data[1:I, 1])


Mack.summary <- summary(Mack.data)
write.table(Mack.summary$ByOrigin[, c(1, 3, 4)], "clipboard", sep = "\t")


mle <- function() {
  
  y <- NULL
  X0 <- array(0, dim = c((I+1)*(I+2)/2, (2*(I+1))))
  for (i in 1:(I+1)) {
    for (j in 1:((I+2) - i)) {
      y <- c(y, X[i, j])
      X0[length(y), c(i, (I+1) + j)] <- c(1, 1)
    }
  }
  coef <- exp(coefficients(glm(y ~ X0 - 1, family = poisson(link = "log"))))
  u <- coef[1:(I+1)] * sum(X[1, ]) / coef[1]
  names(u) <- NULL
  r <- c((coef[(I+2):(2*(I+1))] * coef[1] / sum(X[1, ]))[1:I], 1 - sum(coef[(I+2):(2*I+1)] * coef[1] / sum(X[1, ])))
  names(r) <- NULL
  fit <- fitted(glm(y ~ X0 - 1, family = poisson(link = "log")))
  phi <- sum(((y - fit) / fit^0.5)^2)/((I+1)*(I+2)/2-(2*I+1))
  return(list(u = u, r = r, phi = phi))
}
X <- cum2incr(data)
result <- mle()
u <- mle()$u  
r <- mle()$r 
phi <- mle()$phi  


dev <- f[I:1]
dev <- cumprod(dev)
Mack.boot.result1 <- list() 
Mack.boot.result2 <- list() 
Mack.boot.result3 <- NULL  
data.fitted <- data
for (i in 1:I) {
  dev <- f[((I+1) - i):1]
  dev <- cumprod(dev)
  data.fitted[i, 1:((I+1)-i)] <- (data[i, (I+2)-i]/dev[1:((I+1)-i)])[((I+1)-i):1]
}
data.fitted.incr <- cum2incr(data.fitted)  
data.incr <- cum2incr(data)



N <- (I+1)*(I+2)/2
p <- (2*I+1)
phi <- rep(0, I+1)
for(j in 1:I) {
  phi[j] <- N / (N-p) * mean(((data.incr[1:((I+2)-j), j] - data.fitted.incr[1:(I+2-j), j])/
                                data.fitted.incr[1:(I+2-j), j]^0.5)^2)
}
phi[I+1] <- min(phi[(I-1):(I)])
phi^0.5
data.unscaled.resi1 <- data.incr
for(j in 1:(I+1)) {
  data.unscaled.resi1[1:(I+2-j), j] <- (data.incr[1:(I+2-j), j] - data.fitted.incr[1:(I+2-j), j]) /
    (phi[j] * data.fitted.incr[1:(I+2-j), j])^0.5  
} 
data.unscaled.resi <- as.vector(data.unscaled.resi1)
data.unscaled.resi <- data.unscaled.resi[!is.na(data.unscaled.resi)]




for (k in 1:2000) { 
  print(k)
  
  data.unscaled.resi2 <- data.unscaled.resi1
  for (i in 1:(I+1)) {
    for (j in 1:((I+2) - i)) {
      data.unscaled.resi2[i, j] <- sample(data.unscaled.resi, 1)
    }
  }
  data.boot <- data.fitted.incr
  for(j in 1:(I+1)) {
    data.boot[1:((I+2)-j), j] <- data.unscaled.resi2[1:((I+2)-j), j] * 
      (phi[j] * data.fitted.incr[1:((I+2)-j), j])^0.5 +data.fitted.incr[1:((I+2)-j), j]
  }
  for (i in 1:(I+1)) {
    for (j in 1:((I+2)-i)) {
      if(data.boot[i, j] < 0) {
        data.boot[i, j] <- data.fitted.incr[i, j]
      }
    }
  }
  Mack.boot <- MackChainLadder(incr2cum(data.boot), est.sigma="Mack")
  
  Mack.boot.result1[[k]] <- cum2incr(data)
  RR <- rep(0, (I+1))
  for (i in 2:(I+1)) {
    for (j in ((I+3)-i):(I+1)) {
      #print(c(i,j,cum2incr(Mack.boot$FullTriangle)[i, j]))
      sim.c <- phi[j] * rpois(1, lambda=round(cum2incr(Mack.boot$FullTriangle)[i, j]/phi[j])) 
      #sim.c <- rgamma(1, shape=cum2incr(Mack.boot$FullTriangle)[i, j]/phi[j],scale=phi[j]) #以伽马分布近似替代超散布泊松分布
      
      Mack.boot.result1[[k]][i, j] <- sim.c
      RR[i] <- RR[i] + sim.c
    }
  }
  
  
  Mack.boot.result2[[k]] <- summary(Mack.boot)$ByOrigin$IBNR
  Mack.boot.result3 <- rbind(Mack.boot.result3, RR)
}                      
Mack.boot.result2[[1]]
apply(Mack.boot.result3, 2, sd) / summary(Mack.data)$ByOrigin$IBNR
sd(apply(Mack.boot.result3, 1, sum)) / summary(Mack.data)$Totals[4,1]

save(Mack.boot.result1, Mack.boot.result2, Mack.boot.result3, file = "odpboot2121.RData" )


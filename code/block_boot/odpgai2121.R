
library(ChainLadder)
library(lawstat)


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
# data.unscaled.resi1 <- (data.incr - data.fitted.incr) / (phi * data.fitted.incr)^0.5  #标准化残�?
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

data.unscaled.resi4 <- data.unscaled.resi1

plot(0, type = 'n', xlim = c(-1,I+1), ylim=c(-1,I+1),
     ylab = "", axes = F,xlab = "")
for (i in 0:I) {
  for (j in 0:(I-i)){
    if(data.unscaled.resi1[i+1,j+1]>0){
      text(j,I-i,"+")
      data.unscaled.resi4[i+1,j+1] <- 1
    } else if(data.unscaled.resi1[i+1,j+1]<0) {
      text(j,I-i,"-", col = 2)
      data.unscaled.resi4[i+1,j+1] <- -1
    } else {
      text(j,I-i,"o",cex = 0.7)
      data.unscaled.resi4[i+1,j+1] <- 0
    }
  }
}
for(i in 0:I){
  text(-1,I-i,i,cex = 0.7)
}
for(j in 0:I){
  text(j,I+1.5,j,cex = 0.7)
}


hy1 <- apply(data.unscaled.resi1[1:(I-1),], 1, runs.test, 
             alternative =  "positive.correlated")                                                                
hy2 <- apply(data.unscaled.resi1[,1:(I-1)], 2, runs.test, 
             alternative =  "positive.correlated")
p1 <- sapply(1:(I-1), function(i) {return(hy1[[i]]$p.value)})
p2 <- sapply(1:(I-1), function(i) {return(hy2[[i]]$p.value)})
p <- c(p1, p2)


plot(0, type = 'n', xlim = c(-1.5,I+1), ylim=c(-1,I+2.5),
     ylab = "", axes = F,xlab = "")
for (i in 0:I) {
  for (j in 0:(I-i)){
    if(data.unscaled.resi1[i+1,j+1]>0){
      text(j,I-i,"+")
    } else if(data.unscaled.resi1[i+1,j+1]<0) {
      text(j,I-i,"-", col = 2)
    } else {
      text(j,I-i,"o",cex = 0.7)
    }
  }
}
options(digits=3)
for(i in 0:(I-2)){
  if(p[i+1]<0.05){
    text(-1,I-i,round(p[i+1],3),cex = 0.7, col=2)
  } else{
    text(-1,I-i,round(p[i+1],3),cex = 0.7)
  }
}
for(j in 0:(I-2)){
  if(p[I+j]<0.05){
    text(j,I+2,round(p[I+j],3),cex = 0.7,srt=90, col=2)
  } else{
    text(j,I+2,round(p[I+j],3),cex = 0.7,srt=90)
  }
}

# BH算法 --------------------------------------------------------------------
# "bonferroni"
# "holm"
# "hochberg"
# "hommel"
# "BH"
# "BY"

p.adjust(p, method = "bonferroni", n = length(p))
p.adjust(p, method = "holm", n = length(p))
p.adjust(p, method = "hochberg", n = length(p))
p.adjust(p, method = "hommel", n = length(p))
p.adjust(p, method = "BH", n = length(p))
p.adjust(p, method = "BY", n = length(p))


pvalue<-p
q <- 0.2
sorted.pvalue<-sort(pvalue) 
j.alpha<-(1:length(p))*(q/length(p)) 
dif<-sorted.pvalue-j.alpha 
neg.dif<-dif[dif<0] 
pos.dif<-neg.dif[length(neg.dif)] 
index<-dif==pos.dif 
p.cutoff<-sorted.pvalue[index] 

p.cutoff 
p.sig<-pvalue[pvalue<=p.cutoff] 
which(pvalue <= p.cutoff)
p.sig 


inde <- which(pvalue <= p.cutoff)
plot(0, type = 'n', xlim = c(-1,I+1), ylim=c(-1,I+1),
     ylab = "", axes = F,xlab = "")
for (i in 0:I) {
  for (j in 0:(I-i)){
    if(data.unscaled.resi1[i+1,j+1]>0){
      text(j,I-i,"+")
    } else if(data.unscaled.resi1[i+1,j+1]<0) {
      text(j,I-i,"-", col = 2)
    } else {
      text(j,I-i,"o",cex = 0.7)
    }
  }
}
for(i in 0:I){
  text(-1,I-i,i,cex = 0.7)
}
for(j in 0:I){
  text(j,I+1.5,j,cex = 0.7)
}
for (aa in inde) {
  if(aa <= I-1 ) {
    #     abline(h=I-aa+1)
    y <- I-aa+1
    x <- y
    polygon(c(-0.5,x+0.5,x+0.5,-0.5),c(y-0.5,y-0.5,y+0.5,y+0.5))
  } else{
    #     abline(v=(aa-1)%/%(I))
    x <- (aa)%%(I)
    y <- x
    polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y-0.5, y-0.5, I+0.5,I+0.5))
  }
}


inde1 <- c(4, 11, 14, 22, 29)
for (aa in inde1) {
  if(aa <= I-1 ) {
    #     abline(h=I-aa+1)
    y <- I-aa+1
    x <- y
    polygon(c(-0.5,x+0.5,x+0.5,-0.5),c(y-0.5,y-0.5,y+0.5,y+0.5), border = rgb(0,0,0,0.25))
  } else{
    #     abline(v=(aa-1)%/%(I))
    x <- (aa)%%(I)
    y <- x
    polygon(c(x-0.3,x+0.3,x+0.3,x-0.3), c(y-0.3, y-0.3, I+0.3,I+0.3), border = rgb(0,0,0,0.25))
  }
}





inde <- which(pvalue <= p.cutoff)
plot(0, type = 'n', xlim = c(-1,I+1), ylim=c(-1,I+1),
     ylab = "", axes = F,xlab = "")
for (i in 0:I) {
  for (j in 0:(I-i)){
    if(data.unscaled.resi1[i+1,j+1]>0){
      text(j,I-i,"+")
    } else if(data.unscaled.resi1[i+1,j+1]<0) {
      text(j,I-i,"-", col = 2)
    } else {
      text(j,I-i,"o",cex = 0.7)
    }
  }
}
for(i in 0:I){
  text(-1,I-i,i,cex = 0.7)
}
for(j in 0:I){
  text(j,I+1.5,j,cex = 0.7)
}
x <- 0
y <- 15
polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y-0.5, y-0.5, I+0.5,I+0.5), lty=3)
y1 <- 6
y2 <- 12
polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y1-0.5, y1-0.5, y2+0.35,y2+0.35), lty=3)

x <- 2
y1 <- 11
y2 <- 15
polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y1-0.35, y1-0.35, y2+0.5,y2+0.5), lty=3)
y1 <- 4
y2 <- 10
polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y1-0.5, y1-0.5, y2+0.35,y2+0.35), lty=3)

x <- 5
y1 <- 18
y2 <- 21
polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y1-0.35, y1-0.35, y2+0.5,y2+0.5), lty=3)
y1 <- 12
y2 <- 17
polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y1-0.5, y1-0.5, y2+0.35,y2+0.35), lty=3)
y1 <- 5
y2 <- 8
polygon(c(x-0.5,x+0.5,x+0.5,x-0.5), c(y1-0.5, y1-0.5, y2+0.35,y2+0.35), lty = 3)


hang <- NULL
lie <- NULL
for (aa in inde){
  if(aa <= I-1){
    hang <- c(hang, aa-1)
  } else {
    lie <- c(lie, aa%%I)
  } 
}



for (k in 1:2000) {
  print(k)
  
  data.unscaled.resi2 <- data.unscaled.resi1
  for (i in 0:I) {
    for (j in 0:(I - i)) {
      if (i %in% hang){
        if(data.unscaled.resi1[i+1,j+1]>0){
          inde.lie <- which(data.unscaled.resi1[i+1,]>0)
          data.unscaled.resi2[i+1, j+1] <- sample(data.unscaled.resi1[i+1,inde.lie], 1)
        }else{
          inde.lie <- which(data.unscaled.resi1[i+1,]<=0)
          data.unscaled.resi2[i+1, j+1] <- sample(data.unscaled.resi1[i+1,inde.lie], 1)         
        }
      } else if (j %in% lie) {
        if(data.unscaled.resi1[i+1,j+1]>0){
          inde.hang <- which(data.unscaled.resi1[,j+1]>0)
          data.unscaled.resi2[i+1, j+1] <- sample(data.unscaled.resi1[inde.hang,j+1], 1)
        }else{
          inde.hang <- which(data.unscaled.resi1[,j+1]<=0)
          data.unscaled.resi2[i+1, j+1] <- sample(data.unscaled.resi1[inde.hang,j+1], 1)
        }
        
      } else {
        data.unscaled.resi2[i+1, j+1] <- sample(data.unscaled.resi, 1) 
      }

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
save(Mack.boot.result1, Mack.boot.result2, Mack.boot.result3,
      file = "odpgai2121.RData" )





 




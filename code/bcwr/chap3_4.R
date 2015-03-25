#a
p <- rbeta(1000, 100, 100)
sum(p > 0.44 & p < 0.56)/1000

inde <- rbinom(1000, 1, 0.9)
p <- rbeta(1000, 500, 500) * inde + 
       rbeta(1000, 1, 1) * (1-inde)
sum(p > 0.44 & p < 0.56)/1000
hist(p)

#b
po.p1 <- rbeta(1000, 145, 155)
quantile(po.p1, c(0.05, 0.95))
library(LearnBayes)
probs <- c(0.9, 0.1)
beta.par1 <- c(500, 500)
beta.par2 <- c(1, 1)
betapar <- rbind(beta.par1, beta.par2)
data <- c(45, 55)
post <- binomial.beta.mix(probs, betapar, data)
post
inde <- rbinom(1000, 1, 0.97776)
p <- rbeta(1000, 545, 555) * inde + 
       rbeta(1000, 46, 56) * (1-inde)
quantile(p, c(0.05, 0.95))


#c
po.p1 <- rbeta(1000, 130, 170)
quantile(po.p1, c(0.05, 0.95))
library(LearnBayes)
probs <- c(0.9, 0.1)
beta.par1 <- c(500, 500)
beta.par2 <- c(1, 1)
betapar <- rbind(beta.par1, beta.par2)
data <- c(30, 70)
post <- binomial.beta.mix(probs, betapar, data)
post
inde <- rbinom(1000, 1, 0.97776)
p <- rbeta(1000, 530, 570) * inde + 
       rbeta(1000, 31, 71) * (1-inde)
quantile(p, c(0.05, 0.95))



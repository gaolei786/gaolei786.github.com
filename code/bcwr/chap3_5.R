#a
2*(1-pbinom(8, 20, 0.2))

#b
p0 <- 0.2
prob <- 0.5
ab <- c(1, 4)
data <- c(8, 12)
library(LearnBayes)
pbetat(p0, prob, ab, data)

pbetat(p0, prob, c(0.5, 2), data)
pbetat(p0, prob, ab, data)
pbetat(p0, prob, c(2, 8), data)
pbetat(p0, prob, c(8, 32), data)
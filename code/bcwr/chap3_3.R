B <- 200
y <- c(43, 24, 100, 35, 85)
yn <- max(y)
N <- yn:B
n <- length(y)
prob <- 1/N^n
prob <- prob/sum(prob)

m <- sum(N * prob)
v <- sum(N^2*prob) - (sum(N*prob))^2
s <- sqrt(v)

sum(prob[N > 150])
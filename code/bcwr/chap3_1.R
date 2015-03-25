theta <- seq(-2, 12, by = 0.1)
y <- c(0, 10, 9, 8, 11, 3, 3, 8, 8, 11)

pd <- sapply(theta, 
            function(theta, y) prod(1 / (1 + (y - theta)^2)), y)
plot(theta, pd)

pd <- pd/sum(pd)
m <- sum(theta*pd)
v <- sum(theta^2*pd) - sum(theta*pd)^2
sqrt(v)
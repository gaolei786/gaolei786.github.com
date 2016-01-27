




set.seed(123)
X <- matrix(runif(2*3000), ncol = 2)
plot(0, type = "n", axes = F, xlim = c(-0.15, 1.05), ylim = c(-0.15, 1.05),
     xlab = '', ylab = '', xaxs = "i")
theta <- seq(0, pi/2, length = 500)
x1 <- c(cos(theta), 0)
y1 <- c(sin(theta), 0)
polygon(x1, y1, col = rgb(0, 0, 0, 0.15), border = rgb(0, 0, 0, 0.55) )

inde <- which(X[, 1]^2 + X[, 2]^2 <= 1)
length(inde)/3000 * 4
points(X, cex = 0.3, pch = 15, col = rgb(0, 0, 0, 0.65))
segments(seq(0, 1, length = 5), rep(0, 5), seq(0, 1, length = 5), 
         rep(-0.02, 5))
text(seq(0, 1, length = 5), rep(-0.05, 5), seq(0, 1, length = 5), cex = 0.7)
segments(rep(-0.02, 5), seq(0, 1, length = 5),rep(0, 5) , seq(0, 1, length = 5))
text(rep(-0.05, 5),seq(0, 1, length = 5), seq(0, 1, length = 5), cex = 0.7)

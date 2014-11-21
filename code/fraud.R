x <- seq(-3, 3, length = 300)
y <- dnorm(x)
plot(x, dnorm(x), type = 'l', axes = F, xlab = '', ylab = '')
abline(h = 0)

x <- seq(-1.5, 1.5, length = 100)
y <- dnorm(x)
polygon(c(-1.5, x, 1.5), c(0, y, 0), border = NA,  col = 8)

x <- seq(-3, -2, length = 100)
y <- dnorm(x)
polygon(c(-3, x, -2), c(0, y, 0), border = NA, col = 'green')

x <- seq(2, 3, length = 100)
y <- dnorm(x)
polygon(c(2, x, 3), c(0, y, 0), border = NA, col = 'green')
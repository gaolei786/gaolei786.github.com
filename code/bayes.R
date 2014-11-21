set.seed(123)
x <- 1:10

y <- 3 + 2 * x + rnorm(10, 0, 1.5)
plot(x, y, xlim = c(-2, 15), ylim = c(0, 30))
data <- data.frame(y = y, x = x)
m <- lm(y ~ x + I(x^2) + I(x^3)  +I(x^4) +I(x^5) +I(x^6) +I(x^7) +I(x^8) +I(x^9) )
lines(seq(1, 10, length = 200), 
      predict(m, data.frame(x=seq(1, 10, length = 200))))

saveHTML({
  plot(x, y, main = "这是我们的数据", xlim = c(-2, 11), ylim = c(0, 30))
  plot(x, y, xlim = c(-2, 11), ylim = c(0, 30), main = "这是我们拟合的一阶回归模型")
  m1 <- lm(y ~ x )
  lines(seq(1, 10, length = 200), 
      predict(m1, data.frame(x=seq(1, 10, length = 200))))


  plot(x, y, xlim = c(-2, 11), ylim = c(0, 30), main = "这是我们拟合的9阶模型")
  m2 <- lm(y ~ x + I(x^2) + I(x^3)  +I(x^4) +I(x^5) +I(x^6) +I(x^7) +I(x^8) +I(x^9) )
  lines(seq(1, 10, length = 200), 
      predict(m2, data.frame(x=seq(1, 10, length = 200))))
  plot(x, y, xlim = c(-2, 11), ylim = c(0, 30), main = "高阶模型明显比一阶拟合效果要好")
  lines(seq(1, 10, length = 200), 
      predict(m1, data.frame(x=seq(1, 10, length = 200))))
  lines(seq(1, 10, length = 200), 
      predict(m2, data.frame(x=seq(1, 10, length = 200))),col = 2, lwd = 2)
  }, interval = 3)






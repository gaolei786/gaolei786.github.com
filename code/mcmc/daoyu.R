theta <- 1:9
p.theta <- c(1:7, 6, 4)
plot(theta, p.theta/sum(p.theta),lwd = 3, axes = F, type = "h", xlab = "", ylab = "")
axis(1, 1:9, 1:9)
axis(2)
box()
theta <- 1:9
p.theta <- c(1:7, 6, 4)
position <- 5
set.seed(1123)
for (i in 1:5000) {

    coin <- rbinom(1, 1, prob = c(0.5, 0.5))
    if (coin == 1) {
      if (position[i] == 1){
        p.move <- 0 / p.theta[position[i]]
      } else {
        p.move <- p.theta[position[i] - 1] / p.theta[position[i]]
      }
      
      p.move <- min(p.move, 1)
      spinner <- runif(1)
      if (spinner <= p.move) {
        position <- c(position, position[i] - 1)
      } else {
        position <- c(position, position[i])
      }
    } else {
      if (position[i] == 9){
        p.move <- 0 / p.theta[position[i]]
      } else {
        p.move <- p.theta[position[i] + 1] / p.theta[position[i]]
      }
      spinner <- runif(1)
      if (spinner <= p.move) {
        position <- c(position, position[i] + 1)
      } else {
        position <- c(position, position[i])
      } 
    }
  }

data <- data.frame(pos = position[1:5001], time = 1:5001)
library(ggplot2)

qplot(pos, time, data = data, geom = "path") + 
  scale_y_log10() + xlab(bquote(theta)) +
  ylab("Time") +
  theme(panel.background = element_blank())
box()

plot(data$pos, log(data$time), type = 'l', axes = F, 
     xlab = '', ylab = '')
box()
axis(2, log(c(10, 1000, 4000)), c(10, 1000, 4000))
axis(1, 1:9, 1:9)

position <- position[2000:5000]
hist(position, xlab = bquote(theta), ylab = "Frequency")
table(position)/2000
1:7 / sum(1:7)

barplot(table(position), xlab = "", ylab = "")


plot(theta, p.theta/sum(p.theta), xlab = bquote(theta),lwd = 3, ylab = bquote(p(theta)), type = "h")


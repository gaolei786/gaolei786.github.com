library(LearnBayes)
data(studentdata)
write.table(studentdata, file = "studentdata.txt", sep = "\t")

# ¶ÁÈ¡Êı¾İ
studentdata <- read.table("studentdata.txt", sep = "\t", 
                          header = TRUE)
data(studentdata)
head(studentdata)

#studentdata$Height
attach(studentdata)
table(Drink)
table(Drink, Gender)

barplot(table(Drink), xlab = "Drink", ylab = "Count")

hours.of.sleep <- WakeUp - ToSleep
summary(hours.of.sleep)
hist(hours.of.sleep, main = "")

boxplot(hours.of.sleep ~ Gender, 
        ylab = "Hours of Sleep")

female.Haircut <- Haircut[Gender == "female"]
male.Haircut <- Haircut[Gender == "male"]
summary(female.Haircut)
summary(male.Haircut)

m <- boxplot(Haircut ~ Gender)
m$stats
par(mfrow = c(1, 2))
plot(ToSleep, hours.of.sleep)
points(-0.5, 8, pch = 4, col = 2, cex = 2)
plot(jitter(ToSleep), jitter(hours.of.sleep))
fit <- lm(hours.of.sleep ~ ToSleep)
fit
abline(fit, lwd = 3 )

predict(fit, data.frame(ToSleep = c(-2)))
points(-2, predict(fit, data.frame(ToSleep = c(-2))), cex = 2,
       col = 2, pch = 16)


hist(Dvds)
summary(Dvds)
table(Dvds)
barplot(table(Dvds))

output <- boxplot(Height ~ Gender)


set.seed(123)
u0 <- 5
sigma0 <- 1
norm.conf.interval <- function(i)
{
  y <- rnorm(16, u0, sigma0)
  n <- length(y)
  z=qt(0.975, n - 1)
  u <- mean(y)
  s <- sd(y)
  ci <- c(u - s * z / n^0.5, u + s * z / n^0.5, (u-u0)/(s/n^0.5))
}
ci <- sapply(1:1000, norm.conf.interval)

plot(density(ci[3, ])

i <- 200
saveGIF({
    for (i in 1:200) {plot(c(i, i), ci[, i] ,xlim = c(0, 200), ylim = c(3.5,6.5), type = "n");
    col <- (1:2)[(ci[1, 1:i] > 5 | ci[2,1:i] < 5)+ 1] 
    lwd <- (1:3)[(ci[1, 1:i] > 5 | ci[2,1:i] < 5)+ 1] 
    segments(1:i, ci[1, 1:i], 1:i, ci[2,1:i] ,xlim = c(0, 200), ylim = c(3.5,6.5), col = col, lwd = lwd)    
    ;abline(h = 5, col = 3, lwd = 3)} }
, interval = 0.15)

saveHTML({
     ani.options(interval = 0.05)
    for (i in 1:200) {plot(c(i, i), ci[, i] ,xlim = c(0, 200), ylim = c(3.5,6.5), type = "n");
    col <- (1:2)[(ci[1, 1:i] > 5 | ci[2,1:i] < 5)+ 1] 
    lwd <- (1:3)[(ci[1, 1:i] > 5 | ci[2,1:i] < 5)+ 1] 
    segments(1:i, ci[1, 1:i], 1:i, ci[2,1:i] ,xlim = c(0, 200), ylim = c(3.5,6.5), col = col, lwd = lwd)    
    ;abline(h = 5, col = 3, lwd = 3)} },
img.name = "brownian_motion_b", htmlfile = "index1.html", single.opts = "'controls': ['first', 'previous', 'play', 'next', 'last', 'loop', 'speed'], 'delayMin': 0", 
    description = c("Random walk of 10 points on the 2D plane", "(without the navigation panel)")
)
sum((1:2)[(ci[1, 1:i] > 5 | ci[2,1:i] < 5)+ 1] -1)





m <- matrix(c(0.9, 0.075, 0.025, 
    0.15, 0.8, 0.05, 
    0.25, 0.25, 0.5), nrow = 3, byrow = T)

m1 <- rbind(c(1, 0, 0) )


for (i in 2:30) {
  m1 <-rbind(m1,  m1[i-1, ] %*% m)
}
#par(mfrow = c(1, 3))
plot(1:30, m1[, 1], type = "l", lty = 2, ylim = c(0, 1))
lines(1:30, m1[, 2], lty = 3)
lines(1:30, m1[, 3], lty = 4)
legend("topright", c("牛市", "熊市", "平衡市"), lty = c(2, 3, 4))

m2 <- rbind(c(0, 1, 0) )
for (i in 2:30) {
  m2 <-rbind(m2,  m2[i-1, ] %*% m)
}
plot(1:30, m2[, 1], type = "l", lty = 2, ylim = c(0, 1))
lines(1:30, m2[, 2], lty = 3)
lines(1:30, m2[, 3], lty = 4)
legend("topright", c("牛市", "熊市", "平衡市"), lty = c(2, 3, 4))

m3 <- rbind(c(0, 0, 1) )
for (i in 2:30) {
  m3 <-rbind(m3,  m3[i-1, ] %*% m)
}
plot(1:30, m3[, 1], type = "l", lty = 2, ylim = c(0, 1))
lines(1:30, m3[, 2], lty = 3)
lines(1:30, m3[, 3], lty = 4)
legend("topright", c("牛市", "熊市", "平衡市"), lty = c(2, 3, 4))
plot(1:30, m1[, 1], type = "l", lty = 4, ylim = c(0, 1), lwd = 3)
lines(1:30, m1[, 2], lty = 4, lwd = 3)
lines(1:30, m1[, 3], lty = 4, lwd = 3)
lines(1:30, m2[, 1], lty = 2, lwd = 3)
lines(1:30, m2[, 2], lty = 2, lwd = 3)
lines(1:30, m2[, 3], lty = 2, lwd = 3)




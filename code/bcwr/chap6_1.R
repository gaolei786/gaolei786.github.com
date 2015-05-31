
P = matrix(c(0.2, 0.8, 0, 0, 0,
             0.2, 0.2, 0.6, 0, 0,
             0.0, 0.4, 0.2, 0.4, 0, 
             0, 0, 0.6, 0.2, 0.2, 
             0, 0, 0, 0.8, 0.2), nrow = 5, 
            byrow = T)
s <- array(0, c(10000, 1))
s[1, 1] <- 1
j <- 2
for (j in 2:10000){
  s[j, ] <- sample(1:5, size = 1,
                   prob = P[s[j-1, ], ], 
                   replace = T)
}

table(s)/10000



w <- solve(cbind(rbind(t(P)-diag(5), 1), rep(, c(rep(0, 5), 1))
w %*% P
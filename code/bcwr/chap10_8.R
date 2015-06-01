set.seed(123)
bino <- function(n, y, m){
  p1 <- 0.2
  p2 <- 0.3
  p3 <- 0.4
  p4 <- 0.5
  P1 <- array(0, c(m, 1))
  P2 <- array(0, c(m, 1))
  P3 <- array(0, c(m, 1))
  P4 <- array(0, c(m, 1))
  for (i in 1:m){
    p1 <- rbeta(1, y[1]+1, n[1]-y[1]+1)
    while(p1 > p2){
      p1 <- rbeta(1, y[1]+1, n[1]-y[1]+1)
    }
    p2 <- rbeta(1, y[2]+1, n[2]-y[2]+1)
    while(p1 > p2 | p2 > p3){
      p2 <- rbeta(1, y[2]+1, n[2]-y[2]+1)
    }
    p3 <- rbeta(1, y[3]+1, n[3]-y[3]+1)
    while(p2 > p3 | p3 > p4){
      p3 <- rbeta(1, y[3]+1, n[3]-y[3]+1)
    }
    p4 <- rbeta(1, y[4]+1, n[4]-y[4]+1)
    while(p3 > p4 ){
      p4 <- rbeta(1, y[4]+1, n[4]-y[4]+1)
    }
    P1[i] <- p1
    P2[i] <- p2
    P3[i] <- p3
    P4[i] <- p4
    
    
    
  }
  par <- list(p1 = P1, p2 = P2, p3 = P3, p4 = P4)
  return(par)


}
n <- rep(20, 4)
y <- c(2, 5, 12, 9)
par <- bino(n, y, 1000)
lapply(par, mean)

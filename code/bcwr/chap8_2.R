library(LearnBayes)
#a
y.mean <- 41.4
mu <- 47.7
sigma <- 25
pnorm(50^0.5*(y.mean-mu)/sigma)

#b
h <- mnormt.twosided(47.7, 0.5, 4, c(41.4, 50, 25))
h$post

#c
h1 <- mnormt.twosided(47.7, 0.5, 1, c(41.4, 50, 25))
h1$post
h4 <- mnormt.twosided(47.7, 0.5, 4, c(41.4, 50, 25))
h4$post
h6 <- mnormt.twosided(47.7, 0.5, 6, c(41.4, 50, 25))
h6$post
h8 <- mnormt.twosided(47.7, 0.5, 8, c(41.4, 50, 25))
h8$post
h10 <- mnormt.twosided(47.7, 0.5, 10, c(41.4, 50, 25))
h10$post
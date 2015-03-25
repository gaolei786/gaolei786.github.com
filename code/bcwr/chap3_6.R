fun <- function(mu) {
  sigma <- 10
  pnorm(70, mu, sigma)^1 * 
    (1-pnorm(70, mu, sigma))^17
}

post <- fun(50:170)
post <- post/sum(post)
plot(50:170, post, type = 'l')


#b
x <- 50:170
sum(x*post)
#c
sum(post[x > 80])
LIKE = function(lambda) pexp(100,1/lambda)^3*dexp(100,1/lambda)*
  (pexp(300,1/lambda)-pexp(100,1/lambda))^3*
  dexp(300,1/lambda)*(1-pexp(300,1/lambda))^4

pd <- function(lambda) {
  LIKE(lambda) / lambda
}
#a
curve(pd, from = 50, to = 1000, add = F)
#b
lam <- 50:1000
pdlam <- pd(lam)
pdlam <- pdlam / sum(pdlam)
sum(pdlam * lam)
(sum(pdlam * lam^2) - sum(pdlam * lam)^2)^0.5
#c
sum(pdlam[lam > 300 & lam < 500])
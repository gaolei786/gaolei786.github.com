data(achievement)
achievement

hist(achievement$read1)
plot(achievement$Gen, achievement$read1)
plot(achievement$Age, achievement$read1)
plot(achievement$IQ, achievement$read1)

X <- achievement[, c(1, 2, 3)]
y <- achievement$read1
bayes.model.selection(y, X, c = 100, constant=F)
bayes.model.selection(y, X, c = 10, constant=F)
bayes.model.selection(y, X, c = 1, constant=F)




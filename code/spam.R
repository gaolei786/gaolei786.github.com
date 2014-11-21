data <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data",
                   header = F, sep = ",")

save(data, file = "spam.dat")

(vari <- read.table("vari.txt", header = F, sep = ""))

colnames(data) <- c(as.vector(vari[, 1]), "spam")

data$spam <- factor(data$spam)

data1 <- data[seq(1, 4601, by = 2), ]
data2 <- data[-seq(1, 4601, by = 2), ]

m <- NaiveBayes(spam ~ ., data = data1, usekernel = F)


plot(m)

r2.train.class <- predict(m,  newdata = data2[, 1:57])
warnings()
names(r2.train.class)
round(r2.train.class$posterior[, 2] - r2.train.class$posterior[, 1], 0)
tt <- table(predicted = r2.train.class$class, actual = data2[, 58])
sum(diag(tt))/sum(tt)

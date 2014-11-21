studentdata <- read.table("studentdata.txt", sep = "\t", 
                          header = TRUE)
head(studentdata)
install("LearnBayes")
library(LearnBayes)
data(studentdata)
names(studentdata)

studentdata$Haircut
attach(studentdata)
table(Gender, Drink)


par(mfrow = c(1,2))
hist(hours.of.sleep)
hist(hours.of.sleep)

plot(ToSleep, hours.of.sleep)
points(-0.5, 8, pch = 4, col = 2, cex = 2)
plot(jitter(ToSleep), jitter(hours.of.sleep))
		
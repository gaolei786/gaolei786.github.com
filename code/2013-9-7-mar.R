library(MASS)
data(wtloss)

#attach(wtloss)
plot(Days, Weight, type = "p")
Wt.lbs <- pretty(Weight*2.205)
axis(side = 4, at = Wt.lbs / 2.205, lab = Wt.lbs)
mtext("Wt.lbs", side = 4, line = 3)#line可调节标签与坐标轴距离

oldpar <- par(mfrow = c(3, 1))
plot(Days, Weight, type = "p")
plot(Days, Weight, type = "p")
plot(Days, Weight, type = "p")
par(oldpar)



windows()
oldpar <- par(mar = c(2, 4.1, 2, 4.1), mfrow = c(3, 1))
plot(Days, Weight, type = "p")
plot(Days, Weight, type = "p")
plot(Days, Weight, type = "p")
par(oldpar)

detach(wtloss)
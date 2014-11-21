require(graphics)

hc <- hclust(dist(USArrests), "ward")
plot(hc)
plot(hc, hang = -1)
USArrests1 <- USArrests
USArrests1["Wyoming", ] <- c(30, 450, 100, 55)
USArrests1["Wisconsin", ] <- c(30, 450, 108, 56)

hc <- hclust(dist(USArrests1), "ward")
plot(hc)
plot(hc, hang = -1)

library(DMwR)
o <- outliers.ranking(USArrests1, method = "sizeDiff", 
                       clus =list(dist = "euclidean",alg = "hclust",meth="ward"))
d <- o$prob.outliers[o$rank.outliers]
dd <- data.frame(states = names(d),prob.outliers = d,  rank.outliers = 1:50)
Table <- gvisTable(dd, options=list(width=400, height=270))
cat(Table$html$chart, file="table.html")

library(googleVis)
typeof(Exports)


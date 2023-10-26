library(HARr)
basedata <- read_har("basedata.har")
sets <- read_har("sets.har")
names(basedata)
names(sets)
sets$h1

R <- 1:length(sets$h1)
G <- 1:length(sets$h2)
J <- 1
I1 <- 1:length(sets$h2)
colSums(basedata$codf)

co2e_gr <- (colSums(basedata$codf)+colSums(basedata$coif))

vom_gr <- basedata$tvom

xy_gr <- co2e_gr[-nrow(co2e_gr), ]/vom_gr

xt_j<- sum(basedata$vst*xy_gr["trans", ])/apply(basedata$vtwr, 1, sum)

xy_is <- replicate( length(R), xy_gr, simplify="array")
xm_ir <- (apply(basedata$vxmd*xy_is, c(1, 3), sum)+apply(basedata$vtwr*xt_j, c(2, 4), sum))/
  apply(basedata$vims, c(1, 3), sum)

co2egr+xm_ir

vifm <- aperm(basedata$vifm, c(1, 3,2 ))
vifm <- vifm[,,-20]
replicate( length(G), xm_ir, simplify="array")

apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)

vdfm <- aperm(basedata$vdfm, c(1, 3,2 ))
vdfm <- vdfm[,,-20]
replicate( length(G), xy_gr, simplify="array")

apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum)

xy_gr <- (co2e_gr[-nrow(co2e_gr),]+apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)+
            apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum))/vom_gr

result <- NULL
for(i in 1:2000){
  xt_j<- sum(basedata$vst*xy_gr["trans", ])/apply(basedata$vtwr, 1, sum)
  
  xy_is <- replicate( length(R), xy_gr, simplify="array")
  xm_ir <- (apply(basedata$vxmd*xy_is, c(1, 3), sum)+apply(basedata$vtwr*xt_j, c(2, 4), sum))/apply(basedata$vims, c(1, 3), sum)
  
  
  vifm <- aperm(basedata$vifm, c(1, 3,2 ))
  vifm <- vifm[,,-20]
  replicate( length(G), xm_ir, simplify="array")
  
  apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)
  
  vdfm <- aperm(basedata$vdfm, c(1, 3,2 ))
  vdfm <- vdfm[,,-20]
  replicate( length(G), xy_gr, simplify="array")
  
  apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum)
  
  xy_gr <- (co2e_gr[-nrow(co2e_gr),]+apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)+
              apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum))/vom_gr
  
  result <- c(result, xy_gr["agr", "chn"])
}

xy_gr800<- xy_gr
xy_gr2000 <- xy_gr
xy_gr800[, "chn"]
xy_gr2000[, "chn"]
xy_gr[, "chn"]*10000
plot(result)
co2e_gr[, "chn"]

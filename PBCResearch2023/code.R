library(HARr)
basedata <- read_har("basedata.har")
sets <- read_har("sets.har")
names(basedata)
names(sets)
sets$h1

R <- 1:length(sets$h1)
G <- 1:length(sets$h2)
J <- 3
I1 <- 1:length(sets$h2)
colSums(basedata$codf)

co2e_gr <- (colSums(basedata$codf)+colSums(basedata$coif))

vom_gr <- basedata$tvom

xy_gr <- co2e_gr[-nrow(co2e_gr), ]/vom_gr
xy_grpre <- co2e_gr[-nrow(co2e_gr), ]/vom_gr

xt_j<- apply(basedata$vst*xy_gr[c("o_tp", "w_tp", "a_tp"), ], 1, sum)/apply(basedata$vtwr, 1, sum)

xy_is <- replicate( length(R), xy_gr, simplify="array")

xt_jrep <- replicate(length(G), xt_j, simplify="array" )
xt_jrep <- replicate(length(R), xt_jrep, simplify = "array")
xt_jrep <- replicate(length(R), xt_jrep, simplify = "array")
xm_ir <- (apply(basedata$vxmd*xy_is, c(1, 3), sum)+apply(basedata$vtwr*xt_jrep, c(2, 4), sum))/
  apply(basedata$vims, c(1, 3), sum)

co2egr+xm_ir

vifm <- aperm(basedata$vifm, c(1, 3,2 ))
vifm <- vifm[,,-dim(vifm)[3]]
replicate( length(G), xm_ir, simplify="array")

apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)

vdfm <- aperm(basedata$vdfm, c(1, 3,2 ))
vdfm <- vdfm[,,-dim(vdfm)[3]]
replicate( length(G), xy_gr, simplify="array")

apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum)

xy_gr <- (co2e_gr[-nrow(co2e_gr),]+apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)+
            apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum))/vom_gr

result <- NULL
for(i in 1:800){
  xt_j<- apply(basedata$vst*xy_gr[c("o_tp", "w_tp", "a_tp"), ], 1, sum)/apply(basedata$vtwr, 1, sum)
  xt_jrep <- replicate(length(G), xt_j, simplify="array" )
  xt_jrep <- replicate(length(R), xt_jrep, simplify = "array")
  xt_jrep <- replicate(length(R), xt_jrep, simplify = "array")
  
  xy_is <- replicate( length(R), xy_gr, simplify="array")
  xm_ir <- (apply(basedata$vxmd*xy_is, c(1, 3), sum)+apply(basedata$vtwr*xt_jrep, c(2, 4), sum))/apply(basedata$vims, c(1, 3), sum)
  
  
  vifm <- aperm(basedata$vifm, c(1, 3,2 ))
  vifm <- vifm[,,-dim(vifm)[3]]
  replicate( length(G), xm_ir, simplify="array")
  
  apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)
  
  vdfm <- aperm(basedata$vdfm, c(1, 3,2 ))
  vdfm <- vdfm[,,-dim(vdfm)[3]]
  replicate( length(G), xy_gr, simplify="array")
  
  apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum)
  
  xy_gr <- (co2e_gr[-nrow(co2e_gr),]+apply(vifm* replicate( length(G), xm_ir, simplify="array"), c(3, 2), sum)+
              apply(vdfm* replicate( length(G), xy_gr, simplify="array"), c(3, 2), sum))/vom_gr
  
  result <- c(result, xy_gr["i_steel", "china"])
}



xy_gr[, "china"]*10000
xy_grpre[, "china"]*10000


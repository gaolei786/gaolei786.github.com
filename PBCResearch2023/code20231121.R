library(HARr)
library(ggh4x)
library(ggplot2)
library(reshape2)
library(RColorBrewer)
my.cols <- c(brewer.pal(name="Paired", n = 12),
             brewer.pal(name="Set2", n = 8))
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

xt_j<- apply(basedata$vst*xy_gr[c("o_tp", "w_tp", "a_tp"), ], 1, sum)/
  apply(basedata$vtwr, 1, sum)

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




# 碳税测算 -------------------------------------------------------------------

# tanshui <- xy_gr*75*100/2
# guojia <- dimnames(tanshui)[[2]]
# fun <- function(x){
#   paste('Shock to("', dimnames(tanshui)[[1]], '", "', x, '") = ',tanshui[, x], ";", sep = "")
# }
# sapply(guojia, fun)
# cat(sapply(guojia, fun), sep = "\n")


# 碳关税测算 -------------------------------------------------------------------

basedata$viws[, "china", "eu_27"]
basedata$vims[, "china", "eu_27"]



library(reshape2)
result <- xy_gr * basedata$viws[, , "eu_27"] * 50/basedata$vims[, , "eu_27"]*100
write.table(t(result[c(12, 13, 10, 14), c("china", "india", "russ", "usa2","othr_europe", "japan", "other_h_asia")]), "clipboard", 
                sep = "\t")

suoyouhangye <- c("作物种植业","其他农业","煤炭开采和洗选业",
                  "石油开采业","天然气开采业","采矿业",
                  "食品制造业","轻工业", "石油加工业",
                  "化肥制造业","中间产品制造业","水泥制造业",
                  "钢铁制造业","铝冶炼及加工业","其他制造业",
                  "电力生产业","燃气生产和供应业","建筑业",
                  "道路运输业","水上运输业","航空运输业",
                  "其他服务业")


data <- data.frame(hangye = suoyouhangye[c(1:2, 7:8, 10:15, 18:22)],
                   tarriff = result[c(1:2, 7:8, 10:15, 18:22), "china"])



data$hangye <- factor(data$hangye, levels = data$hangye[order(data$tarriff)])
library(ggplot2)
my.cols <- c(rgb(170, 31, 45, maxColorValue = 255), 
             rgb(0, 93, 166, maxColorValue = 255), 
             rgb(243, 188, 72, maxColorValue = 255), 
             rgb(73, 118, 55, maxColorValue = 255))
ggplot(data)+
  geom_bar(aes(x=hangye, y = tarriff), stat="identity", width = 0.5,
           fill = my.cols[2])+
  coord_flip()+
  scale_y_continuous(limits=c(0, 10), breaks = seq(0, 6, by = 1), 
                     name = "碳关税等值税率")+
  scale_x_discrete(name="")+
  theme(panel.background = element_blank(), axis.ticks.y=element_blank(), 
        axis.ticks.x=element_blank(), 
        axis.text.y = element_text(size = 12, hjust = 1), 
        axis.text.x = element_text(size = 12), 
        axis.title.x = element_text(size = 14))+
  geom_text(aes(x=hangye, y = tarriff, label=paste(round(tarriff, 1), "%", sep = "")),hjust = -0.5)+
  geom_segment(x = 0, y = 0, xend = 15, yend = 0)


# 各个国家50作图 ----------------------------------------------------------------
library(reshape2)
result <- xy_gr * basedata$viws[, , "eu_27"] * 50/basedata$vims[, , "eu_27"]*100
write.table(t(result[c(12, 13, 10, 14), c("china", "india", "russ", "usa2","othr_europe", "japan", "other_h_asia")]), "clipboard", 
            sep = "\t")

suoyouhangye <- c("作物种植业","其他农业","煤炭开采和洗选业",
                  "石油开采业","天然气开采业","采矿业",
                  "食品制造业","轻工业", "石油加工业",
                  "化肥制造业","中间产品制造业","水泥制造业",
                  "钢铁制造业","铝冶炼及加工业","其他制造业",
                  "电力生产业","燃气生产和供应业","建筑业",
                  "道路运输业","水上运输业","航空运输业",
                  "其他服务业")
suoyouguojia <- c("美国", "加拿大", "欧盟", "其他欧洲国家", 
                  "日本", "亚洲高收入国家", 
                  "中国", "印度", "南非关税同盟", "墨西哥",
                  "巴西", "印度尼西亚", "俄罗斯", 
                  "其他非洲国家", "中东", "其他美洲国家",
                  "其他南亚国家", "其他东南亚国家", "中亚及西亚")


rownames(result) <- suoyouhangye
colnames(result) <- suoyouguojia

result <- melt(result)
zhibiao <- aggregate(result[,3], list(result$reg),max)
inde <- order(zhibiao$x[-c(1:6)])



result$reg <- factor(result$reg, levels = suoyouguojia[c(1:6,6+inde)] )

result$shape <- "1"
result$shape[result$prod_comm %in% suoyouhangye[1:10]] <- 0
my.cols1 <- c(brewer.pal(name="Paired", n = 12),
              brewer.pal(name="Set2", n = 8))
my.cols <- c(rgb(170, 31, 45, maxColorValue = 255), 
             rgb(0, 93, 166, maxColorValue = 255), 
             rgb(243, 188, 72, maxColorValue = 255), 
             rgb(73, 118, 55, maxColorValue = 255),
             rgb(131, 153, 202, maxColorValue = 255),
             rgb(205, 135, 121, maxColorValue = 255),
             rgb(153, 170, 133, maxColorValue = 255),
             my.cols1[6:20])
result <- result[result$reg != "欧盟", ]
ggplot(data=result,aes(x=reg, y = value, colour=prod_comm))+
  geom_point(aes(shape = prod_comm), size = 3)+
  scale_y_continuous(name = "各国各行业关税税率变化（%）")+
  theme(legend.position=c(0.7,0.8),
        legend.title = element_blank(),
        legend.text=element_text(size=10),
        legend.key.size = unit(0.7,"line"),
        legend.background = element_blank(),
        legend.box.background = element_blank(), 
        panel.border = element_blank(),
        axis.text.x = element_text(angle = 90,vjust = 0.85,hjust = 0.75,size = 10),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 10))+

  scale_shape_manual(name = "行业分类",labels = suoyouhangye, values = c(rep(19,10), rep(4,12)))+
  scale_color_manual(name = "行业分类", labels=suoyouhangye,
                    values = c(my.cols[1:10],my.cols[1:12]))+
  geom_vline(xintercept = 6.5, linetype = 2 )+
  annotate("text", x=4.5, y=40, label= "发达国家碳关税\n负担较轻")+
  annotate("text", x=8.5, y=40, label= "发展中国家碳关税\n负担相对较重")



# 全部行业冲击 ------------------------------------------------------------------

result <- xy_gr * basedata$viws[, , "eu_27"] * 30/basedata$vims[, , "eu_27"]*100
result <- melt(result)
inde0 <- !(result$reg %in%c("eu_27"))
inde1 <- !(result$prod_comm %in% c("coal","oil","gas", "oil_pcts" ))
cat(paste('Shock tms("', result[inde1&inde0, 1], '","', result[inde1&inde0, 2], '","eu_27")=',
          result[inde1&inde0, 3] ,";",sep = ""),
    sep = "\n")

result <- xy_gr * basedata$viws[, , "eu_27"] * 50/basedata$vims[, , "eu_27"]*100 
result <- melt(result)
plot(result[, 3])
cat(paste('Shock tms("', result[inde1&inde0, 1], '","', result[inde1&inde0, 2], '","eu_27")=',
          result[inde1&inde0, 3] ,";",sep = ""),
    sep = "\n")

result <- xy_gr * basedata$viws[, , "eu_27"] * 100/basedata$vims[, , "eu_27"]*100 
result <- melt(result)
plot(result[, 3])
cat(paste('Shock tms("', result[inde1&inde0, 1], '","', result[inde1&inde0, 2], '","eu_27")=',
          result[inde1&inde0, 3] ,";",sep = ""),
    sep = "\n")



# 部分行业碳关税冲击 ---------------------------------------------------------------

result <- xy_gr * basedata$viws[, , "eu_27"] * 30/basedata$vims[, , "eu_27"]*100
result <- melt(result)
inde <- result$prod_comm%in%c("i_steel", "cement", "chem_fert", "aluminum", "electricity")
cat(paste('Shock tms("', result[inde&inde0, 1], '","', result[inde&inde0, 2], '","eu_27")=',
          result[inde&inde0, 3] ,";",sep = ""),
    sep = "\n")

result <- xy_gr * basedata$viws[, , "eu_27"] * 50/basedata$vims[, , "eu_27"]*100
result <- melt(result)
inde <- result$prod_comm%in%c("i_steel", "cement", "chem_fert", "aluminum", "electricity")
cat(paste('Shock tms("', result[inde&inde0, 1], '","', result[inde&inde0, 2], '","eu_27")=',
          result[inde&inde0, 3] ,";",sep = ""),
    sep = "\n")

result <- xy_gr * basedata$viws[, , "eu_27"] * 100/basedata$vims[, , "eu_27"]*100
result <- melt(result)
inde <- result$prod_comm%in%c("i_steel", "cement", "chem_fert", "aluminum", "electricity")
cat(paste('Shock tms("', result[inde&inde0, 1], '","', result[inde&inde0, 2], '","eu_27")=',
          result[inde&inde0, 3] ,";",sep = ""),
    sep = "\n")




# 部分行业直接碳关税冲击 -------------------------------------------------------------


result <- xy_grpre* basedata$viws[, , "eu_27"] * 30/basedata$vims[, , "eu_27"]*100
result <- melt(result)
inde <- result$prod_comm%in%c("i_steel", "cement", "chem_fert", "aluminum", "electricity")
cat(paste('Shock tms("', result[inde&inde0, 1], '","', result[inde&inde0, 2], '","eu_27")=',
          result[inde&inde0, 3] ,";",sep = ""),
    sep = "\n")

result <- xy_grpre* basedata$viws[, , "eu_27"] * 50/basedata$vims[, , "eu_27"]*100
result <- melt(result)
inde <- result$prod_comm%in%c("i_steel", "cement", "chem_fert", "aluminum", "electricity")
cat(paste('Shock tms("', result[inde&inde0, 1], '","', result[inde&inde0, 2], '","eu_27")=',
          result[inde&inde0, 3] ,";",sep = ""),
    sep = "\n")

result <- xy_grpre * basedata$viws[, , "eu_27"] * 100/basedata$vims[, , "eu_27"]*100
result <- melt(result)
inde <- result$prod_comm%in%c("i_steel", "cement", "chem_fert", "aluminum", "electricity")
cat(paste('Shock tms("', result[inde&inde0, 1], '","', result[inde&inde0, 2], '","eu_27")=',
          result[inde&inde0, 3] ,";",sep = ""),
    sep = "\n")






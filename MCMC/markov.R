set.seed(123)
zhuangtai <- 'A'
for (i in 1:6000){
  if(zhuangtai[i] == 'A') {
    zhuangtai <- c(zhuangtai, 
                     sample(c('A', 'B'), 1, replace = T, c(0.7, 0.3)))
  } else if(zhuangtai[i] == 'B') {
    zhuangtai <- c(zhuangtai, 
                     sample(c('A', 'B'), 1, replace = T, c(0.4, 0.6)))
  }

}

par(mfrow=c(2, 2))
par(mar=c(2, 2, 2, 2) )
barplot(table(zhuangtai[1:1500]), main="序列1-1500")
barplot(table(zhuangtai[1501:3000]), main="序列1501-3000")

barplot(table(zhuangtai[3001:4500]), main="序列3001-4500")

barplot(table(zhuangtai[4501:6000]), main="序列4501-6000")

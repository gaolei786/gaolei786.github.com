---
layout: post
title: "R笔记"
description: ""
tags: [R]

categories:
- R

show_img: "/images/ro.png"
---

1.小例子([代码](https://gaolei786.github.com/code/ro2.R))：

![](https://gaolei786.github.com/images/ro.png)

2.R加载包时，常常会有提示加载成功的信息，如何才能不显示这些信息呢？使用quietly参数即可：

<pre><code>
> require("DMwR", quietly = F)
载入需要的程辑包：DMwR
载入需要的程辑包：lattice
载入需要的程辑包：grid
警告信息：
1: 程辑包‘DMwR’是用R版本2.15.3 来建造的 
2: 程辑包‘lattice’是用R版本2.15.2 来建造的 
> require("DMwR", quietly = T)
> 
</code></pre>

2.eqscplot()作出的图形两条坐标轴尺度相等，一厘米的长度代表同样的数量间隔。

3.“均值”容易受极端值的影响，一种稳健的位置估计量是shorth。即取出样本含有二分之一样本量的最短区间，计算在该区间内的样本的均值作为位置估计。R中的函数是shorth()(位于genefilter包中）。

4.IQR=Interquantile range;Mad = median absolute deviation.

5.图形中插入公式。

<pre><code>
plot(0, type = 'n', axes = F, xlab = '', ylab = '', 
     xlim = c(0, 7), ylim = c(0, 0.5))
segments(x0 = c(0, 0, 0, 7), y0 = c(0, 0, 0.5, 0), 
         x1 = c(7, 0, 7, 7), y1 = c(0, 0.5, 0.5, 0.5))
x <- seq(0, 7, length = 500)
y <- dnorm(x, 2.5, 1)
y[1:100] <- y[1:100] - rev((1:100)*y[1] / 100) #压短正态分布的密度曲线，使其从0开始
lines(x, y)
segments(x0= 2.5, y0 = 0, x1 = 2.5, dnorm(2.5, 2.5, 1))
segments(3.5, 0, 3.5, dnorm(3.5, 2.5, 1), lty = 2)
x1 <- seq(4.5, 7, length = 200)
y1 <- c(0, dnorm(x1, 2.5, 1))
x1 <- c(4.5, x1)
arrows(2.5, dnorm(2.5, 2.5, 1)/5, 3.5, dnorm(2.5, 2.5, 1)/5, 
       code = 3, length = 0.1)
arrows(2.5, dnorm(2.5, 2.5, 1)/13, 4.5, dnorm(2.5, 2.5, 1)/13,
       code = 3, length = 0.1)
polygon(x1, y1, angle = 45, density = 20)
text(3, dnorm(2.5, 2.5, 1)/5, label = expression(sigma), pos = 3)
text(3.5, dnorm(2.5, 2.5, 1)/15, label = expression(plain(VaR)[alpha](R[i]-hat(R[i]))),
     pos = 3, cex = 0.8)
text(2.5, dnorm(2.5, 2.5, 1)/2, label = expression(hat(R)[i]), pos = 2)
text(2, dnorm(2, 2.5, 1), label = expression(R[i]), pos = 2)

</code></pre>

![](http://gaolei786.github.com/images/1.png)











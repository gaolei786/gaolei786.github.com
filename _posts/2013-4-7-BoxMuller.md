---
layout: post
title: Monte-Carlo模拟之Box-Muller 方法
author: <a href="http://gaolei786.github.com/">GaoLei</a>
categories:
- Statistics

show_img: "/images/boxmuller2.png"
---

随机模拟是一种重要的统计研究方法。随机数的产生在随机模拟中占有重要位置。如何产生随机数，方法众多。最为常用的就是反函数法：

我们记随机变量$X$的分布函数为$F(x)$,那么随机变量$X$的函数

$$Y=F(X)$$

此时，$Y$为一随机变量，该随机变量满足（0,1）的均匀分布。

因此，为了模拟X,可以先从（0， 1）均匀分布中产生$Y$,然后,根据

$$X=F^{-1}(Y)$$

产生$X$.

使用该方法的局限性在于，有时分布函数的解析式不易获得，或者就算分布函数解析式可以写出，其反函数未必容易写出，从而，使用该方法产生随机数将难以实现。

例如，正态分布的密度函数为：

$$f(x) = \frac{1}{\sqrt{2\pi}}e^{\frac{(x-u)^2}{2\pi}} $$

我们不易获得其分布函数$F(x)$的解析形式，更不用说分布函数的反函数。

Box-mullar方法解决了生成正态分布随机数的难题。

基本思想是，为了生成$X \sim N(\mu, \sigma)$,如果有

$$Y = h^{-1}(X)$$

$$X=h(Y)$$


如果Y的分布函数解析式及其反函数解析式易于得到，那么Y易于模拟，我们相应的就可模拟X.问题的关键在于设计$h()$。


我们直接给出h

$$ X=R \times sin(\theta) $$

$$ Y= R \times cos(\theta) $$ 

$h^{-1}()$:

$$ \theta = arctan(\frac{y}{x}) $$
$$ R = \sqrt{(x^2 + y^2)} $$

在$x,y$满足正态分布假设下，可以证明$\theta$满足均匀分布，$\theta$ 分布函数为

$$ F(\theta) = \frac{\theta}{2\pi}$$

$R$分布函数为

$$ F(R)= 1- e^{-\frac{R^2}{2}} $$

---

证明：
（1）$$F(\theta_{0})=\int \int _{S} f(x,y) dxdy $$

  $$ = \int \int _{S} \frac{1}{2 \pi}e^{\frac{x^2+y^2}{2}}dxdy $$

积分区域S：

![LearnR](https://github.com/gaolei786/gaolei786.github.com/raw/master/images/boxmuller.png)

采用极坐标转换：

  $$ F(\theta_{0}）= \int_{0}^{\theta_0} d\theta \int \frac{1}{2 \pi} e^{-\frac{r^2}{2}}rdr $$

  $$ = \frac{\theta_0}{2\pi} $$

（2）$$F(R_0) =\int \int _{S} f(x,y) dxdy $$

  $$ = \int \int _{S} \frac{1}{2 \pi}e^{\frac{x^2+y^2}{2}}dxdy $$


积分区域S：

![LearnR](https://github.com/gaolei786/gaolei786.github.com/raw/master/images/boxmuller2.png)

采用极坐标转换：

 $$F(R_0) =\int_{0}^{2\pi}\int_{0}^{R_0} \frac{1}{2\pi} e^{-\frac{r^2}{2}}rdr$$

 $$ = 1- e^{-\frac{R_{0}^2}{2}} $$

证毕。

---
$$\theta, R$$均易于模拟。设$$u_1,u_2$$为均匀分布随机变量，则

$$\theta = 2\pi  u_1$$
$$R = \sqrt{-2log(1-u_2)}$$

继而，

$$ X = Rsin(\theta) = \sqrt{-2log(1-u_2)}sin(2\pi  u_1)$$
$$ Y = Rcos(\theta) = \sqrt{-2log(1-u_2)}cos(2\pi  u_1)$$

$X,Y$均为正态分布随机变量。

---

参考文献：

1. [http://www.math.nyu.edu/faculty/goodman/teaching/MonteCarlo2005/notes/GaussianSampling.pdf](http://www.math.nyu.edu/faculty/goodman/teaching/MonteCarlo2005/notes/GaussianSampling.pdf)
2. [http://www.lmpt.univ-tours.fr/~nicolis/Licence_NEW/08-09/boxmuller.pdf](http://www.lmpt.univ-tours.fr/~nicolis/Licence_NEW/08-09/boxmuller.pdf)
3. [http://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform](http://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform)

---











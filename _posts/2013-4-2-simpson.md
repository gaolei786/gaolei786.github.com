---
layout: post
title: 辛普森悖论的简单几何解释
author: <a href="http://gaolei786.github.com/">GaoLei</a>
categories:
- Statistics


show_img: "/images/simpson.png"
---

看了一篇博客，作者在其中把simpson paradox 的基本原理用几何向量表示的一清二楚，对于simpson paradox 的理解很有帮助。

simpson paradox 的形式化定义如下：
对于$$a_{11},a_{12},b_{11},b_{12},a'_{11},a'_{12},b'_{11},b'_{12}$$,均大于0，并且

$$ \frac{a_{11}}{a_{12}} > \frac{a'_{11}}{a'_{12}} $$

$$ \frac{b_{11}}{b_{12}} > \frac{b'_{11}}{b'_{12}} $$

按照一般看法，应有

$$ \frac{a_{11} + b_{11}}{a_{12} + b_{12}} > \frac{a'_{11} + b'_{11}}{a'_{12} + b'_{12}} $$

事实是，该结论并不严格成立。举一反例：

$$a_{11}=80,a_{12}=20,b_{11}=60,b_{12}=100$$ 

$$a'_{11}=100,a'_{12}=40,b'_{11}=10,b'_{12}=40$$

有：

$$ \frac{a_{11}}{a_{12}}=4 > \frac{a'_{11}}{a'_{12}}=2.5 $$

$$ \frac{b_{11}}{b_{12}}=0.6 > \frac{b'_{11}}{b'_{12}}=0.25 $$

然而：

 $$ \frac{a_{11} + b_{11}}{a_{12} + b_{12}} = 1.167 < \frac{a'_{11} + b'_{11}}{a'_{12} + b'_{12}} =1.375 $$

更直观的解释可以由下图说明：


![LearnR](https://github.com/gaolei786/gaolei786.github.com/raw/master/images/simpson.png)

$$ \frac{a_{11}}{a_{12}}=4 > \frac{a'_{11}}{a'_{12}}=2.5 $$ 对应于 $a$较$a'$斜率更大

$$ \frac{b_{11}}{b_{12}}=0.6 > \frac{b'_{11}}{b'_{12}}=0.25 $$ 对应于 $b$较$b'$斜率更大

然而结果却是，$c$的斜率小于$c'$的斜率。

---


[图形代码](https://gist.github.com/gaolei786/6043476)




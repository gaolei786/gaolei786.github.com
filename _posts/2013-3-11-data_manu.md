---
layout: post
title: R and data manuplication
author: <a href="http://gaolei786.github.com/">GaoLei</a>
categories:
- R

show_img: "/images/LearnR_2.png"
---


1.取子集

取子集，想法就是把条件转变为逻辑表达。取出满足这个逻辑表达式的记录。比如，我们要从paiters这个数据集中取出颜色超过17的记录，写法如下：

	> attach(painters)
	> painters[Colour >= 17, ]
	          Composition Drawing Colour Expression School
	Bassano             6       8     17          0      D
	Giorgione           8       9     18          4      D
	Pordenone           8      14     17          5      D
	Titian             12      15     18          6      D
	Rembrandt          15       6     17         12      G
	Rubens             18      13     17         17      G
	Van Dyck           15      10     17         13      G

有时条件众多，而且之间关系可能多种，我们可以用逻辑与、逻辑或来链接这些条件。下例是把Color不少于17并且作文不少于10的画者提取出来。

	> painters[Colour >= 17 & Composition >=10, ]
          Composition Drawing Colour Expression School
	Titian             12      15     18          6      D
	Rembrandt          15       6     17         12      G
	Rubens             18      13     17         17      G
	Van Dyck           15      10     17         13      G

另外，经常用到的一种特殊条件：选择在一定范围内的记录。比如选择那些在A,B学校的学生的记录，这种情况下，可以采用<code>%in%</code>运算符形式,也可以采用"is.element()"函数形式。

	> painters[is.element(School, c("A", "B")), ]
            	    Composition Drawing Colour Expression School
	Da Udine                 10       8     16          3      A
	Da Vinci                 15      16      4         14      A
	Del Piombo                8      13     16          7      A
	Del Sarto                12      16      9          8      A
	Fr. Penni                 0      15      8          0      A
	Guilio Romano            15      16      4         14      A
	Michelangelo              8      17      4          8      A
	Perino del Vaga          15      16      7          6      A
	Perugino                  4      12     10          4      A
	Raphael                  17      18     12         18      A
	F. Zucarro               10      13      8          8      B
	Fr. Salviata             13      15      8          8      B
	Parmigiano               10      15      6          6      B
	Primaticcio              15      14      7         10      B
	T. Zucarro               13      14     10          9      B
	Volterra                 12      15      5          8      B

---
2.数据转化。

数据转化发生在这样几个层次.



-  多个变量的转化。lapply,sapply
-  按row的转换, apply(, 1, );按列转换， apply(, 2, )
-  分组处理。split();aggregate();by().
-  归并。merge().
-  重构。reshape().
-  单个变量的转化.

所谓单个变量转化，是重新计算了一个变量，在计算时，可能用到了其他的变量信息。容易理解，只要运用"$"就行。举例：

	hill$ispeed <- hill$time / hill$dist  #用time和dist这两个变量的商作为一个新的变量ispeed的取值

多个变量的变化意为着对数据框的每个字段（这些字段往往都是数值型的）都进行计算，因为数据框毕竟也是一种列表，每个字段相当于列表的一个元素，因此也可以认为是对列表的每个元素进行处理。处理函数为lapply或sapply,处理的结果是什么？lapply()返回的是一个列表，列表的每个元素对应着原列表每个元素的计算结果。sapply()返回的是一个数据框，它适用于那些经过运算后，结果组织形式比较类似的情况，它会把这些结果组合为数据框，更为美观。举例：

	x <- list(a = 1:10, beta = exp(-3:3), logic = 
	  c(T, F, F, T))
	lapply(x, mean)  # 计算每个元素的均值，结果为一列表
	$a
	[1] 5.5

	$beta
	[1] 4.535125

	$logic
	[1] 0.5
    sapply(x, quantile, probs = 1:3/4) # 计算每个元素的分位数，结果为一数据框
	       a      beta logic
	25% 3.25 0.2516074   0.0
	50% 5.50 1.0000000   0.5
	75% 7.75 5.0536690   1.0

多个变量共同处理从矩阵方面看，就是在列上进行处理，使用到的函数为<code>apply(data, 2, fun)</code>.其实还可以在每一行上进行运算处理。可以说是按row的转换。方法是采用<code>apply(data, 1, )</code>.举例：

	x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
    dimnames(x)[[1]] <- letters[1:8]
	row.sums <- apply(x, 1, sum) #每一行相加运算
    row.sums
	a b c d e f g h 
	7 6 5 4 5 6 7 8 
	apply(x, 2, sum) #每一列求和
	x1 x2 
	24 24 




---
3.交叉表运算。

包括形成交叉表（xtabs())以及在交叉表上的运算（tapply()).tapply的运算与分组处理实质相同，只是展现结果方式不同。分组处理结果仍然是数据框，而tapply()的结果是一个交叉表。



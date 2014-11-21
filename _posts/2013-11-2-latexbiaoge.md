---
layout: post
title:  Latex表格
description: ""

tags: [ramblings, startups]
categories:
- latex

show_img: "/images/latexbiaoge.png"
---

认识Latex也快两年了，不过平常用的少，还是很生疏，用起来挺费劲的。晚上做了个表格，上网查的该怎么设置格式，这里记下，以备不时之需。

<pre><code>
\begin{table}[h]  %table 里面也可以嵌套tabular,只有tabular是不能加标题的
\centering  %表格居中
\caption{模拟实验}  %表格标题
 \begin{tabular}{rrrr}  %右对齐
     \hline
     \hline
       & $\mu_{i}$ & $MSE_{i}^{(MLE)}$ & $MSE_{i}^{(JS)}$ \\ [0.5ex]  %增加行宽
       \hline
       1 & -0.81 & 0.95 &  0.61 \\
       2 & -0.39 & 1.04 & 0.62 \\
       3 & -0.39 & 1.03 & 0.62 \\
       4 & -0.08 & 0.99 & 0.58 \\
       5 & 0.69 & 1.06 & 0.67 \\
       6 & 0.71 & 0.98 & 0.63 \\
       7 & 1.28 & 0.95 & 0.71 \\
       8 & 1.32 & 1.04 & 0.77 \\
       9 & 1.89 & 1.00 & 0.88 \\
       10 & 4.00 & 1.08 & 2.04!! \\
       \hline
       \multicolumn{2}{c}{Total Sqerr} & 10.12 & 8.13 \\  %横向合并两个单元格
       \hline
       \hline
   \end{tabular}
\end{table}
</code></pre>

效果如下：

![](http://gaolei786.github.com/images/latexbiaoge.png)

参考：[latex中简单表格制作+标题+编号+固定位置](http://blog.sciencenet.cn/blog-111494-428530.html)


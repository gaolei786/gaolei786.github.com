---
layout: post
title:  Latex书信
description: ""

tags: [ramblings, startups]
categories:
- latex

show_img: "/images/shuxin.png"
---

latex写书信也有相应的文档格式，但感觉，不适合中国人书信书写习惯。我用蛮力的方法，用latex写了一封信。克服的困难包括：首行如何避免缩进、如何添加代码块以及如何添加空格。一以下是编写的tex文件：

<pre><code>
% 使用 UTF-8 编码
\documentclass{article}
\usepackage{ctex}
\usepackage{multicol}
\usepackage{lscape}
\usepackage{listings}
\begin{document}
\noindent{崔老师：}

您好！我是天津财经大学统计系学生高磊。10月17号，您来我们学校做了”走向T型“的报告，我听后很有触动。联想到自己的研究领域，有以下问题向您请教。

若我们观测到了两个序列$x=\{x_1, x_2, \ldots, x_n\}$和$y=\{y_1, y_2, \ldots, y_n\}$,假定模型是这样的：
$$y_i=a\times x_i+\sqrt{x}*\epsilon_i, i=1, 2, \ldots, n$$

其中，$\epsilon_i \sim N(0,\sigma^2),i = 1, 2, \ldots, n$。看上去这属于一个异方差的线性回归问题，如果某些值，尤其是$y$出现异常的话，会不会也会使传统的估计变得糟糕？如下图，我按照$x=(1, 2, \ldots, 20)$、$y=1.2 \times x + \sqrt(x) \times rnorm(20, 0, 1)$, 生成了$(x, y)$, 做了一个回归，如下Figure1，：

\begin{figure}[h]
  \centering
  % Requires \usepackage{graphicx}
  \includegraphics[width=6cm]{./1.png}
  \caption{散点与回归直线}
\end{figure}



然后，将(x[20, y[20])（如图1中红点）调整为(x[20], y[20]+15), 接着对调整后的数据做回归，结果如Figure2。由图可见，系数发生了大的变化。



这时候能否使用您提到的T型估计来做呢？

我对稳健统计了解不多，如果能做的话，请您推荐几篇相关文献。

谢谢您的关注。\\

即颂

秋绥


\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 高磊
\\
\\

又及，程序代码（R编写）：
\begin{lstlisting}[language={[ANSI]C}, keywordstyle=\color{blue!70}, commentstyle=\color{red!50!green!50!blue!50}, frame=shadowbox, rulesepcolor=\color{red!20!green!20!blue!20}]
set.seed(123)
x <- 1:20
y <- 1.2 * x + x^0.5 * rnorm(20, 0, 1)
plot(x, y, xlim = c(-4, 25), ylim = c(-5, 40))
m1 <- lm(y ~ x-1)
abline(m1)
m1
points(x[20], y[20], pch = 14, col = 2)

y[20] <- y[20] + 15
plot(x, y, xlim = c(-4, 25), ylim = c(-5, 40), col = c(rep(1, 19), 2))
m2 <- lm(y ~ x-1)
abline(m2, col = 2)
abline(m1)
arrows(x[20], y[20]-15, x[20], y[20], length = 0.1)
m2
\end{lstlisting}
\begin{figure}
  \centering
  % Requires \usepackage{graphicx}
  \includegraphics[width=6cm]{./2.png}
   \caption{散点与回归直线（数据受污染）}
\end{figure}
\end{document}
</code></pre>

代码块的效果如下：

![](https://gaolei786.github.com/images/shuxin.png)

1.连加求和符号下方的脚注
<pre><code>
$\bar{\phi}_{i,j}=\frac{\sum \limits_{\phi_{i',j'}\in \partial_{i,j}} \phi_{i',j'}}{n_{i,j}}$ \\
</code></pre>
![](https://gaolei786.github.com/images/lianjia.png)


2.latex 幻灯片脚注栏图标、作者、页码的自定义方式[自定义方式](https://joerglenhard.wordpress.com/2011/08/04/beamer-customization-ii-footline-with-multiple-lines/)

![](https://gaolei786.github.com/images/footline2.png)

3.latex 公式中有中文：
<pre><code>
$\mbox{期望最终赔款}=\mbox{期望最终赔付率} \times \mbox{已赚保费}$
</code></pre>
![](https://gaolei786.github.com/images/latexzhongwen.png)






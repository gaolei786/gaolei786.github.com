---
layout: post
title: 同年同月同日生的统计学解释
author: <a href="http://gaolei786.github.com/">GaoLei</a>
categories:
- Statistics
---


---
学统计的人分析问题，如果能够给人留下“意料之外、数理之中”的感觉，算是一种境界了。

---
常常听别人说，某人和某人一天生日，然后就随口来句"这么巧啊".言外之意就是说，两人可真有缘，咱班里有这么一对还真不容易。这“真不容易”该怎么衡量呢？统计学会给我们答案。

我们假设一个班级有50个人，试问，出现生日相同这种事概率多大？注意我们用概率描述可能性。

<pre><code>
 > set.seed(12)
> a <- 0
> for ( i  in 1:100000) {
+   s <- sample(1:365, 50, replace = T)
+   s1 <- unique(s)
+   if(length(s1) <= (50-1)) {
+     a <- a+1
+   }
+ }
> a/100000
[1] 0.97024
</code></pre>

吓到了吧，在一个仅有50人的班级里，出现生日相同这种事的概率可达到97%。也就是说，我们班里没有生日相同这种事倒算是一种小概率事件了。不出意外，我们班肯定会有生日相同这种事发生。注意到，这里我们没有用高深的数理统计推导，我们只是简单的做了一下模拟，模拟次数为100000.

进一步我们班出现有三个人及以上人数生日相同的概率是多少捏？

<pre><code>
> result <- list()
> for (i  in 1:10000) {
+   s <- sample(1:365, 50, replace = T)
+   s1 <- unique(s)
+   gg <- NULL
+   for (x in s1) {
+     
+     gg <- c(gg, sum(s == x))
+   
+   }
+   result[[i]] <- gg
+ }
> fun1 <- function(x) {
+   if(sum(x >= 3) >= 1) {
+     return(1)
+   } else {
+     return(0)
+   }
+ }
> sum(sapply(result, fun1))/10000
[1] 0.1276
</code></pre>

概率大概是12.8%，比较小但是也有可能发生。

你生活的那个圈子大概多少人？150左右吧。我们来看一下你的圈子生日相同的概率。
<pre><code>
> result <- list()
> for (i  in 1:10000) {
+   s <- sample(1:365, 150, replace = T)
+   s1 <- unique(s)
+   gg <- NULL
+   for (x in s1) {
+     
+     gg <- c(gg, sum(s == x))
+   
+   }
+   result[[i]] <- gg
+ }
> fun1 <- function(x) {
+   if(sum(x >= 2) >= 1) {
+     return(1)
+   } else {
+     return(0)
+   }
+ }
> sum(sapply(result, fun1))/10000
[1] 1
</code></pre>

概率为1！所以别再说“真巧啊”这种话了。

有三个人（包含以上）生日相同呢？
<pre><code>
> fun1 <- function(x) {
+   if(sum(x >= 3) >= 1) {
+     return(1)
+   } else {
+     return(0)
+   }
+ }
> sum(sapply(result, fun1))/10000
[1] 0.9656
</code></pre>

概率也是相当高，97%！怎么样，赶快从你的狐朋狗友里扒拉扒拉吧？肯定有的！



---


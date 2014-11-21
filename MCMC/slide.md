% MCMC初步
% 高磊
% 2014/11/20

# <font color=red>MC</font><font color=blue>MC</font>之<font color=blue>MC</font>



## 
- Monte Carlo,摩纳哥的一座小城市，0.68平方千米

<center><img src=10.jpg></img></center>


## 
- 与原子弹制造有关

<center><img src=20.png width=60%></img></center>


## 
- 一条不规则的曲线

<center><img src=1.png width=60%></img></center>


##
- 求曲线围成的面积

<center><img src=2.png width=60%></img></center>

##
- 数学积分的方法：划分为许多间隔

<center><img src=3.png width=60%></img></center>

##
- 统计模拟方法：随机投点(1)

<center><img src=4.png width=60%></img></center>



##
- 统计模拟方法：随机投点(2)

<center><img src=5.png width=60%></img></center>

##
- 投点次数越多，计算越精确

<center><img src=6.png width=60%></img></center>

##
- 求1/4圆的面积，进而求$\pi$

<center><img src=7.png width=60%></img></center>

##
- 用正方形把1/4圆围起来

<center><img src=8.png width=60%></img></center>

##
- 随机投点，数数，近似求$pi$

<center><img src=9.png width=60%></img></center>






# <font color=red>MC</font><font color=blue>MC</font>之<font color=red>MC</font>

## 
- Markov Chain 的一个[例子](http://setosa.io/markov/)

<iframe scrolling="no" style="display: block; float: left;" width="100%" height="300" src="http://setosa.io/markov/transition-matrix.html#%7B%22tm%22%3A%5B%5B0.5%2C0.5%5D%2C%5B0.5%2C0.5%5D%5D%7D"></iframe>

## 
- Markov Chain 所形成的序列1-1500

<center><img src=10.png width=90% height=95%></img></center>


## 
- Markov Chain 所形成的序列1501-3000

<center><img src=11.png width=95% height=95%></img></center>

## 
- Markov Chain 所形成的序列3001-4500

<center><img src=12.png width=95% height=95%></img></center>


## 
- Markov Chain 所形成的序列4501-6000

<center><img src=13.png width=95% height=95%></img></center>

## 
- Markov Chain 的平稳分布(1)

<center><img src=14.png width=60% height=70%></img></center>



## 
- Markov Chain 的平稳分布(2)

<center><img src=15.png width=70% ></img></center>

- 启示：设计一条马氏链，使马氏链的平稳（极限）分布和目标分布相同，然后运行马氏链，其状态序列可以看做目标分布的样本





#<font color=red>MC</font><font color=blue>MC</font>

##

- <font color=red>MC</font><font color=blue>MC</font>家族

<iframe src="http://www.bayesian-inference.com/mcmc#algorithms" width=100% height=75%></iframe>


## 

- Random walk Metropolis-Hastings

<img src=16.png width=100% ></img>

##

- 从一个混合正态分布中抽样

<center><img src=17.png width=40% ></img></center>
<center><img src=18.png width=60% ></img></center>

##

- 初始值:x0=10

<center><img src=21.png width=70% ></img></center>


##

- 提出一个建议:proposal=5.56

<center><img src=22.png width=70% ></img></center>

##

- 计算接受概率:prob=0.09

<center><img src=24.png width=70% ></img></center>

##

- 依概率接受/拒绝(1)

<center><img src=25.png width=70% ></img> </center>

##

- 依概率接受/拒绝(2)

<center><img src=26.png width=70% ></img></center>


##

- 下一状态:x1=x0=10

<center><img src=27.png width=60% ></img></center>


##

- 提出一个建议:proposal=8.15

<center><img src=28.png width=60% ></img></center>

##

- 计算接受概率:prob=0.65

<center><img src=29.png width=60% ></img></center>

##

- 依概率接受/拒绝(1)

<center><img src=30.png width=70% ></img> </center>

##

- 依概率接受/拒绝(2)

<center><img src=31.png width=70% ></img></center>

##

- 下一状态:x2=8.15

<center><img src=31(2).png width=60% ></img></center>

##

- 连续运行20次

<center><img src=32.png width=60% ></img></center>

##

- 连续运行10000次

<center><img src=33.png width=60% ></img></center>


##

- MCMC样本直方图

<center><img src=34.png width=60% ></img></center>

##

- MCMC样本直方图与目标分布拟合较好

<center><img src=35.png width=60% ></img></center>

##

- 序列相关性问题(1)

<center><img src=36.png width=60% ></img></center>

##

- 序列相关性问题(2)

<center><img src=36(2).png width=70% ></img></center>

##

- 序列相关性问题(3)

<center><img src=37.png width=60% ></img></center>

##

- Burn-in

<center><img src=38.png width=60% ></img></center>



## 


- Thank you!

 <center><img src=39.jpg width=60% ></img></center>







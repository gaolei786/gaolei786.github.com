---
layout: post
title:  CTEX,你好！（图解CTEX入门）
description: ""

tags: [ramblings, startups]
categories:
- latex

show_img: "/images/latexbiaoge.png"
---

昨天，我给研一学弟学妹讲解latex，主要是围绕CTEX中文套装的使用。因为我自己了解不多，所以高深的东西我就不讲了，例如自定义命令之类，我自己也不是很清楚，我只讲我当时作为一个初学者所碰的硬壁，那些匪夷所思莫名其妙的问题，这些基本的问题构成了学习Latex的门槛。我自己为了跨过这个门槛，花费了大量的精力，最后，我是以随机事件的形式解决了这些问题。我想通过我的讲解，让他们很快跨过这个门槛，把精力用到文本的编写上，写出更漂亮的pdf文本。现在，我把我的经验分享在这里，希望我的经验对客官您有所帮助。如果看完这篇文档，你也能写出一个中文pdf的话，那对我而言，是件很开心的事！

### 下载CTEX
为了方便中国人学习LATEX，已经就有了LATEX的中文套装CTEX，目前这是对中文支持最好的版本。用CTEX套装，很多复杂的编译命令都简化为几个简单的命令按钮，整个编译也全部以后台形式运行。客官只需要关注如何编辑文本就行了。CTEX可以从[这里](http://www.ctex.org/CTeXDownload)下载,如下图,最好下载中间那个比较大的，因为这个包比较全，功能比较多。

![](https://gaolei786.github.com/images/ctex1.png)

下载后，像安装其他程序一样，大胆安装就行，要耗费一段时间的。

### 初识CTEX

安装完成后，程序就出现在了开始菜单的程序列表里了。如下图。

![](https://gaolei786.github.com/images/ctex2.png)

CTEX,下拉菜单下内容还很多，诸如FontSetup,MixTex之类。我们用的只是其中的一个编辑器--“WinEdit”。以后我们的所有工作，都是基于这个编辑器。这个编辑器，把几乎全部的Latex功能都给套装起来，并且以菜单的形式，没错，就是大家特别钟爱的那种形式。以下是，你打开WinEdit见到的操作界面（有英文版的，还有中文版的，我这里是中文版的）。


![](https://gaolei786.github.com/images/ctex3.png)

其实和word差不多，都有菜单栏、快捷命令按钮。比较特殊地，WinEdit还带有公式快捷命令。Latex编出来的公式，显示在pdf中，那不是一般的漂亮，大概只有资深的word使用者才能达到Latex公式的效果。如果你发现在word中，公式调了半天，还是达不到理想效果（我常常遇到这种情况），我觉得，不是你的问题，是word太不人性化了。Latex自动会把你输入的公式完美地呈现出来。Latex中，不像word有公式编辑器那样插入公式，在Latex 里，公式字符是以“代码”形式存在，比如，你要输入$$\sigma$$,你需要打入“\sigma”，要输入$$\lambda$$,则需要敲入“\lambda”。这么多字符，初学者肯定记不住，所以WinEdit就把他们都收藏起来，你想用哪个，只要一点就插进去了。

编辑区是我们编写文件的地方，编译显示窗口是当我们编写文件后，要把它编译的时候，会显示编译是否正常。


### 我的第一个pdf文件

现在，万事俱备了，我们来开始搞自己的第一个pdf文件。首先要新建一个文件，方法是点击“新建文件”快捷命令。如下图：

![](https://gaolei786.github.com/images/ctex4.png)

有一个问题，要澄清一下：我们不是直接写pdf文件，也就是说，不想word那样写好后保存就OK了；我们首先写的是以tex为后缀的文件，写好后，我们直接把它编译成pdf。那好，我们现在就来写一个tex文件。

内容分两部分：导言区和文本内容。如下图：

![](https://gaolei786.github.com/images/ctex5.png)

导言区位于<code>\documentclass{}</code>和<code>\begin{document}</code>之间，是对文档基本信息的说明，比如文档的类型（文章、书信、建立抑或幻灯片？）、文档的标题、文档的作者、写作时间等，还有要加载的包，文档中使用的一些自定义命令以及格式也得在导言区中定义。在<code>\begin{document}</code>和<code>\end{document}</code>之间是你要写的文本内容了，不多谈。

下面是我写的一个简单的例子：

<pre><code>
\documentclass{article}
\usepackage{ctex}  %加载包，因为我们在用中文写文档，所以必须加载这个包，否则不支持中文
\usepackage{multicol}  %加载包
\usepackage[top=1in, bottom=1in, left=1.25in, right=1.25in]{geometry}  %加载包
\usepackage{lscape}
\author{高磊}  % 作者
\date{2013年11月12日}  %定义时间
\title{准备金风险相关文献梳理}  %文档标题

\begin{document}

\maketitle

以上几篇文献都建立在Mack模型下的解析推导。De Felice, M., Moriconi, F. (2006)最先提出了“CDR”这个想法，不过他用的是“Year-End Obligations”这个名称。后来 W¨uthrich, M.V用的是CDR这个概念，其前两篇文章推导有些瑕疵，与De Felice, M., Moriconi, F. (2006) 不一致。后来，Merz, M., W¨uthrich, M.V. (2008)做出了修正，形成了较为完善的概念体系。

\end{document}
</code></pre>

其中，百分号后边的内容是文档解释，不会被编译。假设我们写好了一个类似上边的文档，下一步我们就要保存它。如下图：

![](https://gaolei786.github.com/images/ctex6.png)

客官您一定要注意保存类型和保存文件名的后缀，类型选"UTF-8"，后缀选择***.tex。编码问题是个头疼的问题，很多tex文档编译不出来，不是文档有问题，原因可能是文档的编码与后台操作不兼容。

保存好之后，就可以直接在WinEdit中对它编译。首先要选择合适的编译器：XeLatex,这个编译器对中文支持比较好，如下图：

![](https://gaolei786.github.com/images/ctex7.png)


选好编译器之后，直接点击它，就开始对文档进行编译了。如下图：

![](https://gaolei786.github.com/images/ctex8.png)

编译进程在这里显示，如下：

![](https://gaolei786.github.com/images/ctex9.png)

编译成功：

![](https://gaolei786.github.com/images/ctex10.png)

与“gaolei.tex”相同的文件夹下，这是出现了一个新文件，它就是我们梦寐以求的“gaolei.pdf”。如果想迅速查看编译结果，可以点击这个快捷命令：

![](https://gaolei786.github.com/images/ctex11.png)

然后就显示编译好的pdf文档：


![](https://gaolei786.github.com/images/ctex12.png)



### 常见问题

1.每次编译，不见得都能编译成功。比如把导言区里的\title改成"\titl",编译器是不能识别这个命令的，于是编译进程就卡住了，根据提示信息，你可以修改文档，以消除错误。不过在再次编译之前，首先要把刚才还“卡着”的程序杀掉（点击红叉），这样才能重新开始编译。


![](https://gaolei786.github.com/images/ctex13.png)

2.当你编译成功，你可能会查看编译出来的pdf文件，你可能会发现有些地方不妥，所以你想修改.tex文档，然后重新编译。亲爱的客官，这时你一定要注意，必须把刚才打开的pdf文件关掉，而且任何程序都不能占用它（如下图，虽然你没有打开，但是你刚才的光标落在这个文件上了，也不行）。否则，你再次编译时，由于你没有关掉原来的pdf文件，WinEdit的编译结果是写不进去的。

![](https://gaolei786.github.com/images/ctex14.png)











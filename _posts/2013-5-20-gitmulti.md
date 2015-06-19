---
layout: post
title: git多账户切换
author: <a href="http://gaolei786.github.com/">GaoLei</a>
categories:
- web
- topic
- git

show_img: "/images/git.png"
---

---
几天来一直在捣鼓如何实现git多账户访问的问题。什么是git多账户访问？比如我开设了A1，A2两个账户，我们如何从本地自由的访问A1和A2账户。显然问题的解决具有重要的意义，我们可以在本机上实现对多个账户的控制，非常方便。

在解决这个问题之前，首先得搞清楚一个账户是怎么设置的。具体说来，git采用了一种公钥-私钥的形式来控制访问。这就像你想拥有一间独立的办公室，需要向单位申请一间屋子，可气的是，单位只有一间毛胚房（这其实就像github给你的一个账户，里面什么也没有）。你首先要做的就是给这间屋安个门（公钥），而且还要为自己配一把钥匙（私钥），这个办公室只有你能进入。剩下的工作就是装潢你的办公室（在github里你就要clone别人的仓库，然后修改，满足自己的要求）。

如何产生公钥-私钥是进行控制访问的关键。公钥-私钥都是在本机用gitbash生成，对应两个文件：id_rsa(私钥）和id_rsa.pub(公钥）。这些文件可以用notepad打开。私钥是由自己保管的（就像办公室的钥匙），公钥是需要添加到你的github账户上去的（就像你做了个门，需要装到办公室）。你每次访问账户时，就是用你的私钥和账户的公钥进行配对，如果配对成功你就可以访问修改，与你进办公室干着干那一个道理。关于私钥公钥生成及公钥添加移步[这里](http://beiyuu.com/github-pages/#github)。

实现对多个github账户的切换控制需要产生多个公钥-私钥对。这些公钥-私钥都可以按照[这篇文章](http://beiyuu.com/github-pages/#github)来做。在做这一块时，我遇到的问题是新生成的公钥-私钥对会把原来的公钥私钥对给覆盖掉。这是因为，gitbash 产生的公钥私钥默认文件名是id-rsa.pub和id-rsa，如果你上一个公钥-私钥的文件名是采用的默认文件名，这次产生的公钥-私钥就要把上一次的覆盖。为了避免这个问题，每次产生公钥私钥后，都对它们重命名，比如(id-rsa.first,id-rsa.first.pub),(id-rsa.second,id-rsa.second.pub)。

必不可少的还有config文件的生成。为什么需要这个文件？因为你必须告诉gitbash,访问某个github账户，需要带哪把私钥。我的config文件是这样的：

<pre><code>
Host gaolei786.github.com
 HostName github.com
 User git
 IdentityFile ~/.ssh/id_rsa

Host reserverisk.github.com
 HostName github.com
 User git
 IdentityFile ~/.ssh/id_rsa.second
</code></pre>

当我访问 gaolei786.github.com这个账户并做相应修改时，gitbash 自动提取的就是<code>IdentityFile ~/.ssh/id_rsa</code>；当我访问 reserverisk.github.com这个账户并做相应修改时，gitbash 自动提取的就是<code>IdentityFile ~/.ssh/id_rsa.second</code>。例如，我在对reserverisk.github.com这个账户修改、推送后：

![git](https://github.com/gaolei786/gaolei786.github.com/raw/master/images/git.png)

最终ssh里的关键文件就是私钥公钥对以及config，我的ssh里是这样的：

![git](https://github.com/gaolei786/gaolei786.github.com/raw/master/images/git1.png)



参考文章：







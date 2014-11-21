---
layout: post
title: 如何将googleVis结果嵌入网页中
categories:
- R

---

任何一个爱美的人，都难掩对googleVis的热爱。googleVis的图形几个关键词就是“优雅，活泼，灵性”。优雅指的是特别美观，看起来特别舒服；活泼指的是图形可以动起来；灵性指的是你可以与图形交流，你可以把你的想法告诉她，她来展示你想要的。

下载googleVis包，加载，看帮助，复制黏贴，真正的眼前一亮，你还等什么呢？

如何把这么优雅活泼灵性的图形放在网上与别人分享呢？这是本文的目的所在。我们以帮助文档中的一个案例作为说明：

<pre><code>
library(googleVis) #如果你还没安装，请install.packages...
M <- gvisMotionChart(Fruits, "Fruit", "Year")
plot(M)
</code></pre>

当你运行以上程序后，你的默认浏览器会自动打开，并显示一个网页，其中就有水果动态图。如下：

![](http://gaolei786.github.io/images/googlevis1.png)

这里有一个小插曲，可能你也会遇到。M 中存放的就是网页源码，如果你把源码复制黏贴入txt,另存为.html。双击.html文件，网页打开了，但图形显示不出来。如下：

![](http://gaolei786.github.io/images/googlevis2.png)

我特别纳闷，为什么源码一模一样，我复制黏贴再显示就出不来了呢？突然一条信息出现了，大概的意思就是，你何不用用遨游浏览器呢？遨游在我看来，应是个骨灰级软件了。我这么说不知道是不是得罪了遨游爱好者（我们宿舍就有一个）。但是我下载了，并且用遨游打开了这个本地网页。如下：

![](http://gaolei786.github.io/images/googlevis3.png)

当时我就有种挫败的感觉，可是我想通了，有时候软件过于先进，比如现在的google浏览器，它就会阻碍那些本地具有交互功能的网页，它以为你可能在干一些黑客类似的事情，有可能伤害计算机，所以它就对你的要求“置之不理”，其实，我是挺黑，但我不是黑客，所以google,你误解我了。遨游这个傻家伙（是不是有点得了好处还卖乖了），不辨是非，你给他什么，它就干什么。

如何把这个图形添加到你自己的网页文档中呢？我开始是把M显示出来，然后，复制，直接加到Markdown里，显然，这么做没有结果，因为M里包括了<html>、<body>和<head>这种标签，与你自己定义的样式会产生冲突。

从网上查询得到了答案：

<pre><code>
cat(M$html$chart, file= "temp.html")
</code></pre>

把temp.html里的代码全部复制到你的文档里就行了，也就是，你只提取关于图形的那段源代码。

![](http://gaolei786.github.io/images/googlevis4.png)

经github处理后，就这样的了，帅气吧，点一点按钮你就知道了。

---


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataMotionChartID12341ba662e4 () {
  var data = new google.visualization.DataTable();
  var datajson =
[
 [
 "Apples",
2008,
"West",
98,
78,
20,
"2008-12-31" 
],
[
 "Apples",
2009,
"West",
111,
79,
32,
"2009-12-31" 
],
[
 "Apples",
2010,
"West",
89,
76,
13,
"2010-12-31" 
],
[
 "Oranges",
2008,
"East",
96,
81,
15,
"2008-12-31" 
],
[
 "Bananas",
2008,
"East",
85,
76,
9,
"2008-12-31" 
],
[
 "Oranges",
2009,
"East",
93,
80,
13,
"2009-12-31" 
],
[
 "Bananas",
2009,
"East",
94,
78,
16,
"2009-12-31" 
],
[
 "Oranges",
2010,
"East",
98,
91,
7,
"2010-12-31" 
],
[
 "Bananas",
2010,
"East",
81,
71,
10,
"2010-12-31" 
] 
];
data.addColumn('string','Fruit');
data.addColumn('number','Year');
data.addColumn('string','Location');
data.addColumn('number','Sales');
data.addColumn('number','Expenses');
data.addColumn('number','Profit');
data.addColumn('string','Date');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartMotionChartID12341ba662e4() {
  var data = gvisDataMotionChartID12341ba662e4();
  var options = {};
options["width"] =    600;
options["height"] =    500;

     var chart = new google.visualization.MotionChart(
       document.getElementById('MotionChartID12341ba662e4')
     );
     chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  var chartid = "motionchart";

  // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
  var i, newPackage = true;
  for (i = 0; newPackage && i < pkgs.length; i++) {
    if (pkgs[i] === chartid)
      newPackage = false;
  }
  if (newPackage)
    pkgs.push(chartid);

  // Add the drawChart function to the global list of callbacks
  callbacks.push(drawChartMotionChartID12341ba662e4);
})();
function displayChartMotionChartID12341ba662e4() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
    var pkgCount = pkgs.length;
    google.load("visualization", "1", { packages:pkgs, callback: function() {
      if (pkgCount != pkgs.length) {
        // Race condition where another setTimeout call snuck in after us; if
        // that call added a package, we must not shift its callback
        return;
      }
      while (callbacks.length > 0)
        callbacks.shift()();
    } });
  }, 100);
}
 
// jsFooter
 </script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartMotionChartID12341ba662e4"></script>
 
<!-- divChart -->
  
<div id="MotionChartID12341ba662e4"
  style="width: 600px; height: 500px;">
</div>


对于表格怎么办呢？大同小异：

<pre><code>
Table <- gvisTable(Exports, options=list(width=400, height=270))
cat(Table$html$chart, file="table.html")
</code></pre>

只需把table.html里的内容复制到你要的文档中就OK了，以下是结果：



<!-- Table generated in R 2.15.1 by googleVis 0.4.3 package -->
<!-- Thu Jun 06 10:58:31 2013 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataTableID123477f7186e () {
  var data = new google.visualization.DataTable();
  var datajson =
[
 [
 "Germany",
3,
true 
],
[
 "Brazil",
4,
false 
],
[
 "United States",
5,
true 
],
[
 "France",
4,
true 
],
[
 "Hungary",
3,
false 
],
[
 "India",
2,
true 
],
[
 "Iceland",
1,
false 
],
[
 "Norway",
4,
true 
],
[
 "Spain",
5,
true 
],
[
 "Turkey",
1,
false 
] 
];
data.addColumn('string','Country');
data.addColumn('number','Profit');
data.addColumn('boolean','Online');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartTableID123477f7186e() {
  var data = gvisDataTableID123477f7186e();
  var options = {};
options["allowHtml"] = true;
options["width"] =    400;
options["height"] =    270;

     var chart = new google.visualization.Table(
       document.getElementById('TableID123477f7186e')
     );
     chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  var chartid = "table";

  // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
  var i, newPackage = true;
  for (i = 0; newPackage && i < pkgs.length; i++) {
    if (pkgs[i] === chartid)
      newPackage = false;
  }
  if (newPackage)
    pkgs.push(chartid);

  // Add the drawChart function to the global list of callbacks
  callbacks.push(drawChartTableID123477f7186e);
})();
function displayChartTableID123477f7186e() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
    var pkgCount = pkgs.length;
    google.load("visualization", "1", { packages:pkgs, callback: function() {
      if (pkgCount != pkgs.length) {
        // Race condition where another setTimeout call snuck in after us; if
        // that call added a package, we must not shift its callback
        return;
      }
      while (callbacks.length > 0)
        callbacks.shift()();
    } });
  }, 100);
}
 
// jsFooter
 </script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartTableID123477f7186e"></script>
 
<!-- divChart -->
  
<div id="TableID123477f7186e"
  style="width: 400px; height: 270px;">
</div>


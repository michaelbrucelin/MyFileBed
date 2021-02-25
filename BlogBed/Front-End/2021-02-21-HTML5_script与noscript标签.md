---
title: script与noscript标签
date: 2021-02-21
categories: 前端
tags: ['前端', 'html']
article_header:
  type: cover
key: U-7A83B592-B3FE-49FC-83E5-0CD34D601B87
---

### script标签

- #### 延迟执行脚本

如果script元素放在head元素内，那么页面会先执行其引用的脚本，然后再加载页面，如果想在页面加载完成后再执行其引用的脚本，通常做法是将script元素放在body元素的最后  
还有一种做法是，仍然将script元素放在head元素内，然后给script元素指定defer属性  
需要注意的是，defer属性只对外部链接脚本文件有效，对script元素的内嵌脚本无效

```html
<script type="text/javascript" src="javascript.js" defer></script>
```

<!--more-->

- #### 异步执行脚本

如果script元素引用的脚本是广告脚本等，与网页没有太大关系，而且有可能会加载失败，可以使用async属性，让脚本异步执行，这样就不会影响整个网页的加载了  
需要注意的是，async属性只对外部链接脚本文件有效，对script元素的内嵌脚本无效

```html
<script type="text/javascript" src="javascript.js" async></script>
```

### noscript标签

如果页面支持javascript，会显示noscript元素中的内容，noscript元素内可以是其他html元素

```html
<noscript>
    <p>对不起，你的浏览器当前不支持javascript，影响您正常使用网站。</p>
</noscript>
```

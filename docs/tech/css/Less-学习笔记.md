---
title: Less学习笔记
lang: 'zh-CN'
description: 'LGD.HuaFEEng博客网站-技术分类-CSS专题-Less学习笔记'
meta:
  - name: keywords
  - content: 技术,CSS,Less,学习,笔记,前端
---

[[TOC]]

## 1.初见 Less

### 1.1 什么是 Less

- Less 是一个 CSS 预编译器，意思指的是它可以扩展 CSS 语言，添加功能如允许变量（variables），混合（mixins），函数（functions）和许多其他的技术，让你的 CSS 更具维护性、主题性、扩展性。

### 1.2 Less 官方网站

- http://lesscss.org/

### 1.3 与 Less 的第一次碰面

```less
.conten {
  ul {
    list-style: none;
  }
  li {
    height: 25px;
    line-height: 25px;
    padding-left: 15px;
    background: url('arr.jpg') no-repeat center left;
    a {
      text-decoration: none;
      color: #535353;
      font-family: microsoft yahei, '黑体', Arial, Simsun, 'Arial Unicode MS', Mingliu,
        Helvetica;
    }
  }
}
```

### 1.4 Less 中的注释

- // 只会在 LESS 中显示，不会被编译到 css 文件中
- /_就会在 LESS 和 CSS 中显示_/，会被编译到 css 文件中

## 2.正确使用 Less

### 2.1 如何使用 Less

- Less 文件只有在被编译后才能被浏览器识别使用

### 2.2 Less 编译工具

- Koala http://koala-app.com/
- WinLess
- CodeKit

### 2.3 客户端调试方式

- 首先引用 Less 文件 link 引入，rel="stylesheet/less"
- 然后引用 less.js 要在 less 样式文件之后引入

## 3.变量(variables)

### 3.1 普通的变量

- 定义 @

```less
@blue: #5b83ad;
#header {
  color: @blue;
}
```

- 由于变量只能定义一次，实际上它们就是“常量”

### 3.2 作为选择器和属性名

- @{变量名}

```less
@mySelector: width;
.@{mySelector} {
  @{mySelector}: 960px;
}
```

### 3.3 作为 URL

- 使用时，使用""将变量的值括起来，使用时同样将变量以@{变量名}的方式使用

```less
@myUrl: 'http://www.xxx.xxx';
body {
  background: #4cdca9 url('@{myUrl}/logo.png') no-repeat;
}
```

### 3.4 延迟加载

- 变量是延迟加载的，在使用前不一定要预先声明

```less
.lazy-eval {
  width: @var;
}
@var: @a;
@a: 9%;
```

### 3.5 定义多个相同名称的变量时

- 在定义一个变量两次时，只会使用最后定义的变量，Less 会从当前作用域中向上搜索。这个行为类似于 CSS 的定义中始终使用最后定义的属性值。

## 4.混合(mixins)

### 4.1 普通混合

- 混合就是一种将一系列属性从一个规则集引入（“混合”）到另一个规则集的方式。

```less
// 基本混合
.font_hn {
  color: red;
  font-family: microsoft yahei, '黑体', Arial, Simsun, 'Arial Unicode MS', Mingliu,
    Helvetica;
}
h1 {
  font-size: 28px;
  .font_hn;
}
h2 {
  font-size: 24px;
  .font_hn;
}
/*编译成*/
.font_hn {
  color: red;
  font-family: microsoft yahei, '黑体', Arial, Simsun, 'Arial Unicode MS', Mingliu,
    Helvetica;
}
h1 {
  font-size: 28px;
  color: red;
  font-family: microsoft yahei, '黑体', Arial, Simsun, 'Arial Unicode MS', Mingliu,
    Helvetica;
}
h2 {
  font-size: 24px;
  color: red;
  font-family: microsoft yahei, '黑体', Arial, Simsun, 'Arial Unicode MS', Mingliu,
    Helvetica;
}
```

### 4.2 不带输出的混合

- 如果你想要创建一个混合集，但是却不想让它输出到你的样式中

```less
// 不带输出的混合，类名后面使用()
.font_hn() {
  color: red;
  font-family: microsoft yahei, '黑体', Arial, Simsun, 'Arial Unicode MS', Mingliu,
    Helvetica;
}
h1 {
  font-size: 28px;
  .font_hn;
}
h2 {
  font-size: 24px;
  .font_hn;
}
```

### 4.3 带选择器的混合

```less
// 带选择器的混合
.my-hover-mixin() {
  &:hover {
    border: 1px solid red;
  }
}
button {
  .my-hover-mixin();
}
/*编译成*/
button:hover {
  border: 1px solid red;
}

.my-hover-mixin {
  &:hover {
    border: 1px solid red;
  }
}
h1 {
  .my-hover-mixin();
}
/*编译成*/
.my-hover-mixin:hover {
  border: 1px solid red;
}
h1:hover {
  border: 1px solid red;
}
```

### 4.4 带参数的混合

```less
// 带参数的混合
.border(@color) {
  border: 1px solid @color;
}
h1 {
  &:hover {
    .border(green);
  }
}
/*编译成*/
h1:hover {
  border: 1px solid #008000;
}
```

### 4.5 带参数并且有默认值

```less
/*带参数并且有默认值的混合*/
.border_you(@color:red) {
  border: 1px solid @color;
}
h1 {
  &:hover {
    .border_you();
  }
}
h2 {
  &:hover {
    .border_you(yellow);
  }
}
/*编译成*/
/*带参数并且有默认值的混合*/
h1:hover {
  border: 1px solid #ff0000;
}
h2:hover {
  border: 1px solid #ffff00;
}
```

### 4.6 带多个参数的混合

- 一个组合可以带多个参数，参数之间可以用分号或者逗号分隔
- 但是推荐使用分号分割，因为逗号符号有两个意思。他可以解释为 mixins 参数分隔符或者 css 列表分隔符。
- 两个参数，并且每个参数都是逗号分割的列表 .name(1,2,3;something, ele)
- 三个参数，并且每个参数都包含一个数字 .name(1,2,3)
- 使用伪造的分号创建 mixin，调用的时候参数包含一个逗号分割的 css 列表 .name(1,2,3;)
- 逗号分割默认值 .name(@param1: red, blue)

```less
// 带多个参数的混合
// 如果传参的括号里面全部都是以“，”分割，那么会依次传给各个参数值，
// 如果传参的括号里面既有“，”又有“；”那么，会把“；”前面的看作一个整体，传给一个参数值
.mixin(@color: black; @margin: 10px; @padding: 20px) {
  color: @color;
  margin: @margin;
  padding: @padding;
}
.divmaizi {
  .mixin(1, 2, 3;);
}
/*编译成*/
.divmaizi {
  color: 1, 2, 3;
  margin: 10px;
  padding: 20px;
}
```

- 定义多个具有相同名称和参数数量的 mixins 是合法的。Less 会使用它可以应用的属性。如果使用 mixin 的时候只带一个参数，比如.mixin(green)，这个属性会导致所有的 mixin 都会强制使用这个明确的参数

```less
/*定义多个具有相同名称和参数数量的混合*/
.mixin(@color) {
  color-1: @color;
}
.mixin(@color; @padding:2) {
  color-2: @color;
  padding-2: @padding;
}
.mixin(@color; @padding; @margin: 2) {
  color-3: @color;
  padding-3: @padding;
  margin: @margin @margin @margin @margin;
}

.some .selector div {
  .mixin(#008000);
}
/*编译成*/
/*定义多个具有相同名称和参数数量的混合*/
.some .selector div {
  color-1: #008000;
  color-2: #008000;
  padding-2: 2;
}
```

### 4.7 命名参数

- 引用 mixin 时可以通过参数名称而不是参数的位置来为 mixin 提供参数值，任何参数都已通过它的名称来引用，这样就不必按照任意特定的顺序来使用参数

```less
// 命名参数
.mixin(@color: black; @margin: 10px; @padding: 20px) {
  color: @color;
  margin: @margin;
  padding: @padding;
}
.class1 {
  .mixin(@margin: 20px; @color: #33acfe);
}
.class2 {
  .mixin(#efca44; @padding: 40px);
}
.class3 {
  .mixin(@padding: 80px;);
}
/*编译成*/
.class1 {
  color: #33acfe;
  margin: 20px;
  padding: 20px;
}
.class2 {
  color: #efca44;
  margin: 10px;
  padding: 40px;
}
.class3 {
  color: #000000;
  margin: 10px;
  padding: 80px;
}
```

### 4.8 @arguments 变量

- @arguments 代表所有的可变参数
- @arguments; 代表所有可变参数时，参数的先后顺序就是你的（）括号内的参数的先后顺序
- 注意在使用的赋值，值的位置和个数也是一一对应的，只有一个值，把值赋值给第一个，两个值，赋值给第一个和第二个，三个值，分别赋值给第三个......以此类推，但是需要主要的是假如我想给第一个和第三个赋值，你不能写（值 1， ，值 3），必须把原来的默认值写上去！

```less
/*@arguments;*/
.border(@x:solid,@c:red) {
  border: 21px @arguments;
}
.div1 {
  .border();
}
/*编译成*/
/*@arguments;*/
.div1 {
  border: 21px solid #ff0000;
}
```

### 4.9 匹配模式

- 传值的时候定义一个字符，在使用的时候使用哪个字符，就调用哪条规则

```less
.border(all,@w: 5px) {
  border-radius: @w;
}
.border(t_l,@w:5px) {
  border-top-left-radius: @w;
}
.border(t_r,@w:5px) {
  border-top-right-radius: @w;
}
.border(b-l,@w:5px) {
  border-bottom-left-radius: @w;
}
.border(b-r,@w:5px) {
  border-bottom-right-radius: @w;
}
footer {
  .border(t_l, 10px);
  .border(b-r, 10px);
  background: #33acfe;
}
/*编译成*/
footer {
  border-top-left-radius: 10px;
  border-bottom-right-radius: 10px;
  background: #33acfe;
}
```

### 4.10 得到混合中变量的返回值

```less
// 混合的返回值
.average(@x, @y) {
  @average: ((@x + @y) / 2);
  @he: (@x + @y);
}
div {
  .average(16px, 50px);
  padding: @average;
  margin: @he;
}
/*编译成*/
div {
  padding: 33px;
  margin: 66px;
}
```

## 5.嵌套规则(nested-rules)

- 嵌套规则它模仿了 HTML 的结构，让我们的 css 代码更加简洁明了清晰
- & 表示当前选择器的所有父选择器
- 将&放到当前选择器之后，就会将当前选择器插入到所有的父选择器之前
- 组合使用生成所有可能的选择器列表

```less
p,
a,
ul,
li {
  border-top: 2px dotted #366;
  & & {
    border-top: 0;
  }
}
/*编译成*/
p,
a,
ul,
li {
  border-top: 2px dotted #366;
}
p p,
p a,
p ul,
p li,
a p,
a a,
a ul,
a li,
ul p,
ul a,
ul ul,
ul li,
li p,
li a,
li ul,
li li {
  border-top: 0;
}
```

## 6.运算(operations)

- 任何数值，颜色和变量都可以进行运算
- Less 会为你自动推断数值的单位，所以你不必每一个值都加上单位
- 注意：运算符与值之间必须以空格分开，涉及优先级时以()进行优先级运算
- Less 在运算时，先将颜色值转换为 rgb 模式，然后在转换为 16 进制的颜色值并且返回
- 注意：既然是转换为 rgb 模式，我们知道 rgb 的取值范围是 0~255，所以我们计算的时候不能超过这个区间，超过后默认使用最大值 255 计算

```less
.wp {
  background: red - 55;
}
/*编译成*/
.wp {
  background: #ff0000 - 55;
}
```

## 7.函数(functions)

- Less 提供了许多用于转换颜色、处理字符串和进行算术运算的函数，这些函数使用起来非常简单。
- 最常见的 rgb()函数，将 rgb 模式的值转换为 16 进制的值

## 8.命名空间

- 将一些需要的混合组合在一起，可以通过嵌套多层 id 或者 class 来实现

```less
#bgcolor() {
  background: #ffffff;
  .a {
    color: #888888;
    &:hover {
      color: #ff6600;
    }
    .b {
      background: #ff0000;
    }
  }
}
.wi {
  background: green;
  color: #fff;
  .a {
    color: green;
    background: #ffffff;
  }
}
.bgcolor1 {
  background: #fdfee0;
  #bgcolor>.a;
}
.bgcolor2 {
  .wi>.a;
}
/*编译成*/
.wi {
  background: green;
  color: #fff;
}
.wi .a {
  color: green;
  background: #ffffff;
}
.bgcolor1 {
  background: #fdfee0;
  color: #888888;
}
.bgcolor1:hover {
  color: #ff6600;
}
.bgcolor1 .b {
  background: #ff0000;
}
.bgcolor2 {
  color: green;
  background: #ffffff;
}

// 省略>写法
#bgcolor() {
  background: #ffffff;
  .a {
    color: #888888;
    &:hover {
      color: #ff6600;
    }
    .b {
      background: #ff0000;
    }
  }
}
.wi {
  background: green;
  color: #fff;
  .a {
    color: green;
    background: #ffffff;
  }
}
.bgcolor1 {
  background: #fdfee0;
  #bgcolor .a;
}
.bgcolor2 {
  .wi .a;
}
/*编译成*/
.wi {
  background: green;
  color: #fff;
}
.wi .a {
  color: green;
  background: #ffffff;
}
.bgcolor1 {
  background: #fdfee0;
  color: #888888;
}
.bgcolor1:hover {
  color: #ff6600;
}
.bgcolor1 .b {
  background: #ff0000;
}
.bgcolor2 {
  color: green;
  background: #ffffff;
}
```

## 9.作用域

- Less 中的作用域与编程语言中的作用域概念非常相似，首先会在局部查找变量和混合，如果没找到，编译器就会在父作用域中查找，以此类推

## 10.引入(importing)

- 你可以引入一个或多个.less 文件，然后这个文件中的所有变量都可以在当前的 less 项目中使用
  - @import "main";
- 注意：引用.css 文件会被原样输出到编译的文件中，不会混合到项目中
  - 无法引用 css 中的选择器代码
- 可带参数
  - once 默认，只包含一次
  - reference 使用 Less 文件但不输出
  - inline 在输出中包含源文件但不加工它
  - less 将文件作为 Less 文件对象，无论是什么文件扩展名
  - css 将文件作为 css 文件对象，无论是什么文件扩展名
  - multiple multiple 允许引入多次相同文件名的文件

## 11.关键字(important)

- 在调用的混合集后面追加!important 关键字，可以使混合集里面的所有属性都继承!important

```less
.foo (@bg: #f5f5f5, @color: #900) {
  background: @bg;
  color: @color;
  font-size: 16px;
  font-weight: 900;
}
.unimportant {
  .foo();
}
.important {
  .foo() !important;
}
/*编译成*/
.unimportant {
  background: #f5f5f5;
  color: #990000;
  font-size: 16px;
  font-weight: 900;
}
.important {
  background: #f5f5f5 !important;
  color: #990000 !important;
  font-size: 16px !important;
  font-weight: 900 !important;
}
```

## 12.条件表达式

- 带条件的混合

  - > ，>=，=，=<，<，true

  ```less
  // 255/2=127.5
  .mixin (@a) when (lightness(@a) >= 50%) {
    background-color: black;
  }
  .mixin (@a) when (lightness(@a) < 50%) {
    background-color: white;
  }
  .mixin (@a) {
    color: @a;
  }
  // 7e7e7e  =  126
  .class1 {
    .mixin(#7e7e7e);
  }
  // 808080 = 128
  .class2 {
    .mixin(#808080);
  }
  /*编译成*/
  .class1 {
    background-color: white;
    color: #7e7e7e;
  }
  .class2 {
    background-color: black;
    color: #808080;
  }
  ```

- 类型检查函数

  - iscolor
  - isnumber
  - isstring
  - iskeyword
  - isurl

  ```less
  // iscolor,isnumber.....判断值的类型
  .mixin (@a) when (iscolor(@a)) {
    background-color: black;
  }
  .mixin (@a) when (isnumber(@a) ) {
    background-color: white;
    shuzi: shuzi;
  }
  .mixin (@a) {
    color: @a;
  }
  .class1 {
    .mixin(#7e7e7e);
  }
  .class2 {
    .mixin(123);
  }
  /*编译成*/
  .class1 {
    background-color: black;
    color: #7e7e7e;
  }
  .class2 {
    background-color: white;
    shuzi: shuzi;
    color: 123;
  }
  ```

- 单位检查函数
  - ispixel
  - ispercentage
  - isem
  - isunit
  ```less
  // ispixel,ispercentage.....单位检查函数
  .mixin (@a) when (ispixel(@a)) {
    background-color: black;
  }
  .mixin (@a) when (ispercentage(@a) ) {
    background-color: white;
  }
  .mixin (@a) {
    width: @a;
  }
  .class1 {
    .mixin(960px);
  }
  .class2 {
    .mixin(95%);
  }
  /*编译成*/
  .class1 {
    background-color: black;
    width: 960px;
  }
  .class2 {
    background-color: white;
    width: 95%;
  }
  ```

## 13.循环(loop)

- 在 Less 中，混合可以调用它自身。这样，当一个混合递归调用自己，再结合 Guard 表达式和模式匹配这两个特性，就可以写出循环结构。

```less
.loop(@counter) when (@counter < 7) {
  h@{counter} {
    padding: (10px * @counter);
  }
  .loop((@counter + 1));
}
div {
  .loop(1);
}
/*编译成*/
div h1 {
  padding: 10px;
}
div h2 {
  padding: 20px;
}
div h3 {
  padding: 30px;
}
div h4 {
  padding: 40px;
}
div h5 {
  padding: 50px;
}
div h6 {
  padding: 60px;
}
```

## 14.合并属性

- '+'逗号分隔所合并的属性值
  - 在需要合并的属性的':'的前面加上'+'就可以完成合并，合并以','分割属性
- '+\_'空格分隔所合并的属性值
  - 在需要合并的属性的':'的前面加上'+\_'就可以完成合并，合并以' '分割属性

```less
// + 合并以后，以逗号分割属性值
.mixin() {
  box-shadow+: inset 0 0 10px #555;
}
.myclass {
  .mixin();
  box-shadow+: 0 0 20px black;
}
// +_ 合并以后，以空格分割属性值
.a() {
  background+: #f60;
  background+_: url('/sss.jod');
  background+: no-repeat;
  background+_: center;
}
.myclass {
  .a();
}
/*编译成*/
.myclass {
  box-shadow: inset 0 0 10px #555, 0 0 20px black;
}
.myclass {
  background: #f60 url('/sss.jod'), no-repeat center;
}
```

## 15.函数库(function)

### 15.1 其他函数

- color()函数

  - 解析颜色，将代表颜色的字符串转换为颜色值

- convert()函数

  - 将数字从一种类型转换到另一种类型

- data-uri()函数

  - 将一个资源内嵌到样式文件，如果开启了 ieCompat 选项，而且资源文件的体积过大，或者是在浏览器中使用，则会使用 url()进行回退。如果没有指定 MIME，则 Node.js 会使用 MIME 包来决定正确的 MIME

- default()函数

  - 只能边界条件中使用，没有匹配到其他自定义函数（mixin）的时候返回 true，否则返回 false

  ```less
  .x(1) {
    x: 11;
  }
  .x(2) {
    y: 22;
  }
  .x(@x) when (default()) {
    z: @x;
  }
  .div1 {
    .x(1);
  }
  .div2 {
    .x(123);
  }
  /*编译成*/
  .div1 {
    x: 11;
  }
  .div2 {
    z: 123;
  }

  .x(@x) when (ispixel(@x)) {
    width: @x;
  }
  .x(@x) when not(default()) {
    padding: (@x / 10);
  }
  .div1 {
    .x(100px);
  }
  .div2 {
    .x(100cm);
    color: red;
  }
  /*编译成*/
  .div1 {
    width: 100px;
    padding: 10px;
  }
  .div2 {
    color: red;
  }
  ```

- unit()函数
  - 移除或者改变属性值的单位
  ```less
  div {
    width: unit(100px, cm);
  }
  /*编译成*/
  div {
    width: 100cm;
  }
  ```

### 15.2 字符串函数、长度相关函数

- escape()函数

  - 将输入字符串中的 url 特殊字符进行编码处理
  - 不转义的编码 ',' '/' '?' '@' '&' '+' ''' '~' '!' '\$'
  - 转义的编码 '#' '^' '(' ')' '{' '}' '|' ':' '>' '<' ';' ']' '[' '='

- e()函数

  - css 转义，用~"值"符号代替

  ```less
  div {
    filter: e("ms:alwaysHasItsOwnSyntax.For.Stuff()");
    filter2: ~"ms:alwaysHasItsOwnSyntax.For.Stuff()";
    width: calc(~'960px - 100px');
    height: calc(~'960px - 100px');
  }
  /*编译成*/
  div {
    filter: ms:alwaysHasItsOwnSyntax.For.Stuff();
    filter2: ms:alwaysHasItsOwnSyntax.For.Stuff();
    width: calc(960px - 100px);
    height: calc(960px - 100px);
  }
  ```

- %()函数

  - 函数%(string, arguments...)格式化一个字符串
  - d,D,a,A 能被任何类型参数替换（颜色值，数字，转义值，表达式，...）如果你在字符串中结合使用，整个字符串参数都会替换进去，包括它的引号，然后引号会被替换到字符串参数的原有位置，也许会被转义或者还是不变的，取决于占位符是大写字母还是小写字母
  - s,S 能被除了颜色值以外任何类型参数替换（实际测试，颜色值也可以），如果你在字符串中结合使用，只会替换成字符串参数的值，而字符串参数引号都被忽略

  ```less
  div {
    font-family1: %('%a %a', 'Microsoft', 'YaHei');
    font-family2: %('%A %a', 'Microsoft', 'YaHei');
    font-family3: %('%d %d', 'Microsoft', 'YaHei');
    font-family4: %('%D %d', 'Microsoft', 'YaHei');
    font-family5: %('%s %s', 'Microsoft', 'YaHei');
    font-family6: %('%S %s', 'Microsoft', 'YaHei');
    font-family7: %('%s %s', #f00, 'YaHei');
  }
  /*编译成*/
  div {
    font-family1: '' Microsoft ' ' YaHei '';
    font-family2: '%22Microsoft%22 ' YaHei '';
    font-family3: '' Microsoft ' ' YaHei '';
    font-family4: '%22Microsoft%22 ' YaHei '';
    font-family5: 'Microsoft YaHei';
    font-family6: 'Microsoft YaHei';
    font-family7: '#ff0000 YaHei';
  }
  ```

- replace()函数

  - 用另一个字符串替换文本

  ```less
  div {
    content: replace('Hello, World', 'World', 'LESS');
  }
  /*编译成*/
  div {
    content: 'Hello, LESS';
  }
  ```

- length()函数

  - 返回集合中的值的条数

  ```less
  div {
    z-index: length(1px solid #0080ff);
  }
  /*编译成*/
  div {
    z-index: 3;
  }
  ```

- extract()函数
  - 返回集合中指定索引的值
  ```less
  div {
    @list: 'A', 'B', 'C', 'D';
    n: extract(@list, 4);
  }
  /*编译成*/
  div {
    n: 'D';
  }
  ```

### 15.3 数学函数

- ceil()函数
  - 向上取整
- floor()函数
  - 向下取整
- percentage()函数
  - 将浮点数转换为百分比
- round()函数
  - 取整和四舍五入
- sqrt()函数
  - 计算一个数的平方根，原样保持单位
- abs()函数
  - 计算数字的绝对值，原样保持单位
- sin()函数
  - 正弦函数
- asin()函数
  - 反正弦函数
- cos 函数
  - 余弦函数
- acos()函数
  - 反余弦函数
- tan()函数
  - 正切函数
- atan()函数
  - 反正切函数
- pi()函数
  - 返回 π（pi）
- pow()函数
  - 乘方运算
- mod()函数
  - 取余运算
- min()函数
  - 最小值运算
- max()函数
  - 最大值运算

```less
div {
  //  width: ceil(2.9999999px);   //1.ceil()函数  向上取整
  //  width: floor(2.9999999px);   //1.floor()函数  向下取整
  //  width:percentage( 0.5px);  将浮点数转换为百分比

  //  取整和四舍五入
  //  width:4.5px ;
  //  width:round(4.5px) ;
  //  width:4.4px ;
  //  width:round(4.4px) ;

  //  计算一个数的平方根，原样保持单位。
  //  width: sqrt(16px);
  //  width: sqrt(9px);

  //  计算数字的绝对值，原样保持单位。
  //  top: -999px;
  //  top: abs(-999px);

  //  width: sin(1);  //1弧度角的正弦值
  //  width: sin(1deg);//1角度角的正弦值
  //  width: sin(1grad); //1百分度角的正弦值

  //  反正弦值
  //  width: asin(-0.84147098);
  //  width: asin(0);
  //  width: asin(2);

  //    width: cos(1);  //1弧度角的余弦值
  //    width: cos(1deg);//1角度角的余弦值
  //    width: cos(1grad); //1百分度角的余弦值

  //  width: tan(1);  //1弧度角的正切值
  //  width: tan(1deg);//1角度角的正切值
  //  width: tan(1grad); //1百分度角的正切值

  //  PI
  //  width: pi();

  //  乘方运算
  //  width: pow(2px,2);
  //  width: pow(3px,2);
  //  width: pow(4px,2);
  //  width: pow(25px,0.5);

  //  mod()取余
  //  width: mod(3px,2);

  width: min(3px, 2px, 1px);
  width: max(3px, 2px, 1px);
}
/*编译成*/
div {
  width: 1px;
  width: 3px;
}
```

### 15.4 类型函数

- isnumber() 是否数字
- isstring() 是否字符串
- iscolor() 是否颜色值
- iskeyword() 是否关键字
- isurl() 是否 url 地址
- ispixel() 是否带像素长度单位的数字
- isem() 是否带 em 长度单位的数字
- ispercentage() 是否带百分比单位的数字
- isunit() 是否带指定单位的数字

```less
//如果一个值是一个数字，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (isnumber(@x)) {
//  x:@x
//}
//div{
//.m(123);
//.m(ABC);
//}

//如果一个值是一个字符串，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (isstring(@x)) {
//  x:@x
//}
//div{
//.m(123);
//.m("ABC");
//}

//如果一个值是一个颜色，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (iscolor(@x)) {
//  x:@x
//}
//div{
//  .m(123);
//  .m("ABC");
//  .m(red);
//}

//如果一个值是一个关键字，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (iskeyword(@x)) {
//  x:@x
//}
//div{
//  .m(123);
//  .m("ABC");
//  .m(red);
//  .m(ABC);
//}

//如果一个值是一个url地址，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (isurl(@x)) {
//  x:@x
//}
//div{
//  .m(123);
//  .m("ABC");
//  .m(red);
//  .m(ABC);
//  .m(url(arr.jpg));
//}

//如果一个值是带像素长度单位的数字，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (ispixel(@x)) {
//  x:@x
//}
//div{
//  .m(123);
//  .m("ABC");
//  .m(red);
//  .m(ABC);
//  .m(url(arr.jpg));
//  .m(220px);
//  .m(220cm);
//}

//如果一个值是带em长度单位的数字，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (isem(@x)) {
//  x:@x
//}
//div{
//  .m(123);
//  .m("ABC");
//  .m(red);
//  .m(ABC);
//  .m(url(arr.jpg));
//  .m(220px);
//  .m(240em);
//}

//如果一个值是带百分比单位的数字，返回'真(true)',否则返回'假(false)'.
//.m(@x) when (ispercentage(@x)) {
//  x:@x
//}
//div{
//  .m(123);
//  .m("ABC");
//  .m(red);
//  .m(ABC);
//  .m(url(arr.jpg));
//  .m(220px);
//  .m(240em);
//  .m(260%);
//}

// 如果一个值是带指定单位的数字，返回'真(true)',否则返回'假(false)'.
.m(@x) when (isunit(@x,em)) {
  x: @x;
}
div {
  .m(123);
  .m(220px);
  .m(240em);
  .m(280em);
  .m(290em);
  .m(260%);
}
/*编译成*/
div {
  x: 240em;
  x: 280em;
  x: 290em;
}
```

### 15.5 颜色值定义函数

- rgb()
  - 通过十进制红色，绿色，蓝色三种值（RGB）创建不透明的颜色对象
- rgba()
  - 通过十进制红色，绿色，蓝色，以及 alpha 四种值（RGBA）创建带 alpha 透明的颜色对象
- argb()
  - 创建格式为#AARRGGBB 的十六进制（hex representation）颜色
- hsl()
  - 通过色相（hue），饱和度（saturation），亮度（lightness），三种值（HSL）创建不透明的颜色对象
- hsla()
  - 通过色相（hue），饱和度（saturation），亮度（lightness），以及 alpha 四种值（HSLA）创建透明的颜色对象
- hsv()
  - 通过色相（hue），饱和度（saturation），色调（value）三种值（HSV）创建不透明的颜色对象
- hsva()
  - 通过色相（hue），饱和度（saturation），色调（value），以及 alpha 四种值（HSVA）创建透明的颜色对象

```less
//通过十进制红色，绿色，蓝色三种值 (RGB) 创建不透明的颜色对象。
div {
  background: rgb(255, 0, 0);
  background: rgb(100%, 0%, 0%);
}

//通过十进制红色，绿色，蓝色，以及 alpha 四种值 (RGBA) 创建带alpha透明的颜色对象。
div {
  background: rgba(255, 0, 0, 0.5);
  background: rgba(100%, 0%, 0%, 0.5);
}

//创建格式为 #AARRGGBB 的十六进制 (hex representation) 颜色 (注意不是 #RRGGBBAA ！)。
div {
  background: argb(rgba(255, 0, 0, 0.5));
  background: argb(rgba(100%, 0%, 0%, 0.5));
}

//通过色相 (hue)，饱和度 (saturation)，亮度 (lightness) 三种值 (HSL) 创建不透明的颜色对象。
div {
  background: hsl(90, 100%, 50%);
}

//通过色相 (hue)，饱和度 (saturation)，亮度 (lightness)，以及 alpha 四种值 (HSLA) 创建透明的颜色对象。
div {
  background: hsla(90, 100%, 50%, 0.5);
}

//通过色相 (hue)，饱和度 (saturation)，色调 (value) 三种值 (HSV) 创建不透明的颜色对象。
div {
  background: hsv(90, 100%, 50%);
}

//通过色相 (hue)，饱和度 (saturation)，色调 (value)，以及 alpha 四种值 (HSVA) 创建透明的颜色对象。
div {
  background: hsva(90, 100%, 50%, 8%);
}
```

### 15.6 颜色值通道提取函数

- hue()
  - 从 HSL 色彩空间中提取颜色对象的色相值
- saturation()
  - 从 HSL 色彩空间中提取颜色对象的饱和度值
- lightness()
  - 从 HSL 色彩空间中提取颜色对象的亮度值
- hsvhue()
  - 从 HSV 色彩空间中提取颜色对象的色相值
- hsvsaturation()
  - 从 HSV 色彩空间中提取颜色对象的饱和度值
- hsvvalue()
  - 从色彩空间中提取颜色对象的色调值
- red()
  - 提取颜色对象的红色值
- green()
  - 提取颜色对象的绿色值
- blue()
  - 提取颜色对象的蓝色值
- alpha()
  - 提取颜色对象的透明值
- luma()
  - 计算颜色对象 luma 的值（亮度的百分比表示法）
- luminance()
  - 计算没有伽玛校正的亮度值

```less
div {
  // hue()色相值
  z-index: hue(hsl(90, 100%, 50%)); //90
  // saturation()饱和度
  z-index: saturation(hsl(90, 80%, 50%)); //80%
  // lightness()亮度值
  z-index: lightness(hsl(90, 100%, 100%)); //100%

  // hsv(90,100%,50%)
  z-index: hsvhue(hsv(90, 100%, 50%)); //函数90
  z-index: hsvsaturation(hsv(90, 100%, 50%)); //函数100%
  z-index: hsvvalue(hsv(90, 100%, 50%)); //函数50%

  // rgba(29,199,29,80%)
  // 提取红色
  z-index: red(rgba(29, 199, 150, 80%)); //29
  // 提取绿色
  z-index: green(rgba(29, 199, 150, 80%)); //199
  // 提取蓝色
  z-index: blue(rgba(29, 199, 150, 80%)); //29
  // 提取透明度
  z-index: alpha(rgba(29, 199, 150, 80%)); //0.8

  // 计算颜色对象luma的值（亮度的百分比表示法）。
  z-index: luma(rgb(100, 200, 30));
  // 计算没有伽玛校正的亮度值
  z-index: luminance(rgb(100, 200, 30));
}
```

### 15.7 颜色值运算函数

- saturate()
  - 增加一定数值的颜色饱和度
- desaturate()
  - 降低一定数值的颜色饱和度
- lighten()
  - 增加一定数值的颜色亮度
- darken()
  - 降低一定数值的颜色亮度
- fadein()
  - 降低颜色的透明度（或增加不透明度），令其更不透明
- fadeout()
  - 增加颜色的透明度（或降低不透明度），令其更透明
- fade()
  - 给颜色（包括不透明的颜色）设定一定数值的透明度
- spin()
  - 任意方向旋转颜色的色相角度（hue angle）
- mix()
  - 根据比例混合两种颜色，包括计算不透明度
- greyscale()
  - 完全移除颜色的饱和度，与 desaturate(@color, 100%)函数效果相同
- contrast()
  - 选择两种颜色相比较，得出哪种颜色的对比度最大就倾向于对比度最大的颜色

```less
body {
  c: hsl(90, 80%, 50%);
  c: saturate(hsl(90, 80%, 50%), 20%);
}
div {
  width: 90px;
  height: 50px;
  font-size: 16px;
  text-align: center;
}
.ys1 {
  background: hsl(90, 80%, 50%);
}
.ys2 {
  background: saturate(hsl(90, 80%, 50%), 20%);
}
.ys3 {
  background: desaturate(hsl(90, 80%, 50%), 20%);
}
.ys4 {
  background: lighten(hsl(90, 80%, 50%), 20%);
}
.ys5 {
  background: darken(hsl(90, 80%, 50%), 20%);
}
.ys66 {
  background: hsla(90, 80%, 50%, 50%);
}
.ys6 {
  background: fadein(hsla(90, 80%, 50%, 50%), 50%);
}
.ys7 {
  background: fadeout(hsla(90, 80%, 50%, 50%), 40%);
}
.ys8 {
  background: hsl(90, 80%, 50%);
}
.ys9 {
  background: fade(hsl(90, 80%, 50%), 40%);
}
.ys10 {
  background: hsl(10, 90%, 50%);
}
.ys11 {
  background: spin(hsl(0, 90%, 50%), 360);
}

.ys12 {
  background: rgba(100, 50, 20, 0.5);
}
.ys13 {
  background: rgba(0, 150, 120, 0.2);
}
.ys14 {
  background: mix(rgba(100, 50, 20, 0.5), rgba(0, 150, 120, 0.2));
}
.ys15 {
  background: hsl(90, 100%, 50%);
}
.ys16 {
  background: contrast(hsl(90, 100%, 50%), #000000, #ffffff, 100%);
}
/*编译成*/
body {
  c: #80e619;
  c: #80ff00;
}
div {
  width: 90px;
  height: 50px;
  font-size: 16px;
  text-align: center;
}
.ys1 {
  background: #80e619;
}
.ys2 {
  background: #80ff00;
}
.ys3 {
  background: #80cc33;
}
.ys4 {
  background: #b3f075;
}
.ys5 {
  background: #4d8a0f;
}
.ys66 {
  background: rgba(128, 230, 25, 0.5);
}
.ys6 {
  background: #80e619;
}
.ys7 {
  background: rgba(128, 230, 25, 0.1);
}
.ys8 {
  background: #80e619;
}
.ys9 {
  background: rgba(128, 230, 25, 0.4);
}
.ys10 {
  background: #f2330d;
}
.ys11 {
  background: #f20d0d;
}
.ys12 {
  background: rgba(100, 50, 20, 0.5);
}
.ys13 {
  background: rgba(0, 150, 120, 0.2);
}
.ys14 {
  background: rgba(65, 85, 55, 0.35);
}
.ys15 {
  background: #80ff00;
}
.ys16 {
  background: #ffffff;
}
```

### 15.8 颜色值混合函数

- multiply()
  - 分别将两种颜色的红绿蓝（RGB）三种值做乘法运算，然后再除以 255，输出结果是更深的颜色。（注：对应 Photoshop 中的“变暗/正片叠底”）
- screen()
  - 与 multiply()函数效果相反，输出结果是更亮的颜色。（注：对应 Photoshop 中的“变亮/滤色”）
- overlay()
  - 结合 multiply()与 screen()两个函数的效果，令浅的颜色变得更浅，深的颜色变得更深。（注：对应 Photoshop 中的“叠加”）注意：输出结果由第一个颜色参数决定。
- softlight()
  - 与 overlay()函数效果相似，只是当纯黑色或纯白色作为参数时输出效果不会是纯黑色或纯白色。（注：对应 Photoshop 中的“柔光”）
- hardlight()
  - 与 overlay()函数效果相似，不过由第二个颜色参数决定输出颜色的亮度或黑度，而不是第一个颜色参数决定（注：对应 Photoshop 中的“强光/亮光/线性光/点光”）
- difference()
  - 从第一个颜色值中减去第二个（分别计算 RGB 三种颜色值），输出结果是更深的颜色（注：对应 Photoshop 中的“差值/排除”）
- exclusion()
  - 效果与 difference()函数效果相似，只是输出结果差别更小（lower contrast）（注：对应 Photoshop 中的“差值/排除”）
- average()
  - 分别对 RGB 的三种颜色值取平均值，然后输出结果
- negation()
  - 与 difference()函数效果相反，输出结果是更亮的颜色。请注意：效果相反不代表做加法运算

```less
body {
  c: hsl(90, 80%, 50%);
  c: saturate(hsl(90, 80%, 50%), 20%);
}
div {
  width: 90px;
  height: 50px;
  line-height: 50px;
  color: #fff;
  font-size: 16px;
  text-align: center;
}
//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: multiply(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: multiply(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: multiply(#ff6600,#fff);
//}

//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: screen(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: screen(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: screen(#ff6600,#fff);
//}

//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: overlay(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: overlay(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: overlay(#ff6600,#fff);
//}

//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: softlight(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: softlight(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: softlight(#ff6600,#fff);
//}

//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: hardlight(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: hardlight(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: hardlight(#ff6600,#fff);
//}

//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: difference(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: difference(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: difference(#ff6600,#fff);
//}
//
//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: exclusion(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: exclusion(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: exclusion(#ff6600,#fff);
//}
//
//.ys1{
//  background:#ff6600 ;
//}
//.ys2{
//  background: #000000;
//}
//.ys3{
//  background: average(#ff6600,#000000);
//}
//.ys4{
//  background:#ff6600 ;
//}
//.ys5{
//  background: #333;
//}
//.ys6{
//  background: average(#ff6600,#333);
//}
//.ys7{
//  background:#ff6600 ;
//}
//.ys8{
//  background: #ffffff;
//}
//.ys9{
//  background: average(#ff6600,#fff);
//}

.ys1 {
  background: #ff6600;
}
.ys2 {
  background: #000000;
}
.ys3 {
  background: negation(#ff6600, #000000);
}
.ys4 {
  background: #ff6600;
}
.ys5 {
  background: #333;
}
.ys6 {
  background: negation(#ff6600, #333);
}
.ys7 {
  background: #ff6600;
}
.ys8 {
  background: #ffffff;
}
.ys9 {
  background: negation(#ff6600, #fff);
}
/*编译成*/
body {
  c: #80e619;
  c: #80ff00;
}
div {
  width: 90px;
  height: 50px;
  line-height: 50px;
  color: #fff;
  font-size: 16px;
  text-align: center;
}
.ys1 {
  background: #ff6600;
}
.ys2 {
  background: #000000;
}
.ys3 {
  background: #ff6600;
}
.ys4 {
  background: #ff6600;
}
.ys5 {
  background: #333;
}
.ys6 {
  background: #cc9933;
}
.ys7 {
  background: #ff6600;
}
.ys8 {
  background: #ffffff;
}
.ys9 {
  background: #0099ff;
}
```

---
title: Sass学习笔记
lang: 'zh-CN'
description: 'LGD.HuaFEEng博客网站-技术分类-CSS专题-Sass学习笔记'
meta:
  - name: keywords
  - content: CSS,Sass,Scss,学习,笔记,前端
---

[[TOC]]

## 1、工具与安装

### 1.1 工具

- （IDE）WebStorm：http://www.jetbrains.com/webstorm/
- （Text Editor）Sublime Text：http://www.sublimetext.com/

### 1.2 如何安装 Sublime Text Plugins:

- 安装 Package Control：https://packagecontrol.io/
- Ctrl+` 打开控制台，执行：

```
import urllib2,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler()) ); by = urllib2.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); open( os.path.join( ipp, pf), 'wb' ).write(by) if dh == h else None; print('Error validating download (got %s instead of %s), please try manual install' % (dh, h) if dh != h else 'Please restart Sublime Text to finish installation')
```

- Ctrl+Shift+P 输入 Pci 打开 Package Control Install，然后安装 Sass 和 Sass Build

## 2、Sass 与 Compass

### 2.1 为什么需要 css 预处理器

- 使用变量
- 自动转化 RGBA 颜色值
- 浏览器前缀
- 嵌套规则
- media query 更简单
- 自动压缩 css

### 2.2 什么是 Sass

- https://sass-lang.com/

### 2.3 Sass 与 CSS

- CSS 并不能算是一门真正意义上的“编程”语言，无法完成嵌套、继承、设置变量等工作
- 解决 CSS 的不足，开发者想到了编写一种对 css 进行预处理的“中间语言”

### 2.4 .sass 与.scss

- 最初它是为了配合 haml 而设计，所以和 haml 有着一样的缩进风格
- 从第三代开始，保留缩进式风格，完全向下兼容普通的 css 代码

### 2.5 什么是 Compass

- http://compass-style.org/
- Compass is an open-source CSS Authoring Framework.
- Compass 是 Sass 的工具库
- 在 Sass 的基础上封装了一系列有用的模块和模板，补充 Sass 的功能
- Compass 与 Sass 的关系类似于 jQuery 与 JavaScript 的关系
- 模块
  - reset 模块
  - css3 模块
  - layout 模块
  - typography 模块
  - utilities 模块

### 2.6 Sass 与 Compass 的安装

- https://sass-lang.com/install
- http://compass-style.org/install/
- Ruby
  - https://www.ruby-lang.org/en/
  - https://rubyinstaller.org/
- 依赖 Ruby，所以要先安装 Ruby
- Windows 下通过 RubyInstallers 来安装
- gem sources [-r | -a | -u][https://gems.ruby-china.com | http://ruby.taobao.org]
- 安装 Compass： gem install compass

## 3、Sass、Less 与 Stylus

### 3.1 官网

- https://sass-lang.com/
- http://lesscss.org/
- http://stylus-lang.com/

### 3.2 安装

- Sass 需要安装 Ruby，然后通过 gem 安装
- Less 有两种安装方式
  - 客户端：引入 less.js，然后就可以直接使用.less 文件
  ```html
  <link rel="stylesheet/less" type="text/css" href="a.less" />
  ```
  - 服务器：先安装 node，然后 npm 安装 less
- Stylus 的安装类似于 Less 的服务端安装

### 3.3 语法

- 都支持多行注释与单行注释
- .sass 缩进
- .scss 兼容 css 写法
- .less 兼容 css 写法
- .styl

  ```stylus
  h1 {
    color: red;
  }

  h1
    color: red;

  h1
    color red
  ```

  - 三种语法可混用

- 变量定义
  - .sass \$color: red
  - .scss \$color: red;
  - .less @color: red;
  - .styl \$color: red; color: red;
- 嵌套
- 混入
  - .scss @mixin alert($color: blue){color: $color;}
  - .less .alert(@color: blue){color: @color;}
  - .styl alert($color = blue){color: $color;}
- 继承
  - .scss
    ```scss
    .block {
      margin: 10px;
    }
    p {
      @extend .block;
    }
    ```
  - .less
    ```less
    .block {
      margin: 10px;
    }
    p {
      .block;
    }
    ```
  - .styl 与.scss 一样

## 四、Sass 语法

### 4.1 Sass 基础

- 创建工程

  - 使用 Sass 创建
    - 新建文件夹，书写 sass 文件
    - 使用 sass 命令
  - 使用 Compass 创建
    - compass create [projectName]
    - compass create --bare --sass-dir "sass" --css-dir "css" --images-dir "img" --javascript-dir "js"
    - 编译 Sass sass [sassFile][cssfile]
    - 监视 Sass 文件 sass --watch [sassFile]:[cssFile]
    - 监视文件夹 sass --watch [sassFolder]:[cssFolder]
    - 编译 Sass compass compile
      - 此命令为 Compass 命令
      - 此命令只会编译有变化的 Sass 文件，如果要强制编译所有的 Sass 文件，可以使用： compass compile --force
      - 一般在 Compass 项目根目录执行
      - Usage: compass compile [path/to/project][path/to/project/src/file.sass ...] [options]
      - 显示帮助信息 compass compile --help
    - 监视文件夹 compass watch
    - 四种输出风格
      - --style [nested|expanded|compact|compressed]
      - nested
        ```scss
        body {
          padding: 0;
        }
        ```
      - expanded
        ```scss
        body {
          padding: 0;
        }
        ```
      - compact
        ```scss
        body {
          padding: 0;
        }
        ```
      - compressed
        ```scss
        body {
          padding: 0;
        }
        ```

- 使用命令行

- 理解 config.rb

  - environment = :development
  - output_style = (environment == :development) ? :expanded : :compressed

- Sass 的注释语法

  - // 注释 不会生成到文件中
  - /\*_/ 会生成到文件中（compressed 模式不会生成到文件中）（如果 compressed 模式也要生成，用/_!\*/ 重要注释）
  - 中文注释
    - engine.rb 添加以下代码
    - Encoding.default_external = Encoding.find('utf-8')
    - engine.rb 文件路径（根据自己的安装路径）：E:\Program Files\Ruby26-x64\lib\ruby\gems\2.6.0\gems\sass-3.4.25\lib\sass

- Sass 变量

  - 局部变量 与{}作用域有关
  - 全局变量 \$color: red !global; 可在任意地方定义
  - 变量默认值 \$fontSize: 12px !default; 先解析默认值
  - 多值变量
    - $paddings: 5px 10px 5px 10px;    padding-left: nth($paddings, 1) (索引值是 1 开始)
    - $maps: (color: red, borderColor: blue);    background-color: map-get($maps, color);
  - 变量特殊用法
    - 变量用在熟悉或者选择器上，使用#{变量名}
    ```scss
    $className: main;
    .#{$className} {
      width: 50px;
    }
    ```
    - 变量中 - 与 \_ 不影响。$text-info: lightgreen; 与 $text_info: lightgreen; 一样

- 样式导入

  - 部分文件
    - \_part.scss 以下划线开头，不会被编译，专门为导入而编写的 sass 文件，不会被生成对应的独立文件
    - 局部文件可以被多个不同的文件引用，可以和 默认变量值 配合
    - @import "part";
  - 嵌套导入
  - 原生 CSS 导入
    - @import "css.css"; 文件名字以.css 结尾
    - @import "http://sss/xx"; 是一个 URL 地址
    - @import url(css.css); 文件名字是 CSS 中的 url()值

- 嵌套

  - 选择器嵌套
  - 属性嵌套

  ```scss
  footer {
    background: {
      color: red;
      size: 100% 50%;
    }
  }
  ```

  - &--引用父选择器
  - @at-root，跳出嵌套
    - 默认@at-root 只会跳出选择器嵌套，而不能跳出@media 或@support，如果要跳出这两种，则需使用@at-root（without: media），@at-root(without: support)。这个语法的关键词有四个：all（所有），rule（常规 css），media（media），support（support，因为@support 目前还无法广泛使用，所以在此不表）。我们默认的@at-root 其实就是@at-root(without: rule)。
    ```scss
    @media screen and (max-width: 600px) {
      @at-root (without: media rule) {
        .container {
          background: lightgreen;
        }
      }
    }
    ```
  - @at-root 与 &

  ```scss
  .text-info {
    color: red;
    @at-root nav & {
      color: blue;
    }
  }
  ```

- 继承

  - 简单继承
  - 多继承

  ```scss
  .alert {
    background-color: #ffeedd;
  }
  .small {
    font-size: 12px;
  }
  /*第一种*/
  .alert-info {
    @extend .alert;
    @extend .small;
    color: red;
  }
  /*第二种*/
  .alert-info {
    @extend .alert, .small;
    color: red;
  }
  ```

  - 链型继承
  - 继承的局限性
    - 不支持：包含选择器（.one .two）或者相邻兄弟选择器（.one + .two）
    - 如果继承的元素是 a，恰巧这个元素 a 又有 hover 状态的形式，那么 hover 状态也会被继承
  - 继承交叉合并
    - 没有在同一个父级下，会产生交叉合并的编译结果
    ```scss
    .one a {
      font-weight: bold;
    }
    .two .three {
      @extend a;
    }
    ```
    ```scss
    a span {
      font-weight: blod;
    }
    div .content {
      @extend span;
    }
    /*! 编译成*/
    a span,
    a div .content,
    div a .content {
      font-weight: blod;
    }
    ```
  - 继承的作用域

    - 继承在指令中是有作用域问题的，继承是无法使用在指令如（@media）之外的选择器继承的，要是继承就只能写在指令中（内外也不能重名）

- 占位选择器%

  - 不会单独生成到 css 中去
  - 可以定义公用的样式
  - 优势在于：如果不调用则不会有任何多余的 css 文件，避免了以前在一些基础的文件中预定义了很多基础的样式，然后实际应用中不管是否使用了@extend 去继承相应的样式，都会解析出来所有的样式。占位选择器以%标识定义，通过@extend 调用

  ```scss
  %alert {
    background-color: #ffeedd;
  }
  .alert-info {
    @extend %alert;
    color: red;
  }
  ```

- 换肤
  - disabled link
  ```html
  <link rel="stylesheet" href="skin.css" disabled />
  ```
  - 给 body 设置 class，使用嵌套语法

### 4.2 Sass 进阶

- 数据类型

  - Number
    - https://sass-lang.com/documentation/values/numbers
    ```
    $n1: 1.2;
    $n2: 12;
    $n3: 12px;
    ```
  - String
    - https://sass-lang.com/documentation/values/strings
    ```
    $s1: container;
    $s2: 'container';
    $s3: "container";
    ```
  - List

    - https://sass-lang.com/documentation/values/lists

  - Map

    - https://sass-lang.com/documentation/values/maps

  - Color
    - https://sass-lang.com/documentation/values/colors
    ```scss
    $c1: blue;
    $c2: #fff;
    $c3: rgba(255, 255, 0, 0.5);
    ```
  - Boolean
    - https://sass-lang.com/documentation/values/booleans
    ```scss
    $bt: true;
    $bf: false;
    ```
  - Null
    - https://sass-lang.com/documentation/values/null
    ```scss
    $null: null;
    ```

- 变量操作

  - == , != 支持所有数据类型
  - < , > , <= , >= 仅仅支持数字类型
  - '+' , '-' , '\*' , '/' , '%'
  - 插值
    ```scss
    $version: 3;
    p:before {
      content: 'Hello, Sass #{$version}';
    }
    ```
  - 其他注意
    ```scss
    /*原生css规则，不计算*/
    p {
      font: 20px / 10px;
    }
    /*强制运算*/
    p {
      height: (100px / 2);
    }
    /*报错*/
    p {
      height: (100 / 2px);
    }
    ```

- Mixin

  - 简单扩展

  ```scss
  @mixin cont {
    color: red;
  }
  body {
    @include cont;
  }
  /*带参数*/
  @mixin cont($color: red, $fontSize: 14px) {
    color: $color;
    font-size: $fontSize;
  }
  body {
    @include cont($fontSize: 18px);
  }
  ```

  - 传递多值参数

    ```scss
    @mixin box-shadow($shadow...) {
      -moz-box-shadow: $shadow;
      -webkit-box-shadow: $shadow;
      box-shadow: $shadow;
    }
    .shadows {
      @include box-shadow(0px 4px 4px #555, 2px 6px 10px #6dd3ee);
    }
    ```

  - 传递内容

  ```scss
  @mixin style-for-iphone {
    @media only screen and (min-device-width: 320px) and (max-device-width: 568px) {
      @content;
    }
  }
  @include style-for-iphone {
    font-size: 12px;
  }
  ```

- 内置函数

  - https://sass.bootcss.com/documentation/modules

- 自定义函数

  ```scss
  @function double($width) {
    @return $width * 2;
  }
  p {
    width: double(5px);
  }
  ```

- @debug、@warn、@error
  - 控制台有输出
  ```scss
  @debug 'This is a debug test';
  @warn 'This is a warn test';
  @error 'This is a error test';
  ```

### 4.3 Sass 高级

- 条件控制

  ```scss
  @function getzIndex($layer: default) {
    $zindexMap: (
      default: 1,
      modal: 1000,
      dropdown: 500
    );
    $zindex: 0;
    @if map-has-key($zindexMap, $layer) {
      $zindex: map-get($zindexMap, $layer);
    } @else {
      $zindex: 1;
    }
    @return $zindex;
  }
  @debug getzIndex('m');
  ```

- @if

  - 三目运算

    ```scss
    $screenWidth: 800;
    body {
      color: if($screenWidth > 768, blue, red);
    }
    ```

  - @if...@else if...@else
    ```scss
    $screenWidth: 800;
    @if $screenWidth > 768 {
      body {
        color: red;
      }
    } @else if $screenWidth > 400 {
      span {
        color: green;
      }
    } @else {
      p {
        color: blue;
      }
    }
    ```

- @for

  ```scss
  /*从1到5(包含5)*/
  @for $i from 1 through 5 {
    .span#{$i} {
      width: 20% * $i;
    }
  }
  /*从1到5(不包含5)*/
  @for $i from 1 to 5 {
    .span#{$i} {
      width: 20% * $i;
    }
  }
  ```

- @while

  ```scss
  $j: 6;
  @while $j > 0 {
    .p#{$j} {
      width: 20% * $j;
    }
    $j: $j - 3;
  }
  ```

- @each

  - 常规遍历

    ```scss
    $k: 1;
    @each $c in blue, red, green {
      .div#{$k} {
        color: $c;
      }
      $k: $k + 1;
    }
    ```

  - 遍历 List

    ```scss
    @each $key, $color in (default, blue), (info, green), (danger, red) {
      .text-#{$key} {
        color: $color;
      }
    }
    ```

  - 遍历 Map
    ```scss
    @each $key, $value in (default: blue, info: green, danger: red) {
      .label-#{$key} {
        color: $value;
      }
    }
    ```

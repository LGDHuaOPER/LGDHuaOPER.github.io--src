---
title: 如何管理多个SSH-Key并可进行连接
---

## 引言

​ 有时候我们会遇到这样的场景：我们有一台电脑，在公司用于上班，在家里用于学习与写作。在公司上班，代码需要提交到指定的代码仓库，并且有些是 IP 地址直连；在家学习与写作时，需要将输出物上传到 github 等开源仓库托管以便学习与交流。这个时候一个 SSH Key 就不够了，因此为了满足这种情况还需要增加多个 SSH Key。
​ 本文以管理两个 SSH Key 举例，管理多个 SSH Key 原理类似。

## 1.生成第一个 SSH Key

​ 公司项目代码需要提交到 **gerrit** ，我们来生成第一个 SSH Key 用于提交代码至 gerrit。

​ 在 git bash 里输入以下命令：

```
$ ssh-keygen -t rsa -C"youremail@yourcompany.com"
```

​ 其中 -t 是指定密钥的类型（The type of the key to generate），-C 是用于识别这个密钥的注释（comment to identify the key），所以 youremail@yourcompany.com 可以填写任意内容，个性化一点就好哒。

​ 一路回车，这样就能使用 ssh 生成第 1 个 key 了，默认会在根目录（windows 下是：C:\Users\LGD.HuaFEEng\\.ssh）下生成 id_rsa, id_rsa.pub 2 个文件，即公钥和私钥（LGD.HuaFEEng 是我的用户名）。

## 2.生成第二个 SSH Key

同样，用 ssh-keygen 命令来生成第二个 SSH Key，此时不要一路回车，而是要为文件指定一个名字，例如：id_rsa_github，回车，完成后会生成 id_rsa_github 与 id_rsa_github.pub 两个文件。

​ 最后生成两个 key 的结果如图所示：

![生成两个key的结果](~@static/tech/other/202002252336.png)

## 3.修改配置文件

```
  # gerrit
  Host [gerritExampleHost]
    HostName [gerritExampleHostName]
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa
    User shiconghua
    Port [gerritExamplePort]

  # github
  Host github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_github
```

​ 其中 Host 字段任意填写，标志出区别就好，HostName 字段需要填写公司 gerrit 地址，如何去找呢？在我们项目根目录下的 .git/config 里，如图

![](~@static/tech/other/202002252345.png)

​shiconghua 是我的 gerrit 用户名，所以是取@之后端口号之前的地址，然后配置里的 Port 字段就填写这个数字端口（默认 22）。

## 4.将私钥添加到 ssh-agent

为什么要做这一步？

ssh-add 命令是把专用密钥添加到 ssh-agent 的高速缓存中

​ 我们依次在 git bash 里执行

```
$ ssh-agent bash
$ ssh-add ~/.ssh/id_rsa
$ ssh-add ~/.ssh/id_rsa_github
```

​ 然后可以执行 ssh-add -l 查看。

## 5.设置 SSH keys

​ 依次将公钥放到 gerrit 与 github，这里以 github 为例，Setting/SSH and GPG keys，点击 New SSH key，复制公钥内容，保存。

## 6.测试连接

​ 我们可以用 ssh 来测试连接。

![测试连接gerrit](~@static/tech/other/202002252346.png)

​ 可以看到显示了我们配置的用户名，并且显示了 successfully，连接成功！

![测试连接github](~@static/tech/other/202002252347.png)

​ 同样，我们看到 github 也连接成功！

注意：_mac 上与 windows 类似，最主要的是注意文件路径。_

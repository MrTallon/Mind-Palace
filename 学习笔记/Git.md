# Git相关讲解

[TOC]



## 前提

默认已安装jdk及maven环境和git工具

环境变量均已配好。

默认安装idea，配置文件可使用我的GitHub上传

[小乌龟](https://www.cnblogs.com/java-maowei/p/5950930.html)

[idea-git](https://www.cnblogs.com/java-maowei/p/5950930.html)

## Git

在软件开发过程，每天都会产生新的代码，代码合并的过程中可能会出现如下问题：

- 代码被覆盖或丢失
- 代码写的不理想希望还原之前的版本
- 希望知道与之前版本的差别
- 是谁修改了代码以及为什么修改
- 发版时希望分成不同的版本(测试版、发行版等)

因此，我们希望有一种机制，能够帮助我们：

- 可以随时回滚到之前的版本
- 协同开发时不会覆盖别人的代码
- 留下修改记录，以便随时查看
- 发版时可以方便的管理不同的版本

### 什么是版本控制系统

一个标准的版本控制系统 Version Control System (VCS)，通常需要有以下功能：

- 能够创建 Repository (仓库)，用来保存代码
- 协同开发时方便将代码分发给团队成员
- 记录每次修改代码的内容、时间、原因等信息
- 能够创建 Branch (分支)，可以根据不同的场景进行开发
- 能够创建 Tag (标签)，建立项目里程碑

![git02](/Users/yangbo/Desktop/git02.jpg)

## GitHub

**目的**：借助GitHub托管代码

### 单词概念：

**仓库（Repository）**

基本就是一个项目一个仓库了

**收藏（Star）**

我感觉有点像朋友圈点赞的意思，

一个项目能有100个star感觉就很强。

你可以在自己的收藏列表查看已收藏的项目。

**复制克隆项目（Fork）**

大意就是你想把别人的项目拿了学习或使用，

直接从别人的仓库复制了一份到自己仓库，

可以随便修改。

（本质上相当于你在原作者项目拉下来一个分支，不会影响原项目的代码与结构）

**发起请求（Pull Request）**

基于Fork，你修改完感觉8⃣️错，

可以使用这个功能将自己代码发给原作者，

如果作者也觉着8⃣️错并且测试完没问题，就会提交到主分支，

你也算是为开源项目做贡献了。

**关注（Watch）**

关注之后如果这个项目有任何更新你会第一时间收到通知提醒。

**事物卡片（Issue）**

🐂人在网上发了一个项目，

但是代码写的有些小问题，比如有小bug或功能不不合理，

你可以给原作者提Issue，他看到之后就会修改bug并关闭Issue



> 快捷键：
>
> k ： 在项目下快速搜索文件



https://pages.github.com/

**搭建个人主页**

1.新建仓库（用户名.github.io）

2.在仓库下新建index.html的文件

https://mrtallon.github.io/



**为项目新建主页**

直接新建主分支。

1.master分支下新建index.html

2.settings-》GitHub Pages 下的source选择master并保存

https://mrtallon.github.io/TestJekins/

选择模板



### Idea篇

我暂时没研究怎么把项目上传到一个已存在的仓库，

我用的是从GitHub拉取项目下来到Idea或者直接把代码提交到新建的仓库。

容我一会百度一下，就不在课堂浪费时间了。





[idea->github](https://www.cnblogs.com/jinjiyese153/p/6796668.html)



## 工作流

代码管理的工作流程和方式

所有的开发工作必须是在develop分支下执行

master主干代码不能被污染



### 中央集中式



![git003](/Users/yangbo/Desktop/git003.png)

### GitFlow

通过为功能开发、发布准备和维护分配独立的分支，让发布迭代过程更流畅。

严格的分支模型也为大型项目提供了一些非常必要的结构。

在开发过程中可以很简单地加上功能分支，用来鼓励开发者之间协作和简化交流。



![git006](/Users/yangbo/Desktop/git006.png)

#### 历史分支

相对使用仅有的一个 master 分支，GitFlow 工作流使用2个分支来记录项目的历史。master 分支存储了正式发布的历史，而 develop 分支作为功能的集成分支。这样也方便 master 分支上的所有提交分配一个版本号。

![git007](/Users/yangbo/Desktop/git007.png)

#### 功能分支

每个新功能位于一个自己的分支，这样可以 push 到中央仓库以备份和协作。但功能分支不是从 master 分支上拉出新分支，而是使用 develop 分支作为父分支。当新功能完成时，合并回 develop 分支。新功能提交应该从不直接与 master 分支交互。



![git008](/Users/yangbo/Desktop/git008.png)



#### 发布分支

![git009](/Users/yangbo/Desktop/git009.png)

#### 维护分支

![git010](/Users/yangbo/Desktop/git010.png)





v1.0.0->v1.0.1;	热修复。

v1.0.0->v1.1.0;	新增功能

到了这里，但愿你对集中式工作流、功能分支工作流和 GitFlow 工作流已经感觉很舒适了。你应该也牢固的掌握了本地仓库的潜能，push/pull 模式和 Git 健壮的分支和合并模型。

记住，这里演示的工作流只是可能用法的例子，而不是在实际工作中使用 Git 不可违逆的条例。所以不要畏惧按自己需要对工作流的用法做取舍。不变的目标就是让 Git 为你所用。



演示：

小红：基于master拉取项目

创建develop开发分支

切换开发分支并推送远程（模块组长）

（你的开发项目应该是在feature+模块名的分支，人少，实在没必要了，我直接默认每个人都在develop开发）

新建文件并上传dep

小明：

拉取master，切换develop，查看新文件，并新增功能然后上传







### Forking



![git005](/Users/yangbo/Desktop/git005.png)











---



几种工作流是作为方案指导而不是条例规定
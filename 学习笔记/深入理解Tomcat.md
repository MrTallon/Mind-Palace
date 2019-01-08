# 探索三脚猫

![img](https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2864077756,2277292526&fm=26&gp=0.jpg)

[TOC]

## 前言

Tomcat隶属于Apache基金会，是开源的轻量级Web应用服务器，使用非常广泛。server.xml是Tomcat中最重要的配置文件，server.xml的每一个元素都对应了Tomcat中的一个组件；通过对xml文件中元素的配置，可以实现对Tomcat中各个组件的控制。因此，学习server.xml文件的配置，对于了解和使用Tomcat至关重要。

> 说明：由于server.xml文件中元素与Tomcat中组件的对应关系，后文中为了描述方便，“元素”和“组件”的使用不严格区分。

## 一：server.xml配置实例



```xml
<?xml version="1.0" encoding="UTF-8"?>

<Server port="8005" shutdown="SHUTDOWN">
  <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
  <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
  <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
  <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
  <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />
  <GlobalNamingResources>
    <Resource name="UserDatabase" auth="Container"
              type="org.apache.catalina.UserDatabase"
              description="User database that can be updated and saved"
              factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
              pathname="conf/tomcat-users.xml" />
  </GlobalNamingResources>
  <Service name="Catalina">
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
    <Engine name="Catalina" defaultHost="localhost">
      <Realm className="org.apache.catalina.realm.LockOutRealm">
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
               resourceName="UserDatabase"/>
      </Realm>
      <Host name="localhost"  appBase="webapps"
            unpackWARs="true" autoDeploy="true">
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log" suffix=".txt"
               pattern="%h %l %u %t &quot;%r&quot; %s %b" />
      </Host>
    </Engine>
  </Service>
</Server>
```



## 二：server.xml元素分类和整体结构

### 1.整体结构(核心组件)

```xml
<Server>
	<Connector/>
	<Connector/>
	<Engine>
		<Host>
			<Context/>
		</Host>
	<Engine>
</Server>
```

### 2.元素分类

#### （1）顶层元素：<Server>和<Service>

<Server>元素是整个配置文件的根元素，<Service>元素则代表一个Engine元素以及一组与之相连的Connector元素。

#### （2）连接器：<Connector>

<Connector>代表了外部客户端发送请求到特定Service的接口；同时也是外部客户端从特定Service接收响应的接口。

#### （3）容器：<Engine><Host><Context>

容器的功能是处理Connector接收进来的请求，并产生相应的响应。Engine、Host和Context都是容器，但它们不是平行的关系，而是父子关系：Engine包含Host，Host包含Context。一个Engine组件可以处理Service中的所有请求，一个Host组件可以处理发向一个特定虚拟主机的所有请求，一个Context组件可以处理一个特定Web应用的所有请求。

#### （4）内嵌组件：可以内嵌到容器的组件

实际上，Server，Service，Connector，Engine，Host和Context都是最重要的核心的Tomcat组件，其他皆可归为内嵌组件。



## 三：核心组件

### 1.Server

Server元素在最顶层，代表整个Tomcat容器，因此它必须是server.xml中唯一一个最外层的元素。一个Server元素中可以有一个或多个Service元素。

在第一部分的例子中，在最外层有一个<Server>元素，shutdown属性表示关闭Server的指令；port属性表示Server接收shutdown指令的端口号，设为-1可以禁掉该端口。

Server的主要任务，就是提供一个接口让客户端能够访问到这个Service集合，同时维护它所包含的所有的Service的声明周期，包括如何初始化、如何结束服务、如何找到客户端要访问的Service。

### 2.Service

Service的作用，是在Connector和Engine外面包了一层，把它们组装在一起，对外提供服务。一个Service可以包含多个Connector，但是只能包含一个Engine；其中Connector的作用是从客户端接收请求，Engine的作用是处理接收进来的请求。

在第一部分的例子中，Server中包含一个名称为“Catalina”的Service。实际上，Tomcat可以提供多个Service，不同的Service监听不同的端口。

### 3.Connector

Connector的主要功能，是接收连接请求，创建Request和Response对象用于和请求端交换数据；然后分配线程让Engine来处理这个请求，并把产生的Request和Response对象传给Engine。

通过配置Connector，可以控制请求Service的协议及端口号。在第一部分的例子中，Service包含两个Connector：

```xml
<Connector port="8080" protocol="HTTP/1.1"connectionTimeout="20000" 
           redirectPort="8443" />
<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
```

（1）通过配置第1个Connector，客户端可以通过8080端口号使用http协议访问Tomcat。其中，protocol属性规定了请求的协议，port规定了请求的端口号，redirectPort表示当强制要求https而请求是http时，重定向至端口号为8443的Connector，connectionTimeout表示连接的超时时间。[点此查看](http://mp.weixin.qq.com/s?__biz=MzI3ODcxMzQzMw==&mid=2247484381&idx=1&sn=f6919853976da79e52602589ec164a15&chksm=eb5386ebdc240ffd9d9f0b869c2ecad755a8d1f5a78115da40634ce87e906251c919c8bb32cf&scene=21#wechat_redirect)一分钟配置tomcat的https教程。

在这个例子中，Tomcat监听HTTP请求，使用的是8080端口，而不是正式的80端口；实际上，在正式的生产环境中，Tomcat也常常监听8080端口，而不是80端口。这是因为在生产环境中，很少将Tomcat直接对外开放接收请求，而是在Tomcat和客户端之间加一层代理服务器(如nginx)，用于请求的转发、负载均衡、处理静态文件等；通过代理服务器访问Tomcat时，是在局域网中，因此一般仍使用8080端口。

（2）通过配置第2个Connector，客户端可以通过8009端口号使用AJP协议访问Tomcat。AJP协议负责和其他的HTTP服务器(如Apache)建立连接；在把Tomcat与其他HTTP服务器集成时，就需要用到这个连接器。之所以使用Tomcat和其他服务器集成，是因为Tomcat可以用作Servlet/JSP容器，但是对静态资源的处理速度较慢，不如Apache和IIS等HTTP服务器；因此常常将Tomcat与Apache等集成，前者作Servlet容器，后者处理静态资源，而AJP协议便负责Tomcat和Apache的连接。Tomcat与Apache等集成的原理如下图。

![image-20181216004743673](/Users/yangbo/Library/Application Support/typora-user-images/image-20181216004743673.png)

### 4.Engine

Engine组件在Service组件中有且只有一个；Engine是Service组件中的请求处理组件。Engine组件从一个或多个Connector中接收请求并处理，并将完成的响应返回给Connector，最终传递给客户端。

前面已经提到过，Engine、Host和Context都是容器，但它们不是平行的关系，而是父子关系：Engine包含Host，Host包含Context。

```xml
<Engine name="Catalina" defaultHost="localhost">
```

其中，name属性用于日志和错误信息，在整个Server中应该唯一。defaultHost属性指定了默认的host名称，当发往本机的请求指定的host名称不存在时，一律使用defaultHost指定的host进行处理；因此，defaultHost的值，必须与Engine中的一个Host组件的name属性值匹配。

### 5.Host

#### （1）https://mp.weixin.qq.com/s/OzwT94xY6wmeRZqyMCbN2g

#### （2）

#### （3）



### 6.Context

#### （1）

#### （2）











## 四：核心组件的关联







## 五：其他组件

https://mp.weixin.qq.com/s/OzwT94xY6wmeRZqyMCbN2g

https://mp.weixin.qq.com/s/2wioHX9zW7bCdxCMmkszPg




















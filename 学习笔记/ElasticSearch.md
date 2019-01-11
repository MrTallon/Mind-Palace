# ES学习笔记

![image-20181211232012534](/https://github.com/MrTallon/Mind-Palace/blob/master/img/es01.png)



![https://github.com/MrTallon/Mind-Palace/blob/master/img/es01.png](https://github.com/MrTallon/Mind-Palace/blob/master/img/es01.png)



![test](https://github.com/MrTallon/Mind-Palace/blob/master/img/es01.png)

[TOC]



## 简述

ElasticSearch是一个基于Lucene的搜索服务器，

提供一个分布式多用户能力的全文搜索引擎。

基于Restful风格接口，实时性好，低延迟，便于扩展。





#### 1.安装

官网下载elasticsearch，kibana，x-pack并解压

#### 2.运行

##### 1.安装ES

```
cd elasticsearch-6.5.2 
./bin/elasticsearch
```

![image-20181212120442869](/Users/yangbo/Desktop/es02.png)

##### 2.安装x-pack

```
./bin/elasticsearch-plugin install file:///Users/yangbo/Downloads/x-pack-6.2.4.zip 

./bin/elasticsearch-plugin install x-pack
```

x-pack目前只支持6.2之前的ES，本地的6.5是不支持的

##### 3.修改kibana参数

config/kibana.yml

```xml
elasticsearch.username: "tallon"
elasticsearch.password: "123456"
```

启动kibana

```
./bin/kibana
```



#### 3.查看配置

http://localhost:9200/_cat













#### 插件

![image-20181211232819413](/Users/yangbo/Desktop/es03.png)













## SpringBoot整合ES

docker启动

```
docker run -e ES_JAVA_OPTS="-Xms256m -Xmx256m" -d -p 9200:9200 -p 9300:9300 --name ES00 5acf0e8da90b
```

Spring data elastic search 引用的是3.1.2

![image-20181212173906892](/Users/yangbo/Library/Application Support/typora-user-images/image-20181212173906892.png)

理论上属于版本不适配，但是却能运行，奇怪。

虽然项目可以启动，但是往es中插入数据时报错，

使用本地启动的6.5.2版本则可以储存。



![image-20181213124746528](/Users/yangbo/Desktop/es04.png)

##### 两种用法

1.ElasticSearchRepository

自定义查询方法

https://docs.spring.io/spring-data/elasticsearch/docs/3.1.3.RELEASE/reference/html/#elasticsearch.query-methods
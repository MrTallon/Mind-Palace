# Springboot（2.1.0）练习

---

[TOC]

------



## 前言

尚硅谷学习笔记及部分拓展



## MybatisPlus

###  ActiveRecord

活动记录，一种领域模型。

特点是一个模型类对应数据库中的一个表，而模型的一个实例对应表中的一行记录。

我使用了MP自动生成代码，base继承Model，。

直接实例化对象调用方法。



**mapper无法注入问题**
mapper路径指引

```yaml
mybatis-plus:
  mapper-locations:
    - classpath:mapper/*.xml
```







## 模版引擎（Thymeleaf）

### 引入静态资源

SpringBoot 2.0 之前默认 static 就是资源路径 

```java
@Override
public void addResourceHandlers(ResourceHandlerRegistry registry) {
	registry.addResourceHandler("/**")
	//将/static文件夹定为资源目录，需要根据实际更换
	.addResourceLocations("classpath:/static/");
}
```

### 首页

```java
@Override
protected void addViewControllers(ViewControllerRegistry registry) {
//        设置首页
    registry.addViewController("/").setViewName("login");
}
```





### 分页





### 跳转引入公共页面不一致

奇怪





## 国际化

[csdn链接](https://mp.csdn.net/mdeditor/80780143#)





## 日志管理

SpringBoot默认使用日志框架是logback，INFO级别输出到控制台。

SpringBoot的日志级别有7个：
TRACE,DEBUG,INFO,WARN,ERROR,FATAL,OFF

默认情况下，SpringBoot将日志输出到控制台，不会写入日志文件。

Logging.file或logging.path

⚠️二者不可同时使用，否则只生效logging.file



### 多环境日志输出











## 热部署

```xml
<!--热部署-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
	<optional>true</optional>
</dependency>
```



## 定时任务

Spring Boot对于Quartz的支持也很方便。

作为一款功能强大的调度器，

可以让程序在指定时间执行，

也可以按照某种频度执行。

配置文件：

```xml
<!--quartz-->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-quartz</artifactId>
</dependency>

```



测试类，继承QuartzJobBean：

```java
public class QuartzTest extends QuartzJobBean {
    /**
     * 执行定时任务
     * @param jobExecutionContext
     * @throws JobExecutionException
     */
    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        System.out.println("Quartz Task : " + System.currentTimeMillis());
    }
```



配置类：

```java
@Configuration
public class QuartzConfig {
    @Bean
	public JobDetail teatQuartzDetail() {
        return JobBuilder.newJob(QuartzTest.class).withIdentity("quartzTest").storeDurably().build();
    }
    
    @Bean
    public Trigger testQuartzTrigger() {
        SimpleScheduleBuilder scheduleBuilder = SimpleScheduleBuilder.simpleSchedule()
        	.withIntervalInSeconds(10)  //设置时间周期单位秒
            .repeatForever();
        return TriggerBuilder.newTrigger().forJob(teatQuartzDetail())
            .withIdentity("quartzTest")
            .withSchedule(scheduleBuilder)
            .build();
    }
}
```

> 以上只是Quartz入门练习,项目中肯定会有很多配置表

## 异步任务

对于发送邮箱的任务,不需要同步等待,直接异步执行减少时间

### 方法

1.启动类加注解:**EnableAsync**

2.Controller层加注解:**@Async**



## 邮件任务

```xml
<!--邮件-->
<dependency>
	<groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-mail</artifactId>
</dependency>
```

```yaml
mail:
    username: 352420160@qq.com
    password: zgqipqgdsfyacadh
    host: smtp.qq.com
    properties:
      mail.smtp.ssl.enable: true
```

```java
@Autowired
MailSender mailSender;
public void mail01() {
	SimpleMailMessage message = new SimpleMailMessage();
    //邮件设置
    message.setSubject("通知-今晚开会");
    message.setText("19:30会议室集合");
    message.setTo("1193323148@qq.com");
    message.setFrom("352420160@qq.com");
    mailSender.send(message);
}
```







## 导出数据





## 缓存







## ElasticSearch

docker 安装6.5.2版本ES

```
docker run -e ES_JAVA_OPTS="-Xms256m -Xmx256m" -d -p 9200:9200 -p 9300:9300 --name ES01 0a90480a0cff
```







## 安全:Spring Security



## 单点登录





## 监控管理



```xml
<!--监控管理-->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```



![image-20181213164222989](/Users/yangbo/Library/Application Support/typora-user-images/image-20181213164222989.png)



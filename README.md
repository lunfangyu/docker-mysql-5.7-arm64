# docker-mysql-5.7-arm64

This is a version of the MySQL 5.7 docker image that runs on ARM64. It uses Ubuntu 18.04 Bionic to take advantage of the prebuilt ARM64 MySQL 5.7 package that exists there: https://launchpad.net/ubuntu/bionic/arm64/mysql-server-5.7

Cloned from: https://github.com/docker-library/mysql/tree/bdf0905b75bc9f7d91cedd859476af8d7629e539/5.7

## MySQL57编译步骤（ARM64系统），需提前装好docker环境

1. 在ARM64系统上，下载Dockerfile和docker-entrypoint.sh 到本地目录(也可以根据实际需要自定义，这里是我的目录)：/container/dockerfile

2. 执行命令：`cd /container/dockerfile` 进入Dockerfile所在目录**（重要）**

   此步骤目的是，确保在Dockerfile所在目录中执行第3步的镜像构建命令，否则会报错：`COPY failed: file not found in build context or excluded by ……`

3. 执行命令：`docker build -f /container/dockerfile/Dockerfile -t lunfangyu/mysql57:arm64 .`

4. 等待执行完成，即可看到镜像
   
   

## 创建容器并运行

```shell
docker run -itd \
--restart=always \
--name=mysql \
-p 3306:3306 \
-v /etc/timezone:/etc/timezone:ro \
-v /etc/localtime:/etc/localtime:ro \
-v /container/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD="root" \
lunfangyu/mysql57:arm64
```

## 已知问题

虽然docker运行指令指定了root密码；但第一次创建容器时，root是无密码的。因此在容器初始化完成后，需要进入容器命令行中对root设置密码和开启远程访问

## 设置root用户密码并开启远程连接

可按以下步骤执行指令进行：

1. 连接容器终端命令行：`docker exec -it mysql bash`
2. root用户登录（空密码，直接回车即可登录）：`mysql -uroot -p`
3. 切换数据库：`use mysql;`
4. 查询用户信息：`select user, host from user;`
5. 更新root用户密码：`update user set authentication_string=password('root') where user='root';`
6. 开启root用户远程连接：`update user set host = '%' where user ='root';`
7. 刷新信息立即生效：`flush privileges;

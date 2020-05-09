# mysql备份及恢复

## docker hub mysql镜像说明

### Creating database dumps

Most of the normal tools will work, although their usage might be a little convoluted in some cases to ensure they have access to the `mysqld` server. A simple way to ensure this is to use `docker exec` and run the tool from the same container, similar to the following:

备份所有数据

```shell
$ docker exec some-mysql sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql
```

备份指定数据库

```shell
$ docker exec some-mysql sh -c 'exec mysqldump --databases db1 -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/db1.sql
```

### Restoring data from dump files

For restoring data. You can use `docker exec` command with `-i` flag, similar to the following:

```shell
$ docker exec -i some-mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < /some/path/on/your/host/all-databases.sql
```



## 单个数据库恢复

```shell
# 查看备份的数据库sql
[root@VM_0_9_centos sqlbackup]# ls
76base_20200508.sql  backup_database.sh  backup.log  clear_history_backup.sh  clear.log  pizza_20200508.sql

# 复制备份过的sql到mysql容器的根目录
[root@VM_0_9_centos sqlbackup]# docker cp ./76base_20200508.sql mysql_5.7:/

# 进入mysql容器
[root@VM_0_9_centos sqlbackup]# docker exec -it mysql_5.7 /bin/bash

# 登录msyql
root@3527bdeca151:/# mysql -uroot -proot

# 切换到要恢复的数据库
mysql> use 76base;
Database changed

# 恢复数据库
mysql> source /76base_20200508.sql

```



## 命令参数详解

### 1、备份命令

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --database 数据库名 > 文件名.sql

```shell
mysqldump -h 192.168.1.100 -p 3306 -uroot -ppassword --database cmdb > /data/backup/cmdb.sql
```



### 2、备份压缩

导出的数据有可能比较大，不好备份到远程，这时候就需要进行压缩

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --database 数据库名 | gzip > 文件名.sql.gz

```shell
mysqldump -h192.168.1.100 -p 3306 -uroot -ppassword --database cmdb | gzip > /data/backup/cmdb.sql.gz
```



### 3、备份同个库多个表

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --database 数据库名 表1 表2 .... > 文件名.sql

```shell
 mysqldump -h192.168.1.100 -p3306 -uroot -ppassword cmdb t1 t2 > /data/backup/cmdb_t1_t2.sql
```



### 4、同时备份多个库

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --databases 数据库名1 数据库名2 数据库名3 > 文件名.sql

```shell
mysqldump -h192.168.1.100 -uroot -ppassword --databases cmdb bbs blog > /data/backup/mutil_db.sql
```



### 5、备份实例上所有的数据库

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --all-databases > 文件名.sql

```shell
mysqldump -h192.168.1.100 -p3306 -uroot -ppassword --all-databases > /data/backup/all_db.sql
```



### 6、备份数据出带删除数据库或者表的sql备份

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --add-drop-table --add-drop-database 数据库名 > 文件名.sql

```shell
mysqldump -uroot -ppassword --add-drop-table --add-drop-database cmdb > /data/backup/all_db.sql
```



### 7、备份数据库结构，不备份数据

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --no-data 数据库名1 数据库名2 数据库名3 > 文件名.sql

```shell
mysqldump --no-data –databases db1 db2 cmdb > /data/backup/structure.sql
```
#/bin/bash

# 今天
vDate=`date +%Y%m%d`

# 昨天
yesterday=$(date -d "yesterday" +%Y%m%d)

# 删除昨天的备份
base="76base_$yesterday.sql"
echo "删除数据库备份："$base
rm -rf $base

base2="pizza_$yesterday.sql"
echo "删除数据库备份："$base2
rm -rf $base2


echo "成功"

#/bin/bash

vDate=`date +%Y%m%d`

echo $vDate

docker exec mysql_5.7 sh -c 'exec mysqldump -uroot -proot --databases 76base' > /sqlbackup/76base_"$vDate".sql
echo "备份数据库76base_$vDate";

docker exec mysql_5.7 sh -c 'exec mysqldump -uroot -proot --databases pizza' > /sqlbackup/pizza_"$vDate".sql
echo "备份数据库pizza_$vDate";

echo "成功"

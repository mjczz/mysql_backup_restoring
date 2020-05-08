## mysql数据库备份

## 清理昨天的备份数据

## crontab
```shell script
00 00 * * * /sqlbackup/clear_history_backup.sh >> /sqlbackup/clear.log
00 01 * * * /sqlbackup/backup_database.sh >> /sqlbackup/backup.log
```

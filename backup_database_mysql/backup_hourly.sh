#!/usr/bin/env bash


LOG_FILE="/home/backup/mysql-backup-hourly.log"

echo "" >> $LOG_FILE
echo "Mysql backup hourly started at: `date "+%F %T"`" >> $LOG_FILE

# Must be run as root user

if [ "$UID" -ne "0" ]
then
echo "[`date "+%F %T"`] Error: You must run this script as root!" >> $LOG_FILE
exit 67
fi
                                        
echo "Mysql backup hourly started with UID=$UID" >> $LOG_FILE
nice -n 19 rsync -rlzt /var/log/mysql root@server1:/common/BACKUP/mysql_binary_logs
echo "[`date "+%F %T"`] Mysql backup hourly completed" >> $LOG_FILE
              
              

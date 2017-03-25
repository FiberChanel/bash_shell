#!/usr/bin/env bash


LOG_FILE="/home/backup/mysql-backup-weekly.log"

echo "" >> $LOG_FILE
echo "Mysql backup weekly started at: `date "+%F %T"`" >> $LOG_FILE

# Must be run as root user

if [ "$UID" -ne "0" ]
then
echo "[`date "+%F %T"`] Error: You must run this script as root!" >> $LOG_FILE
exit 67
fi
                                        
echo "Mysql backup weekly started with UID=$UID" >> $LOG_FILE
datesuffix=`date "+%A"`
nice -n 19 mysqldump  --no-defaults --flush-logs --default-character-set=latin1 --skip-opt kvant > /tmp/mysql_full_backup/kvant.sql.$datesuffix;
nice -n 19 rsync --del -rlzt /tmp/mysql_full_backup root@server1:/common/BACKUP/mysql_binary_logs
echo "[`date "+%F %T"`] Mysql backup weekly completed" >> $LOG_FILE
              
              

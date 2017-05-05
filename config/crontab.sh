#!/bin/bash
span_day=30
home_dir=/var/www
my_user=testplus
my_password=testplus123
my_database=logtest
my_host=mysql

#clear screen_shots
find "$home_dir"/test-plus/public/system/screen_shots/. -mtime +21 -exec rm -rf {} \;

#count progress rate
mysql -u "$my_user" -p"$my_password" -h "$my_host" -e "call testlink.import_test_to_testplus"
curl http://127.0.0.1/import_data/refresh_testlink_data
curl -X POST "http://127.0.0.1/automation_progresses/dump" -d ''

#clear logfile
cd "$home_dir"/testplus-logserver/public/upload_data
find . -mtime +$span_day | while read filename
 do
  filename=${filename:2}
  echo "(rm -f $filename) and (delete from logs where file_name='$filename')"
  mysql -u "$my_user" -p"$my_password" -h "$my_host" -e "use $my_database; delete from logs where file_name='$filename'"
  rm -f $filename
 done







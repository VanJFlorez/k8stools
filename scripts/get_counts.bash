#!/bin/bash
echo USAGE
echo bash get_counts.bash hostname   dbname user   pass            cycles period
echo bash get_counts.bash 172.17.0.3 test   user   pass            30     1
echo bash get_counts.bash mongodb    dwh    admin  TW7jTV7QPn3wMjr 360    30
echo bash get_counts.bash localhost  dwh    admin  TW7jTV7QPn3wMjr 360    10
host=$1
dbname=$2
user=$3
pass=$4
cycles=$5
period=$6
counter=1
echo st. time: aprox. $(($5 * $6 / 3600))h
echo hostname: $host >> counts.txt
while [ $counter -le $cycles ]
do
  echo $counter / $cycles
  ((counter=counter+1))
  datetime=$(date +'%d-%m-%Y %H:%M:%S')
  result=$(eval "mongo $dbname --host $host -u $user --authenticationDatabase admin -p$pass --eval \"db.callsCount.count()\"")
  echo $result $datetime
  echo $result $datetime >> counts.txt
  sleep $period
done
echo "All done"

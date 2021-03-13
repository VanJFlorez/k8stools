#!/bin/bash
echo USAGE
echo bash get_counts.sh hostname   dbname user   pass            cycles period
echo bash get_counts.sh 172.17.0.3 test   user   pass            30     1
echo bash get_counts.sh mongodb    dwh    admin  TW7jTV7QPn3wMjr 360    30
echo 360 * 30s = 10 800s = 3h
host=$1
dbname=$2
user=$3
pass=$4
cycles=$5
period=$6
counter=1
echo hostname: $host >> counts.txt
while [ $counter -le $cycles ]
do
  echo $counter / $cycles
  ((counter=counter+1))
  datetime=$(date +'%d-%m-%Y %H:%M:%S')
  result=$(eval "mongo $dbname --host $host -u $user --authenticationDatabase admin -p$pass --eval \"db.callsCount.count()\"")
  echo $result $datetime >> counts.txt
  sleep $period
done
echo "All done"

#!/bin/bash
sourcePath=$1
limitDay=$2
if [ "$sourcePath" == "" ]; then
	echo "must input sourcePath"
	echo "for example /home/srchen/logs 30"
	echo "30 means before 30 day "
	exit;
fi

if [ -n "$limitDay" -a "$limitDay" = "${num//[^0-9]/}" ];then
	echo  "faild limitDay use default 3 days!";
	limitDay=3;
fi

backupDate=`date -d "-$limitDay day" +"%Y-%m-%d"`

backupPath=$sourcePath/$backupDate
if [ ! -d $backupPath ];then
mkdir $backupPath;
fi

if [ ! -d $sourcePath ]; then
	echo "$sourcePath is not exist!"
else
	findStatement="find  $sourcePath -mtime +$limitDay 2>1"
	if [ "$limitDay" == "0" ];then
	findStatement="find $sourcePath 2>1"	

	fi	

	for i in `$findStatement`;  
	do  
	 
			echo $i is file name\! ; 
		if [ ! "$i" == "$backupPath" ];then
			#echo $i is file name\! ; 
			mv $i $backupPath;
		fi 
	done
	tar -czvf $backupPath.tar.gz $backupPath
	rm -rf $backupPath
fi



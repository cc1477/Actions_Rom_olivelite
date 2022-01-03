#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

sed -i 's/Redmi 8/Redmi 8a/' $PROJECT/vendor/odm/etc/build.prop
sed -i 's/Redmi 8/Redmi 8a/' $PROJECT/system/system/build.prop
sed -i 's/Redmi 8/Redmi 8a/' $PROJECT/vendor/build.prop

sed -i 's/olive/olivelite/g' $PROJECT/vendor/odm/etc/build.prop
sed -i 's/olive/olivelite/g' $PROJECT/system/system/build.prop
sed -i 's/olive/olivelite/g' $PROJECT/vendor/build.prop

#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

echo "$(date "+[ %H:%M:%S ]")  去除avb校验、data加密"
fstab=$(find $PROJECT -name "fstab*")
for file in $fstab; do
	sed -i 's/,avb.*m,/,/g' $file
	sed -i 's/,avb,/,/g' $file
	sed -i "s/fileencryption=ice/encryptable=footer/g" $file
done
exit 0

#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

echo "$(date "+[ %H:%M:%S ]")  去除后台长按菜单限制"
if [[ -e $PROJECT/system/system/build.prop ]];then
    echo "$(date "+[ %H:%M:%S ]")  build文件存在"
    sed -i 's/ro.config.low_ram.threshold_gb=4/ /g' $PROJECT/system/system/build.prop
    low=$(grep -o "ro.config.low_ram.threshold_gb=4" $PROJECT/system/system/build.prop)
    if [[ -z $low ]];then
        echo "$(date "+[ %H:%M:%S ]")  去除去除后台长按菜单限制成功"
    else 
        echo "$(date "+[ %H:%M:%S ]")  去除失败"
        exit 1
    fi
else
    echo "$(date "+[ %H:%M:%S ]")  $PROJECT/system/system/build.prop不存在"
    echo "$(date "+[ %H:%M:%S ]")  退出脚本"
    exit 1
fi

exit 0
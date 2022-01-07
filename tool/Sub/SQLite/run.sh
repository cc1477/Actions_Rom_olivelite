#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

if [[ ! -e $PROJECT/system/system/media/theme/default/framework-res ]];then
    echo "$(date "+[ %H:%M:%S ]")  没有发现framework-res文件，自动添加中"
else
    cp -af $SHELL_PATH/framework-res $PROJECT/system/system/media/theme/default && chmod 777 $PROJECT/system/system/media/theme/default/framework-res
    if [[ -e $PROJECT/system/system/media/theme/default/framework-res ]];then
        echo "$(date "+[ %H:%M:%S ]")  添加SQLite优化成功"
    fi
fi

exit 0

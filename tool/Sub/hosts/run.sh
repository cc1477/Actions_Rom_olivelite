#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

hosts="
127.0.0.1 api.ad.xiaomi.com
127.0.0.1 ad.mi.com
127.0.0.1 ad.xiaomi.com
127.0.0.1 ad1.xiaomi.com
127.0.0.1 file.update.mi.com
"

for h in "$hosts"
do
    echo -n "$(date "+[ %H:%M:%S ]")  以下为添加的hosts"
    echo "$h"
    echo "$h" >>$PROJECT/system/system/etc/hosts
done

exit 0
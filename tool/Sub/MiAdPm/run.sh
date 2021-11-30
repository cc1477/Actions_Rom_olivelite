#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

if [[ -e ${PROJECT}/vendor/bin/init.qcom.post_boot.sh ]];then
    echo "开始添加代码"
    sed -i '$a\\n# pm Analytics or MSA' ${PROJECT}/vendor/bin/init.qcom.post_boot.sh
    sed -i '$apm disable com.miui.systemAdSolution' ${PROJECT}/vendor/bin/init.qcom.post_boot.sh
    sed -i '$apm disable com.miui.analytics' ${PROJECT}/vendor/bin/init.qcom.post_boot.sh
    if [[ -n $(grep $'# pm Analytics or MSA\npm disable com.miui.systemAdSolution\npm disable com.miui.analytics' ${PROJECT}/vendor/bin/init.qcom.post_boot.sh) ]];then
        echo "添加成功"
        exit 0
    fi
else
    echo "$(date "+[ %H:%M:%S ]")  ${PROJECT}/vendor/bin/init.qcom.post_boot.sh不存在"
    echo "$(date "+[ %H:%M:%S ]")  退出脚本"
    exit 1
fi
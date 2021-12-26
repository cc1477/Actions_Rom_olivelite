#!/bin/bash
if [[ -z $Upload ]];then
    echo "$(date "+[ %H:%M:%S ]")  未填写上传网盘，自动上传到gof"
    Upload=gof
fi
curl -sL https://git.io/file-transfer | sh  > /dev/null 2>&1
if [[ ! -x $M/transfer ]];then
    echo "$(date "+[ %H:%M:%S ]")  未发现transfer，已停止上传"
    exit 1
fi
#Rom
echo "$(date "+[ %H:%M:%S ]")  将制作完成的Rom上传到$Upload"
./transfer --no-progress $Upload $wk/${dname}.zip | grep -E "Download Link:|Local:" | eval "sed 's/^Local:/$(date "+[ %H:%M:%S ]")  文件名称:/g;s/^Download Link:/$(date "+[ %H:%M:%S ]")  下载链接:/g;s/[文件名称： ]\/.*\// /g'"
#Recover
echo "$(date "+[ %H:%M:%S ]")  将Magisk恢复模块上传到$Upload"
./transfer --no-progress $Upload $wk/Magisk-Recover.zip | grep -E "Download Link:|Local:" | eval "sed 's/^Local:/$(date "+[ %H:%M:%S ]")  文件名称:/g;s/^Download Link:/$(date "+[ %H:%M:%S ]")  下载链接:/g;s/[文件名称： ]\/.*\// /g'"
#log
echo "$(date "+[ %H:%M:%S ]")  将插件执行过程上传到$Upload"
./transfer --no-progress $Upload $wk/log*.zip | grep -E "Download Link:|Local:" | eval "sed 's/^Local:/$(date "+[ %H:%M:%S ]")  文件名称:/g;s/^Download Link:/$(date "+[ %H:%M:%S ]")  下载链接:/g;s/[文件名称： ]\/.*\// /g'"

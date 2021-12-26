#!/bin/bash
M="$(echo $(cd $(dirname $0) && pwd ) | sed 's/\/Script//g')"
Link=$(cat Config.CFG | grep "Link=" | awk -F '=' '{print $2}')
Linklite=$(cat Config.CFG | grep "Linklite=" | awk -F '=' '{print $2}')
if [[ -z $Linklite ]];then
    echo "---未填写Rrdmi 8a下载链接，使用默认fw"
else 
    aria2c -s 16 -x 16 -j 16 -o Romlite.zip $Linklite -d $M/
fi
if [[ -z $Link ]];then
    echo "---未填写下载链接，请到配置文件Config.CFG填写Link参数"
    exit 1
else
    aria2c -s 16 -x 16 -j 16 -o Rom.zip $Link -d $M/
fi

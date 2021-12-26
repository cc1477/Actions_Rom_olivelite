#!/bin/bash
[[ -d ${sub}/log ]] || mkdir ${sub}/log
if [[ -n $(ls $sub | grep -v log) ]];then
    for s in $(ls $sub | grep -v log)
    do
        echo "$(date "+[ %H:%M:%S ]")  执行$s插件,插件作用:$(cat ${sub}/${s}/${s}.txt)"
        lu=$s
        export lu
        bash ${sub}/${s}/run.sh >>$sub/log/${s}.log 2>&1
        if [[ $(echo $?) = 1 ]];then
            echo "$(date "+[ %H:%M:%S ]")  错误日志" && cat ${sub}/log/${s}.log && exit 1
        fi
    done
    if [[ -d $sub/log ]];then
        echo "$(date "+[ %H:%M:%S ]")  打包插件log到输出文件"
        cd $sub/log && zip -q -r "log-$(date +"%Y%m%d-%H%M").zip" *
        cd $M
    fi
fi
exit 0

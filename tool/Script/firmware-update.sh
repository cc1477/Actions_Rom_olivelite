#!/bin/bash
if [[ -z $Linklite ]];then
    rm -rf ${n}/firmware-update && cp -af ${M}/File/firmware-update $n
else
    rm -rf ${n}/firmware-update && unzip ${M}/Romlite.zip "*firmware-update/*.*" -d $n >/dev/null
fi
exit 0

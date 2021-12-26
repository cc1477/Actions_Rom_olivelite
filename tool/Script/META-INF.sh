#!/bin/bash
if [[ -z $Linklite ]];then
    rm -rf $n/META-INF && cp -af ${M}/File/META-INF $n
else
    rm -rf $n/META-INF && unzip -q ${M}/Romlite.zip -d $M/Romlite && mv ${M}/Romlite/META-INF $n
fi
exit 0

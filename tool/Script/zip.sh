#!/bin/bash
rm -rf ${n}/system.new.dat
rm -rf ${n}/vendor.new.dat
rm -rf ${n}/config
cd $n && zip -q -r "$wk/Actions_Rom.zip" ./* && cd $M && rm -rf $n
md5=$(md5sum $wk/Actions_Rom.zip | cut -c -10)
dname=$(eval echo $(cat $M/Config.CFG | grep "name=" | awk -F '=' '{print $2}'))
if [ -z $dname ];then
    dname="QSclite-miui-OLIVELITE-$(echo $Link | sed 's/.zip//g' | awk -F '_' '{print $3}' )_${md5}_$(echo $Link | sed 's/.zip//g' | awk -F '_' '{print $5}' )"
fi
exit 0

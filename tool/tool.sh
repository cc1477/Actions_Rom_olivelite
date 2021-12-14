#!/bin/bash
M=$(cd $(dirname $0) && pwd )
bin=$M/bin
wk=$M/Work
sub=$M/Sub
name=$(zip=`find ${M}/*.zip` && zip=`echo ${zip##*/}` && echo ${zip%.zip*})
n="${wk}/$name"
export M bin wk sub name n
if [[ ! -s $M/Config.CFG ]];then
    echo "Config.CFG不存在或大小为零"
    exit 1
fi
Link=$(cat $M/Config.CFG | grep "Link=" | awk -F '=' '{print $2}')
Linklite=$(cat $M/Config.CFG | grep "Linklite=" | awk -F '=' '{print $2}')
Br=$(cat $M/Config.CFG | grep "Br=" | awk -F '=' '{print $2}')
Upload=$(cat $M/Config.CFG | grep "Upload=" | awk -F '=' '{print $2}')
#解包
mkdir ${wk}/$name && echo "$(date "+[ %H:%M:%S ]")  解压Rom" && unzip -q ${M}/Rom.zip -d ${wk}/$name
#br转dat
echo "$(date "+[ %H:%M:%S ]")  system.new.dat.br转system.new.dat"
brotli -d $wk/$name/system.new.dat.br -o $wk/$name/system.new.dat
echo "$(date "+[ %H:%M:%S ]")  vendor.new.dat.br转vendor.new.dat"
brotli -d $wk/$name/vendor.new.dat.br -o $wk/$name/vendor.new.dat
rm -rf $wk/$name/system.new.dat.br
rm -rf $wk/$name/vendor.new.dat.br
#dat转img
echo "$(date "+[ %H:%M:%S ]")  system.new.dat转system.img"
$bin/sdat2img/sdat2img.py $n'/'system.transfer.list $n'/'system.new.dat $n'/'system.img > /dev/null && rm -rf $wk/$name/system.transfer.list && rm -rf $wk/$name/system.new.dat
echo "$(date "+[ %H:%M:%S ]")  vendor.new.dat转vendor.img"
$bin/sdat2img/sdat2img.py $n'/'vendor.transfer.list $n'/'vendor.new.dat $n'/'vendor.img > /dev/null && rm -rf $wk/$name/vendor.transfer.list && rm -rf $wk/$name/vendor.new.dat
ssize=$(expr $(ls -al ${n}/system.img | awk '{print $5}') / 1024 / 1024 )
vsize=$(expr $(ls -al ${n}/vendor.img | awk '{print $5}') / 1024 / 1024 )
#解img
echo "$(date "+[ %H:%M:%S ]")  分解system.img" && python3 $bin/imgextractor/imgextractor.py $n/system.img $n > /dev/null && rm -rf ${n}/system.img
echo "$(date "+[ %H:%M:%S ]")  分解vendor.img" && python3 $bin/imgextractor/imgextractor.py $n/vendor.img $n > /dev/null && rm -rf ${n}/vendor.img
#判断是否执行插件
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
#替换fw
echo "$(date "+[ %H:%M:%S ]")  替换firmware-update"
if [[ -z $Linklite ]];then
    rm -rf ${n}/firmware-update && mv ${M}/File/firmware-update $n
else
    unzip -j ${M}/Romlite.zip firmware-update -d $n
fi

#替换刷机脚本
echo "$(date "+[ %H:%M:%S ]")  替换META-INF" && rm -rf $n/META-INF && mv ${M}/File/META-INF $n
#打包system，vendor
echo "$(date "+[ %H:%M:%S ]")  合成system"
ssize=$(cat ${n}/config/system_size.txt)
size=$(expr $ssize / 1024 / 1024 )
$bin/mke2fs -L / -t ext4 -b 4096 $n/system.img ${size}M > /dev/null 2>&1
$bin/e2fsdroid -e -T 0 -S $n/config/system_file_contexts -C $n/config/system_fs_config  -a /system -f $n/system $n/system.img > /dev/null && rm -rf $n/system
echo "$(date "+[ %H:%M:%S ]")  合成vendor"
ssize=$(cat ${n}/config/vendor_size.txt)
size=$(expr $ssize / 1024 / 1024 )
$bin/mke2fs -L / -t ext4 -b 4096 $n/vendor.img ${size}M > /dev/null 2>&1
$bin/e2fsdroid -e -T 0 -S $n/config/vendor_file_contexts -C $n/config/vendor_fs_config  -a /vendor -f $n/vendor $n/vendor.img > /dev/null && rm -rf $n/vendor
#调整img大小
echo "$(date "+[ %H:%M:%S ]")  调整system大小"
e2fsck -fy $n/system.img > /dev/null 2>&1
resize2fs -f $n/system.img 4096m > /dev/null 2>&1
echo "$(date "+[ %H:%M:%S ]")  调整vendor大小"      
e2fsck -fy $n/vendor.img > /dev/null 2>&1
resize2fs -f $n/vendor.img 1024m > /dev/null 2>&1
#img转dat
echo "$(date "+[ %H:%M:%S ]")  system.img转system.new.dat"
$bin/rimg2sdat.py $n/system.img -o $n -v 4 > /dev/null 
rm -rf ${n}/system.img
echo "$(date "+[ %H:%M:%S ]")  vendor.img转vendor.new.dat"
$bin/rimg2sdat.py ${n}/vendor.img -o $wk -v 4 > /dev/null
mv $wk/system.new.dat $n/vendor.new.dat && mv $wk/system.transfer.list $n/vendor.transfer.list
rm -rf ${n}/vendor.img
#dat转br
echo "$(date "+[ %H:%M:%S ]")  system.new.dat转system.new.dat.br [br等级$Br]"
brotli -q $Br ${n}/system.new.dat -o $n/system.new.dat.br > /dev/null 
rm -rf ${n}/system.new.dat
echo "$(date "+[ %H:%M:%S ]")  vendor.new.dat转vendor.new.dat.br [br等级$Br]"
brotli -q $Br ${n}/vendor.new.dat -o $n/vendor.new.dat.br > /dev/null 
rm -rf ${n}/vendor.new.dat
echo "$(date "+[ %H:%M:%S ]")  打包Rom"
rm -rf ${n}/system.new.dat
rm -rf ${n}/vendor.new.dat
rm -rf ${n}/config
cd $n && zip -q -r "$wk/Actions_Rom.zip" ./* && cd $M && rm -rf $n
md5=$(md5sum $wk/Actions_Rom.zip | cut -c -10)
dname=$(eval echo $(cat $M/Config.CFG | grep "name=" | awk -F '=' '{print $2}'))
export M bin wk sub name n Upload Br Link md5 dname
echo "$(date "+[ %H:%M:%S ]")  打包名称:${dname}.zip"
echo "$(date "+[ %H:%M:%S ]")  Rom大小:$(du -sh $wk/Actions_Rom.zip | awk '{print $1}')"
mv $wk/Actions_Rom.zip $wk/${dname}.zip
mv $M/Magisk-Recover.zip $wk
mv $sub/log/log*.zip $wk
echo "$(date "+[ %H:%M:%S ]")  工作目录文件 $(ls $wk | sed 's/^/ \t      /g' | sed '1i\\t')"
echo "$(date "+[ %H:%M:%S ]")  上传的网盘:$Upload"
cd $M
#上传
bash ${M}/Upload.sh
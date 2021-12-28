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
echo "$(date "+[ %H:%M:%S ]")  解压Rom" 
bash ${M}/Script/unzip.sh

#br转dat
echo "$(date "+[ %H:%M:%S ]")  system.new.dat.br转system.new.dat"
bash ${M}/Script/brdat/brdat-system.sh
echo "$(date "+[ %H:%M:%S ]")  vendor.new.dat.br转vendor.new.dat"
bash ${M}/Script/brdat/brdat-vendor.sh


#dat转img
echo "$(date "+[ %H:%M:%S ]")  system.new.dat转system.img"
bash ${M}/Script/datimg/datimg-system.sh
echo "$(date "+[ %H:%M:%S ]")  vendor.new.dat转vendor.img"
bash ${M}/Script/datimg/datimg-vendor.sh

#解img
echo "$(date "+[ %H:%M:%S ]")  分解system.img"
bash ${M}/Script/'img-system&vendor'/img-system.sh
echo "$(date "+[ %H:%M:%S ]")  分解vendor.img"
bash ${M}/Script/'img-system&vendor'/img-system.sh

#判断是否执行插件
bash ${M}/Script/Sub.sh

#替换fw
echo "$(date "+[ %H:%M:%S ]")  替换firmware-update"
bash ${M}/Script/firmware-update.sh

#替换刷机脚本
echo "$(date "+[ %H:%M:%S ]")  替换META-INF"
bash ${M}/Script/META-INF.sh

#替换相机配置
echo "$(date "+[ %H:%M:%S ]")  替换替换相机配置"
bash ${M}/Script/camera.sh

#打包system，vendor
echo "$(date "+[ %H:%M:%S ]")  合成system"
bash ${M}/Script/system-img/system-img.sh
echo "$(date "+[ %H:%M:%S ]")  合成vendor"
bash ${M}/Script/vendor-img/vendor-img.sh

#调整img大小
echo "$(date "+[ %H:%M:%S ]")  调整system大小"
bash ${M}/Script/System-Size/System-Size.sh
echo "$(date "+[ %H:%M:%S ]")  调整vendor大小"      
bash ${M}/Script/Vendor-Size/Vendor-Size.sh

#img转dat
echo "$(date "+[ %H:%M:%S ]")  system.img转system.new.dat"
bash ${M}/Script/imgdat/imgdat-system.sh
echo "$(date "+[ %H:%M:%S ]")  vendor.img转vendor.new.dat"
bash ${M}/Script/imgdat/imgdat-vendor.sh

#dat转br
echo "$(date "+[ %H:%M:%S ]")  system.new.dat转system.new.dat.br [br等级$Br]"
bash ${M}/Script/datbr/datbr-system.sh
echo "$(date "+[ %H:%M:%S ]")  vendor.new.dat转vendor.new.dat.br [br等级$Br]"
bash ${M}/Script/datbr/datbr-vendor.sh

#打包Rom
echo "$(date "+[ %H:%M:%S ]")  打包Rom"
bash ${M}/Script/zip.sh

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
bash ${M}/Script/Upload.sh

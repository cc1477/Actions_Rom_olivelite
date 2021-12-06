#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

#精简路径
if [ -s $SHELL_PATH/lin.prop ];then
   echo "$(date "+[ %H:%M:%S ]")  $SHELL_PATH/lin.prop存在且大小不为零"
else 
   echo "$(date "+[ %H:%M:%S ]")  $SHELL_PATH/lin.prop不存在或大小为零"
   echo "$(date "+[ %H:%M:%S ]")  如果手贱删掉清自行创建,并且记得输完路径后回车以下比如你一共有11行路径,就在第11行路径后回车,别回多了,最后应该是12行"
   exit 1
fi

#lin.prop > lind.prop
cp $SHELL_PATH/lin.prop $SHELL_PATH/lind.prop
#分离vendor路径到vendor.prop
if [[ -n $(cat $SHELL_PATH/lind.prop | grep /vendor*) ]];then
    cat $SHELL_PATH/lind.prop | sed "/^#/d"  | grep /vendor* >$SHELL_PATH/vendor.prop
    sed -i "/^#/d" $SHELL_PATH/lind.prop
    sed -i 's/\/vendor.*//g' $SHELL_PATH/lind.prop
    sed -i '/^$/d' $SHELL_PATH/lind.prop
fi

zs=$(sed "/^#/d" $SHELL_PATH/lin.prop | sed '/^$/d' | sed "s/^/$(date "+[ %H:%M:%S ]")  &/g")
echo "$(date "+[ %H:%M:%S ]")  以下为精简的路径"
echo "$zs"

#输出路径到Magisk-Module的customize.sh
sag=$(while read route;do [[ -s "${PROJECT}"'/system'$route ]] && echo $route | sed '/#/'d | sed '/^$/d' ;done < $SHELL_PATH/lind.prop)
vag=$(while read route;do [[ -s "${PROJECT}"${route} ]] && echo $route | sed '/#/'d | sed '/^$/d' | sed 's/^\/vendor/\/system\/vendor/g' ;done < $SHELL_PATH/vendor.prop)
if [[ -z $vag ]];then
    vag='/system/texttexttext'
fi
echo 'SKIPUNZIP=0
'echo "$(date "+[ %H:%M:%S ]")  开始解压精简文件"'
unzip -o -q $MODPATH/system/system.zip && rm -rf $MODPATH/system/system.zip
REPLACE="'"
$sag
$vag
"'"' > $SHELL_PATH/Recover/customize.sh

#开始精简
while read route
do
  [[ -s "$PROJECT"'/system'$route ]] && lu=`echo ${route%/*} | sed '/#/'d` && lu=`echo ${lu#*/}`
  [[ -s "$PROJECT"'/system'$route ]] && mkdir -p $SHELL_PATH/精简的文件/$lu
  if [[ -s "$PROJECT"'/system'$route ]];then
      [[ -d $SHELL_PATH/精简的文件 ]] && rsync -avz $PROJECT/system/$route $SHELL_PATH/精简的文件/$lu &> /dev/null
  #删除精简文件/目录
  rm -rf $PROJECT/system/$route
  fi
done < $SHELL_PATH/lind.prop
while read venr
do
  [[ -s "${PROJECT}"${venr} ]] && lu=`echo ${venr%/*} | sed '/#/'d` && lu=`echo ${lu#*/}`
  [[ -s "${PROJECT}"${venr} ]] && mkdir -p $SHELL_PATH/精简的文件/$lu
  if [[ -s "${PROJECT}"${venr} ]];then
      [[ -d $SHELL_PATH/精简的文件 ]] && rsync -avz ${PROJECT}${venr} $SHELL_PATH/精简的文件/$lu &> /dev/null
  #删除精简文件/目录
  rm -rf ${PROJECT}${venr}
  fi
done < $SHELL_PATH/vendor.prop
[[ -d $SHELL_PATH/精简的文件/vendor ]] && mv $SHELL_PATH/精简的文件/vendor $SHELL_PATH/精简的文件/system/

#打包精简文件
cd $SHELL_PATH/精简的文件/system && zip -q -r system.zip * && cd $SHELL_PATH && mv $SHELL_PATH/精简的文件/system/system.zip $SHELL_PATH/精简的文件/system.zip

#同步到Magisk模块目录并删除多余文件
rsync -avz --delete --exclude "META-INF" --delete --exclude "customize.sh" --delete --exclude "module.prop" $SHELL_PATH/精简的文件/system.zip $SHELL_PATH/Recover/ > /dev/null

#Magisk-Module
echo "$(date "+[ %H:%M:%S ]")  打包成Magisk恢复模块"
cd $SHELL_PATH/Recover/ && zip -q -r $SHELL_PATH/Magisk-Recover.zip * && cd $SHELL_PATH
[[ -d $SHELL_PATH/精简的文件 ]] && mv $SHELL_PATH/Magisk-Recover.zip $LOCAL
echo "$(date "+[ %H:%M:%S ]")  打包的magisk模块你可以在工具根目录找到,路径为$LOCAL"

#权限设置&清理目录
echo "$(date "+[ %H:%M:%S ]")  设置权限"
chmod -R 0777 $PROJECT
echo "$(date "+[ %H:%M:%S ]")  清理残留目录"
rm -rf $SHELL_PATH/精简的文件
rm -rf $SHELL_PATH/lind.prop
rm -rf $SHELL_PATH/vendor.prop

#退出脚本
exit 0
#!/bin/bash
echo "$(date "+[ %H:%M:%S ]")  去除卡米限制"
chmod 777 $sub/MiuiBreak/apktool.jar
#反编译
echo "$(date "+[ %H:%M:%S ]")  反编译services.jar"
java -jar $sub/MiuiBreak/apktool.jar d -q -r -f -o $sub/MiuiBreak/jar $n/system/system/framework/services.jar
smali=$(find $sub/MiuiBreak/jar/ -type f -name SecurityManagerService.smali)
#去卡米
echo "$(date "+[ %H:%M:%S ]")  去除卡米代码"
sed -i '/^.method private checkSystemSelfProtection(Z)V/,/^.end method/{//!d}' $smali
sed -i -e '/^.method private checkSystemSelfProtection(Z)V/a\    .locals 1\n\n    return-void' $smali
#回编译
echo "$(date "+[ %H:%M:%S ]")  回编译services.jar"
java -jar $sub/MiuiBreak/apktool.jar b -q -f -o $n/system/system/framework/services.jar $sub/MiuiBreak/jar
#清理文件目录
echo "$(date "+[ %H:%M:%S ]")  清理文件目录"
rm -rf $sub/MiuiBreak/jar
#退出脚本
exit 0
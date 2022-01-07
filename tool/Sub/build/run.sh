#!/bin/bash
LOCAL=$M					#本地目录
PROJECT=$n					#工程目录
SHELL=$(readlink -f "$0")			#脚本文件
SHELL_PATH=${sub}/${lu}	#脚本路径

sed -i 's/Redmi 8/Redmi 8a/' $PROJECT/vendor/odm/etc/build.prop
sed -i 's/Redmi 8/Redmi 8a/' $PROJECT/system/system/build.prop
sed -i 's/Redmi 8/Redmi 8a/' $PROJECT/vendor/build.prop

sed -i 's/olive/olivelite/g' $PROJECT/vendor/odm/etc/build.prop
sed -i 's/olive/olivelite/g' $PROJECT/system/system/build.prop
sed -i 's/olive/olivelite/g' $PROJECT/vendor/build.prop

mv /system/etc/device_features/olive.xml /system/etc/device_features/olivelite.xml

echo -e "#开启SurfaceFlinger缓冲区\ndebug.sf.latch_unsignaled=1" >>$PROJECT/system/system/build.prop 
echo -e "#开启同用宽带压缩UBWC\ndebug.gralloc.enable_fb_ubwc=1" >>$PROJECT/system/system/build.prop 
echo -e "#开启AI通话\nro.vendor.audio.aiasst.support=true" >>$PROJECT/system/system/build.prop 
echo -e "#禁用小米内核调试收集服务\nsys.miui.ndcd=off" >>$PROJECT/system/system/build.prop 

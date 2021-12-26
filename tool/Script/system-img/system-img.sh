#!/bin/bash
ssize=$(cat ${n}/config/system_size.txt)
size=$(expr $ssize / 1024 / 1024 )
$bin/mke2fs -L / -t ext4 -b 4096 $n/system.img ${size}M > /dev/null 2>&1
$bin/e2fsdroid -e -T 0 -S $n/config/system_file_contexts -C $n/config/system_fs_config  -a /system -f $n/system $n/system.img > /dev/null && rm -rf $n/system
exit 0

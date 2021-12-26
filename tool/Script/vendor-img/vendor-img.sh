#!/bin/bash
ssize=$(cat ${n}/config/vendor_size.txt)
size=$(expr $ssize / 1024 / 1024 )
$bin/mke2fs -L / -t ext4 -b 4096 $n/vendor.img ${size}M > /dev/null 2>&1
$bin/e2fsdroid -e -T 0 -S $n/config/vendor_file_contexts -C $n/config/vendor_fs_config  -a /vendor -f $n/vendor $n/vendor.img > /dev/null && rm -rf $n/vendor
exit 0

#!/bin/bash
e2fsck -fy $n/vendor.img > /dev/null 2>&1
resize2fs -f $n/vendor.img 1024m > /dev/null 2>&1
exit 0

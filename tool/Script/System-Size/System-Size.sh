#!/bin/bash
e2fsck -fy $n/system.img > /dev/null 2>&1
resize2fs -f $n/system.img 4096m > /dev/null 2>&1
exit 0

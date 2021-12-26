#!/bin/bash
$bin/sdat2img/sdat2img.py $n'/'vendor.transfer.list $n'/'vendor.new.dat $n'/'vendor.img > /dev/null && rm -rf $wk/$name/vendor.transfer.list && rm -rf $wk/$name/vendor.new.dat
vsize=$(expr $(ls -al ${n}/vendor.img | awk '{print $5}') / 1024 / 1024 )
exit 0

#!/bin/bash
$bin/sdat2img/sdat2img.py $n'/'system.transfer.list $n'/'system.new.dat $n'/'system.img > /dev/null && rm -rf $wk/$name/system.transfer.list && rm -rf $wk/$name/system.new.dat
ssize=$(expr $(ls -al ${n}/system.img | awk '{print $5}') / 1024 / 1024 )
exit 0

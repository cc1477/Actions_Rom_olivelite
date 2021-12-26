#!/bin/bash
$bin/rimg2sdat.py ${n}/vendor.img -o $wk -v 4 > /dev/null
mv $wk/system.new.dat $n/vendor.new.dat && mv $wk/system.transfer.list $n/vendor.transfer.list
rm -rf ${n}/vendor.img
exit 0

#!/bin/bash
brotli -q $Br ${n}/vendor.new.dat -o $n/vendor.new.dat.br > /dev/null 
rm -rf ${n}/vendor.new.dat
exit 0

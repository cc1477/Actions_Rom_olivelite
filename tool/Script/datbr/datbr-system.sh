#!/bin/bash
brotli -q $Br ${n}/system.new.dat -o $n/system.new.dat.br > /dev/null 
rm -rf ${n}/system.new.dat
exit 0

#!/bin/bash
$bin/rimg2sdat.py $n/system.img -o $n -v 4 > /dev/null 
rm -rf ${n}/system.img
exit 0

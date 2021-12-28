#!/bin/bash
python3 $bin/imgextractor/imgextractor.py $n/system.img $n > /dev/null && rm -rf ${n}/system.img
exit 0

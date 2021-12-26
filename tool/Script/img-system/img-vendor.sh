#!/bin/bash
python3 $bin/imgextractor/imgextractor.py $n/vendor.img $n > /dev/null && rm -rf ${n}/vendor.img
exit 0

#!/bin/bash
brotli -d $wk/$name/vendor.new.dat.br -o $wk/$name/vendor.new.dat
rm -rf $wk/$name/vendor.new.dat.br
exit 0

#!/bin/bash
brotli -d $wk/$name/system.new.dat.br -o $wk/$name/system.new.dat
rm -rf $wk/$name/system.new.dat.br
exit 0

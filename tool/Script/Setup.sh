#!/bin/bash
M="$(echo $(cd $(dirname $0) && pwd ) | sed 's/Script\///g')"
bin=$M/bin
#初始化
sudo apt update
sudo apt upgrade -y 
sudo apt install curl -y 
sudo apt install rsync -y 
sudo apt install zip -y 
sudo apt install aria2 -y 
sudo apt install python -y
sudo apt install python3 -y
sudo apt install brotli -y
sudo apt install e2fsprogs -y 
unzip -q ${M}/File/firmware-update.zip -d ${M}/File/
unzip -q ${M}/File/camera.zip -d ${M}/File/
mkdir $M/Work
chmod 755 -R $M
chmod 777 -R $bin

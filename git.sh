#!/system/bin/sh
read -p "请输入git add 的文件:" add
git add $add
read -p "请输入commit的内容:" commit
git commit -m "$commit"
git config --global credential.helper store
read -p "按任意键即可上传远程仓库 " push
git push -u origin master

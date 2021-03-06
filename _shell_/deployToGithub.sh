#!/bin/bash
#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# step1 - 询问切换哪个目录
echo -e "- Step 1"
DEFAULT_GIT_SHELL_CD_PARAM="./"
read -p "? Where do you want to switch directories(default is ${DEFAULT_GIT_SHELL_CD_PARAM}): " GIT_SHELL_CD_PARAM
if [ -z $GIT_SHELL_CD_PARAM ];then
  GIT_SHELL_CD_PARAM=${DEFAULT_GIT_SHELL_CD_PARAM}
fi
GIT_SHELL_CD_PARAM="${GIT_SHELL_CD_PARAM%\"}"
GIT_SHELL_CD_PARAM="${GIT_SHELL_CD_PARAM#\"}"
echo "  - GIT_SHELL_CD_PARAM=${GIT_SHELL_CD_PARAM}"
cd $GIT_SHELL_CD_PARAM
echo -e "  - pwd = "
pwd
echo -e "\n"

# Step 2- 生成静态文件
echo -e "- Step 2"
echo "- build"
npm run build:prod:docs

# Step 3 - 提交到历史区，$1 为运行 sh 时的第一个参数
echo -e "- Step 3"
echo "- git add"
git add -A
echo "- git commit"
git commit -m "$1"

# 拉取代码
# echo "- git pull"
# git pull origin master

# Step 4 - 提交到 master 分支
echo -e "- Step 4"
echo "- git push"
git push origin master

# 将 dist 文件提交到 gh-pages 分支
# echo "- git subtree push"
# git subtree push --prefix dist origin gh-pages

# 退出命令
exit 0
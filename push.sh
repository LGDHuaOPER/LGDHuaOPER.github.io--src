#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# step1-添加
echo "- git add"
git add -A
echo -e "  - git add success! \n"

# step2-提交到历史区，$1 为运行 sh 时的第一个参数
echo "- git commit"
git commit -m $1
echo -e "  - git commit success! \n"

# step3-提交到 master 分支
echo "- git push"
git push origin master
echo -e "  - git push success! \n"

# 将 dist 文件提交到 gh-pages 分支
# git subtree push --prefix dist origin gh-pages

# 退出命令
exit 0
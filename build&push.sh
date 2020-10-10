#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
echo "- build"
npm run build:prod:docs

# 提交到历史区，$1 为运行 sh 时的第一个参数
echo "- git add"
git add -A
echo "- git commit"
git commit -m $1

# 拉取代码
# echo "- git pull"
# git pull origin master

# 提交到 master 分支
echo "- git push"
git push origin master

# 将 dist 文件提交到 gh-pages 分支
# echo "- git subtree push"
# git subtree push --prefix dist origin gh-pages

# 退出命令
exit 0
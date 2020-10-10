###
 # @Author: LGD.HuaFEEng
 # @Date: 2020-02-24 22:54:55
 # @LastEditTime: 2020-10-10 17:56:49
 # @LastEditors: LGD.HuaFEEng
 # @Description: git shell
 # @FilePath: \LGDHuaOPER.github.io--src\git.sh
### 
#!/bin/bash
#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# step1-询问使用哪个分支
DEFAULT_USER_GIT_USE_BRANCH=`git rev-parse --abbrev-ref HEAD`
read -p "? Which branch to use(default is ${DEFAULT_USER_GIT_USE_BRANCH}): " USER_GIT_USE_BRANCH
if [ -z $USER_GIT_USE_BRANCH ];then
  USER_GIT_USE_BRANCH=${DEFAULT_USER_GIT_USE_BRANCH}
fi
echo "  - USER_GIT_USE_BRANCH=${USER_GIT_USE_BRANCH}"
echo -e "\n"

# step2-拉取代码
echo "- git pull"
git pull origin ${USER_GIT_USE_BRANCH}
# -e 开启转义
echo -e "  - git pull success! \n"

# step3-询问是否提交更新
read -p "? Submit update or not, Y/N(default is Y): " USER_GIT_SUBMIT_UPDATE
if [ -z $USER_GIT_SUBMIT_UPDATE ]
then
  echo "  - USER_GIT_SUBMIT_UPDATE=${USER_GIT_SUBMIT_UPDATE}"
elif [[ $USER_GIT_SUBMIT_UPDATE == "Y" || $USER_GIT_SUBMIT_UPDATE == "YES" || $USER_GIT_SUBMIT_UPDATE == "y" || $USER_GIT_SUBMIT_UPDATE == "yes" ]]
then
  echo "  - USER_GIT_SUBMIT_UPDATE=${USER_GIT_SUBMIT_UPDATE}"
else
  echo "  - USER_GIT_SUBMIT_UPDATE=${USER_GIT_SUBMIT_UPDATE}"
  echo "  - Don't submit update."
  exit
fi
echo -e "\n"

# step4-添加
echo "- git add"
git add -A
echo -e "  - git add success! \n"

# step5-询问提交信息
read -p "? Input commit message: " USER_GIT_COMMIT_MESSAGE
if [[ -z $USER_GIT_COMMIT_MESSAGE ]];then
  USER_GIT_COMMIT_MESSAGE="default commit mesage"
fi
USER_GIT_COMMIT_MESSAGE="${USER_GIT_COMMIT_MESSAGE%\"}"
USER_GIT_COMMIT_MESSAGE="${USER_GIT_COMMIT_MESSAGE#\"}"
echo "  - USER_GIT_COMMIT_MESSAGE=${USER_GIT_COMMIT_MESSAGE}"
echo -e "\n"

# step6-是否确认提交信息
read -p "? Confirm commit message, Y/N(default is Y): " USER_GIT_CONFIRM_COMMIT_MESSAGE
if [ -z $USER_GIT_CONFIRM_COMMIT_MESSAGE ]
then
  echo "  - USER_GIT_CONFIRM_COMMIT_MESSAGE=${USER_GIT_CONFIRM_COMMIT_MESSAGE}"
elif [[ $USER_GIT_CONFIRM_COMMIT_MESSAGE == "Y" || $USER_GIT_CONFIRM_COMMIT_MESSAGE == "YES" || $USER_GIT_CONFIRM_COMMIT_MESSAGE == "y" || $USER_GIT_CONFIRM_COMMIT_MESSAGE == "yes" ]]
then
  echo "  - USER_GIT_CONFIRM_COMMIT_MESSAGE=${USER_GIT_CONFIRM_COMMIT_MESSAGE}"
else
  echo "  - USER_GIT_CONFIRM_COMMIT_MESSAGE=${USER_GIT_CONFIRM_COMMIT_MESSAGE}"
  # step7-询问修改的提交信息
  read -p "  ? Modify commit message: " USER_GIT_MODIFY_COMMIT_MESSAGE
  if [[ -z $USER_GIT_MODIFY_COMMIT_MESSAGE ]];then
    USER_GIT_MODIFY_COMMIT_MESSAGE=${USER_GIT_COMMIT_MESSAGE}
  fi
  USER_GIT_MODIFY_COMMIT_MESSAGE="${USER_GIT_MODIFY_COMMIT_MESSAGE%\"}"
  USER_GIT_MODIFY_COMMIT_MESSAGE="${USER_GIT_MODIFY_COMMIT_MESSAGE#\"}"
  echo "    - USER_GIT_MODIFY_COMMIT_MESSAGE=${USER_GIT_MODIFY_COMMIT_MESSAGE}"
  USER_GIT_COMMIT_MESSAGE=${USER_GIT_MODIFY_COMMIT_MESSAGE}
  echo "    - USER_GIT_COMMIT_MESSAGE=${USER_GIT_COMMIT_MESSAGE}"
  echo -e "\n"
fi
echo -e "\n"

# step8-提交到历史区，$1 为运行 sh 时的第一个参数
echo "- git commit"
git commit -m "${USER_GIT_COMMIT_MESSAGE}"
echo -e "  - git commit success! \n"

# 去除首尾双引号
# "$opt" | tr -d '"'

# step9-提交到 master 分支
echo "- git push"
git push origin ${USER_GIT_USE_BRANCH}
echo -e "  - git push success! \n"

exit 0

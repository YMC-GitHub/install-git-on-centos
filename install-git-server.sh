#!/bin/sh

#### 为什么要
# 开源的，私有的需要付费



#### 如何进行
#服务账号
GIT_USER=git #管理git服务的账号
#服务密码
GIT_PASSWORD=git #管理git服务的账号密码
#仓库目录
GIT_REPO_DIR=/home/${GIT_USER} #所有仓库存放在哪里
#仓库文件
GIT_REPO_FILE=test.git #某个仓库目录，存放某个仓库的所有文件
#主机地址
HOST_IP=111.22.33.44 #git服务搭建在哪台主机上

# 查看git版本
git --version #前提已经装好git

# 创建git用户
useradd $GIT_USER
# 创建git密码
passwd $GIT_PASSWORD


# 创建git仓库
sudo git init --bare ${GIT_REPO_DIR}/${GIT_REPO_FILE}

# 赋予git权限
sudo chown -R ${GIT_USER}:${GIT_USER} ${GIT_REPO_DIR}/${GIT_REPO_FILE} #给用户赋予操作仓库的权限

# 下拉git仓库
#git clone ${GIT_USER}@${HOST_IP}:${GIT_REPO_DIR}/${GIT_REPO_FILE}
# 下拉git仓库
# 推送git仓库

# ssh免密登录
# D:\code-store\Shell\connect-to-remote-with-ssh\with-secret-key.sh
# + below
#
#2 赋予权限
su $GIT_USER
mkdir ~/.ssh && chmod 700 ~/.ssh
chmod 600 ~/google-clound-ssr
#2 开启RSA验证
sed -i 's/RSAAuthentication no/RSAAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/AuthorizedKeysFile no/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i '$aAuthorizedKeysFile  .ssh/google-clound-ssr' /etc/ssh/sshd_config
#2 免密登录
#ssh -i ~/.ssh/google-clound-ssr ${GIT_USER}@${HOST_IP}

#禁用shell登录
#--让git用户可以正常通过ssh使用git，但无法登录shell
cat --number /etc/passwd
::<<eof
git:x:1001:1001:,,,:/home/git:/bin/bash

git:x:1001:1001:,,,:/home/git:/usr/bin/git-shell
eof

#### 参考文献
# 10分钟搭建git服务器

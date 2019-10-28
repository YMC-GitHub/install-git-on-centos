#!/bin/sh

#### 为什么要
# 虽然可以使用yum install git安装
# 但是估计只能安装到某以前的版本
# 假如有最新的git包估计安装不到

#### 如何进行
#软件版本
GIT_VERSION=2.23.0
#安装目录
GIT_INSTALL_DIR=/usr/local
#解压目录
GIT_UNPACK_DIR=git # 解压后的git目录
下载目录
GIT_DOWNLOAD_DIR=${GIT_INSTALL_DIR} # 在哪个目录下git

# 删之前版本
yum remove git

# 下载源码包
cd $GIT_DOWNLOAD_DIR
#wget https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz
wget https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz
# 解压源码包
tar xzf git-${GIT_VERSION}.tar.gz
# 命名源码包
mv git-${GIT_VERSION} $GIT_UNPACK_DIR
# 删除源码包
rm -rf git-${GIT_VERSION}.tar.gz

# 编译源码包
#step-level-2:下载工具包
yum install openssl-devel expat-devel libcurl-dev libcurl-devel #防止编译源码报错
cd $GIT_UNPACK_DIR
make prefix=${GIT_INSTALL_DIR}/${GIT_UNPACK_DIR} all
make prefix=${GIT_INSTALL_DIR}/${GIT_UNPACK_DIR} install

# 设环境变量
# cat --number /etc/profile
cat >>/etc/profile<<EOF
#nodejs
export PATH=\$PATH:${GIT_INSTALL_DIR}/git/bin
EOF
::<<test-for-set-system-wide-environment-for-git
cat >>/etc/test<<EOF
#nodejs
export PATH=\$PATH:${GIT_INSTALL_DIR}/git/bin
EOF
cat --number /etc/test
rm -rf /etc/test
test-for-set-system-wide-environment-for-git

# 验证其安装
git --version


#### 参考文献
# centos安装高版本git
# https://juejin.im/post/5be4419c51882516df030ad5
# Linux安装并配置git（CentOS 7.X）
# https://juejin.im/post/5daa81a7f265da5ba12cf6ef
# shell编程之转义和引用
# https://www.cnblogs.com/youcong/p/7913173.html
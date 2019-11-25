#!/bin/sh

# 当git客户端的代码发布到git服务端时，
# 让git服务端自动发送到云应用服务器上。

#ON GIT-SERVER:
#创建裸仓库
APP_NAME=blog
REPO_NAME="${APP_NAME}-bare.git"
REPO_PATH="~/repos/${REPO_NAME}"
mkdir -p "$REPO_PATH"
cd "$REPO_PATH"
git init --bare

#创建某钩子
# cp "$REPO_PATH/hooks/post-update.sample" "$REPO_PATH/hooks/post-update"
cat > "$REPO_PATH/hooks/post-update" <<EOF
#!/bin/sh
unset GIT_DIR
DIR_ONE=" ~/www/$APP_NAME"
cd $DIR_ONE

git init
git remote add origin "$REPO_PATH"
git clean -df
git pull origin master

pm2 restart "$APP_NAME"  #pm2重启项目即可
EOF

#赋予某权限
chmod +x "$REPO_PATH/hooks/post-update"


#ON GIT-CLIENT:
#git remote add origin user@1.2.3.4:/home/USER/repos/xxx-bare.git  #添加远程仓库源
#例如git remote add origin ssh://root@41.72.11.11:26244/home/USER/repos/xxx-bare.git  #远程仓库带端口写法
#git push origin master

#### 参考文献
:<<reference
#用 Git 钩子进行简单自动部署
https://aotu.io/notes/2017/04/10/githooks/index.html
reference
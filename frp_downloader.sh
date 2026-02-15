#!/bin/bash

URL="https://github.com/fatedier/frp/releases/download/v0.67.0/frp_0.67.0_linux_amd64.tar.gz"
FILE_NAME="${URL##*/}"
FOLDER_NAME="${FILE_NAME%.tar.gz}"


#ホスト用設定
FRPS=frps.toml
#クライアント用設定
FRPC=frpc.toml


wget $URL
tar -xvzf $FILE_NAME



mv $FOLDER_NAME frp
cp $FRPS frp/
cp $FRPC frp/
rm $FILE_NAME

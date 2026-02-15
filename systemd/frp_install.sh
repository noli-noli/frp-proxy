#!/bin/bash

#service関連ファイルの配置定義
SERVICEDIR="/etc/systemd/system"
#serviceファイル名
SERVICEFILE="frp.service"



#tokenが含まれる.envを配置するpath
ENV="/etc/frp"
#fpr本体のディレクトリ
FPR="/usr/local/sbin"



#rootチェック
if [ "$(id -u)" -ne 0 ]; then
    echo "[Check:NG] Please run as root"
    exit 1
else
    echo "[Check:OK] Run as root"
fi
#ervice関連のチェック
if [ ! -e ./$SERVICEFILE ]; then
    echo "[Check:NG] Not found ($SERVICEFILE)"
    exit 1
elif [ ! -e $SERVICEDIR ]; then
    echo "[Check:NG] Not found ($SERVICEDIR)"
    exit 1
else
    echo "[Check:OK] Found all service files"
fi



# ディレクトリ存在チェック＆作成
for dir in "$ENV" "$FPR"; do
    if [ -d "$dir" ]; then
        echo "[Check:OK] Found directory ($dir)"
    else
        echo "[Check:WARN] Not found directory ($dir) -> create"
        mkdir -p "$dir"
        chmod 755 "$dir"
        echo "[Check:OK] Created directory ($dir)"
    fi
done




# frp本体と.envを配置
if [ -d ../frp ]; then
    if [ -d "$FPR/frp" ]; then
        echo "[Check:WARN] Already exists ($FPR/frp) -> replace"
        rm -rf "$FPR/frp"
    fi
    cp -r ../frp "$FPR/"
    echo "[Check:OK] Moved frp directory to $FPR"
    chown -R root:root "$FPR/frp"
    chmod -R go-rwx "$FPR/frp"
    echo "[Check:OK] Set owner root:root and permissions 700/600 ($FPR/frp)"
else
    echo "[Check:NG] Not found frp directory (../frp)"
    exit 1
fi

if [ -f ../.env ]; then
    cp ../.env "$ENV/"
    echo "[Check:OK] Moved .env to $ENV"
    chown root:root "$ENV/.env"
    echo "[Check:OK] Set owner root:root ($ENV/.env)"
    chmod 600 "$ENV/.env"
    echo "[Check:OK] Set permission 600 ($ENV/.env)"
else
    echo "[Check:NG] Not found .env (../.env)"
    exit 1
fi



# systemd用ファイルを移動
cp ./$SERVICEFILE $SERVICEDIR
systemctl daemon-reload
#サービスの自動起動
systemctl enable $SERVICEFILE
#各サービスの有効化
systemctl start $SERVICEFILE
exit 0

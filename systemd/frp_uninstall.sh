#!/bin/bash

# service関連ファイルの配置定義
SERVICEDIR="/etc/systemd/system"
# serviceファイル名
SERVICEFILE="frp.service"

# tokenが含まれる.envを配置するpath
ENV="/etc/frp"
# frp本体のディレクトリ
FPR="/usr/local/sbin"

# rootチェック
if [ "$(id -u)" -ne 0 ]; then
    echo "[Check:NG] Please run as root"
    exit 1
else
    echo "[Check:OK] Run as root"
fi

# 関連サービスの停止/無効化
if systemctl list-unit-files | grep -q "^${SERVICEFILE}"; then
    systemctl stop "$SERVICEFILE"
    systemctl disable "$SERVICEFILE"
else
    echo "[Check:WARN] Not found service ($SERVICEFILE)"
fi

# systemd用ファイルの削除
if [ -f "$SERVICEDIR/$SERVICEFILE" ]; then
    rm -f "$SERVICEDIR/$SERVICEFILE"
    echo "[Check:OK] Removed service file ($SERVICEDIR/$SERVICEFILE)"
else
    echo "[Check:WARN] Not found service file ($SERVICEDIR/$SERVICEFILE)"
fi

# frp本体の削除
if [ -d "$FPR/frp" ]; then
    rm -rf "$FPR/frp"
    echo "[Check:OK] Removed frp directory ($FPR/frp)"
else
    echo "[Check:WARN] Not found frp directory ($FPR/frp)"
fi

# .envの削除
if [ -f "$ENV/.env" ]; then
    rm -f "$ENV/.env"
    echo "[Check:OK] Removed .env ($ENV/.env)"
else
    echo "[Check:WARN] Not found .env ($ENV/.env)"
fi

# デーモンの再読み込み
systemctl daemon-reload
systemctl reset-failed

exit 0

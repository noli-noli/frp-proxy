## クライアントサイド(frpc)
### 0. セットアップ手順
セットアップは以下の順序で行う。
1. 環境変数の定義
2. 設定ファイルの修正
3. frpのバイナリをダウンロード
4. Daemonのセットアップ及び起動

### 1. 環境変数の定義
`.env` に*FRP_TOKEN*変数を定義しトークンを代入する。
動作環境に応じて、proxy設定等も設定する

### 2. 設定ファイルの修正
クライアントサイドの設定定義ファイル*frpc.toml*を修正する。
最低限以下の項目を修正する。
 - `serverAddr`   : frpsが動作するホストアドレスを記入する
 - `serverPort`   : frpsサービスがlistenしているポートを記述する
 - `name`         : クライアント側のサーバー名を定義する
 - `localPort`    : フォワード対象となるポート番号を指定する
 - `remotePort`   : サーバー側でlistenするポート番号を指定する

※ 他の項目は環境に応じて修正する必要がある。予め本リポジトリで提供している設定を既に記述しているため基本修正の必要はない。

### 3. frpのバイナリをダウンロード
`frp_downloader.sh` を実行する。このスクリプトの挙動としては以下の通り。
1. frp本体が含まれる圧縮ファイルダウンロードする
2. 圧縮ファイルを解凍する
3. 解凍したディレクトリの名称を`frp`に改名する
4. `frpc.toml` と `frps.toml` を解凍したディレクトリに配置する
5. 用済みとなった圧縮ファイルを削除する

### 4. Daemonのセットアップ及び起動
 `./systemd/client/` ディレクトリ内のファイル群を使ってセットアップする。*必ずカレントディレクトリをリポジトリ直下の `./systemd/client` に移動して作業すること*
1. `systemd` に移動する。
2. `sudo ./frp_install.sh` を実行する。
3. `systemctl status frp.service` で起動状態を確認する。

以下の様に`active:`がrunningになっており、自動起動設定である`Loaded:`がenabledになっていればok

```bash
● frp.service - frp tunnel service
     Loaded: loaded (/etc/systemd/system/frp.service; enabled; preset: enabled)
     Active: active (running) since Sun 2026-05-17 00:33:48 UTC; 1 month 11 days ago
```

## サーバーサイド(frps)

### 0. セットアップ手順
セットアップは以下の順序で行う。
1. 環境変数の定義
2. 設定ファイルの修正
3. frpのバイナリをダウンロード
4. Daemonのセットアップ及び起動

### 1. 環境変数の定義
`.env` に*FRP_TOKEN*変数を定義しトークンを代入する。
動作環境に応じて、proxy設定等も設定する

### 2. 設定ファイルの修正
サーバーサイドの設定定義ファイル*frps.toml*を修正する。
最低限以下の項目を修正する。
 - `bindPort`   : frpsサービスがlistenするポート番号を指定する

※ 他の項目は環境に応じて修正する必要がある。予め本リポジトリで提供している設定を既に記述しているため基本修正の必要はない。

### 3. frpのバイナリをダウンロード
`frp_downloader.sh` を実行する。このスクリプトの挙動としては以下の通り。
1. frp本体が含まれる圧縮ファイルダウンロードする
2. 圧縮ファイルを解凍する
3. 解凍したディレクトリの名称を`frp`に改名する
4. 「2」の手順で修正した`frpc.toml` と `frps.toml` を解凍したディレクトリに配置する
5. 用済みとなった圧縮ファイルを削除する

### 4. Daemonのセットアップ及び起動
 `./systemd/server/` ディレクトリ内のファイル群を使ってセットアップする。*必ずカレントディレクトリをリポジトリ直下の `./systemd/server` に移動して作業すること*
1. `systemd/server` に移動する。
2. `sudo ./frp_install.sh` を実行する。
3. `systemctl status frps.service` で起動状態を確認する。

以下の様に`active:`がrunningになっており、自動起動設定である`Loaded:`がenabledになっていればok

```bash
● frps.service - frps tunnel service
     Loaded: loaded (/etc/systemd/system/frps.service; enabled; preset: enabled)
     Active: active (running) since Sun 2026-05-17 00:33:48 UTC; 1 month 11 days ago
```

# frp-experimental

## 使い方

### 1. スタートアップ手順
1. `.env` にトークンを記述する。
2. 運用に応じて `frpc.toml`（クライアント）または `frps.toml`（ホスト）を適切に修正する。
   - クライアントの場合は `frpc.toml` の `serverAddr` / `serverPort` と `[[proxies]]` の `localIP` / `localPort` / `remotePort` を必要に応じて書き換える。
3. `frp_downloader.sh` を実行する（frp本体をダウンロードし、`frpc.toml` と `frps.toml` をダウンロードした本体内部のディレクトリに配置する）。

### 2. クライアント運用時のセットアップ
- クライアント運用の場合は `systemd` ディレクトリ内のファイル群を使ってセットアップする。
- 必ずカレントディレクトリをリポジトリ直下の `systemd` に移動して作業する。
1. `systemd` に移動する。
2. `sudo ./frp_install.sh` を実行する。
3. `systemctl status frp.service` で起動状態を確認する。

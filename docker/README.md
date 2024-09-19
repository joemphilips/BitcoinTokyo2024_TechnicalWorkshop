
## Test 用 Docker Compose


### コマンド

* `docker compose up` ... bitcoind を実行
* `docker compose down` ... 終了
* `./bitcoin-cli.sh help` ... 実行中の bitcoind に対する CLI 操作

データは、 `./bitcoin_datadir` 以下に置かれますので、状態をリセットしたいときはこれを消去してください
(docker の実行を停止してから消去することを忘れずに！)

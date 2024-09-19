#!/usr/env/bin bash

docker compose exec -it bitcoin bitcoin-cli -regtest -rpchost

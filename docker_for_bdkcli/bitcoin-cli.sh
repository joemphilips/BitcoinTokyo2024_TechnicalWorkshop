#!/usr/bin/env bash

docker compose exec -it bitcoind /opt/bitcoin/bin/bitcoin-cli -regtest -rpcport=43782 -rpcpassword=bar -rpcuser=foo $@

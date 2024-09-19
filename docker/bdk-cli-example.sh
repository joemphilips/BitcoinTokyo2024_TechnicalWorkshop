#!/usr/bin/env bash

set -eux

WALLET_NAME=alice


# xprv is created by
# bdk-cli --network=regtest key generate | jq .xprv | xargs -IXX bdk-cli key derive --xprv XX --path='m/84'/1'/0'/0'' | jq -r .xprv
xprv="[f28584ff/84/1/0/0]tprv8i7N25RiNQiRHptaDDZQbKSjnxNmQBicA2GSort2zTTBvQEMSSafTqu6NBj7SShX1wMdYPxpRKZzj2sBAdqyc9jJhV3qY2W8PHnhBdZ4721/*"

bdk_wallet(){
  bdk-cli --network=regtest wallet --descriptor="wpkh($xprv)" $@
}

./bitcoin-cli.sh createwallet $WALLET_NAME
bitcoind_address=$(./bitcoin-cli.sh -rpcwallet=$WALLET_NAME getnewaddress)
./bitcoin-cli.sh generatetoaddress 101 $bitcoind_address

bdk_address=$(bdk_wallet get_new_address | jq -r ".address")
./bitcoin-cli.sh -rpcwallet=$WALLET_NAME sendtoaddress  $bdk_address 5

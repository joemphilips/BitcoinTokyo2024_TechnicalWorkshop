#!/usr/bin/env bash

set -eux

NUNCHUK_VERSION=v1.9.37
TARGET_OS=linux

wget https://github.com/nunchuk-io/nunchuk-desktop/releases/download/1.9.37/nunchuk-${TARGET_OS}-${NUNCHUK_VERSION}.zip
wget https://github.com/nunchuk-io/nunchuk-desktop/releases/download/1.9.37/SHA256SUMS.asc
gpg --keyserver keyserver.ubuntu.com --recv-keys 0x8C8ECD3F660CA53CD878792A6E38A462ED2EF525

sha256sum --check --ignore-missing SHA256SUMS.asc || echo "Invalid checksum"; exit 1
gpg --verify SHA256SUMS.asc || echo "invalid signature"; exit 1

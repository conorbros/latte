#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $SCRIPT_DIR/..

cargo build --release

cp target/release/latte latte

# extract the crate version from Cargo.toml
CRATE_VERSION="$(cargo metadata --format-version 1 --offline --no-deps | jq -c -M -r '.packages[] | select(.name == "latte") | .version')"
tar -cvzf latte_${CRATE_VERSION}_amd64.tar.gz latte

rm -rf latte

#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $SCRIPT_DIR/..

cargo test --release
cargo build --release

# Make glibc version
mkdir -p latte
cp target/release/latte latte

# extract the crate version from Cargo.toml
CRATE_VERSION="$(cargo metadata --format-version 1 --offline --no-deps | jq -c -M -r '.packages[] | select(.name == "latte") | .version')"
tar -cvzf latte-linux_amd64-${CRATE_VERSION}.tar.gz latte/latte

rm -rf latte

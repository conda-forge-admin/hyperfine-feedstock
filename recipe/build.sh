#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CARGO_PROFILE_RELEASE_STRIP=symbols
export CARGO_PROFILE_RELEASE_LTO=fat

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

# build statically linked binary with Rust
cargo install --no-track --locked --root "$PREFIX" --path .

# Install the man page
mkdir -p "${PREFIX}/share/man/man1"
install -pm 0644 doc/hyperfine.1 "${PREFIX}/share/man/man1/hyperfine.1"

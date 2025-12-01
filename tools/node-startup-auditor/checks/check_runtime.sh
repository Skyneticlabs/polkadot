#!/bin/bash

if command -v polkadot >/dev/null 2>&1; then
    echo "[PASS] polkadot binary found"
else
    echo "[FAIL] polkadot binary missing"
fi

VERSION=$(polkadot --version 2>/dev/null)

echo "[INFO] Polkadot version: $VERSION"

if [[ "$VERSION" == *"parachain"* ]]; then
    echo "[PASS] parachain-compatible binary"
fi

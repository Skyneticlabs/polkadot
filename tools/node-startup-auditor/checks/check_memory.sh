#!/bin/bash

RAM_GB=$(grep MemTotal /proc/meminfo | awk '{print int($2/1024/1024)}')

if [ "$RAM_GB" -lt 32 ]; then
    echo "[FAIL] RAM too low (${RAM_GB}GB). Required >= 32GB"
else
    echo "[PASS] RAM OK (${RAM_GB}GB)"
fi

SWAP=$(swapon --show | wc -l)

if [ "$SWAP" -gt 0 ]; then
    echo "[WARN] Swap enabled. Recommended to disable"
else
    echo "[PASS] Swap disabled"
fi

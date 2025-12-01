#!/bin/bash

LIMIT=$(ulimit -n)

if [ "$LIMIT" -ge 1000000 ]; then
    echo "[PASS] nofile limit is $LIMIT"
else
    echo "[WARN] nofile limit is $LIMIT (expected >= 1000000)"
fi

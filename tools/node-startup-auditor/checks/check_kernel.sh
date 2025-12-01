#!/bin/bash

check_param() {
    local key=$1
    local expected=$2
    local current=$(sysctl -n "$key")

    if [ "$current" -ge "$expected" ]; then
        echo "[PASS] $key = $current"
    else
        echo "[WARN] $key = $current (expected >= $expected)"
    fi
}

check_param net.core.rmem_max 26214400
check_param net.core.wmem_max 26214400
check_param fs.inotify.max_user_watches 524288

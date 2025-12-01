#!/bin/bash

MOUNT=$(df -T /var/lib/polkadot | awk 'NR==2{print $2}')

if [[ "$MOUNT" =~ "ext4"|"xfs" ]]; then
    echo "[PASS] Filesystem OK ($MOUNT)"
else
    echo "[FAIL] Unsupported filesystem: $MOUNT"
fi

SSD=$(lsblk -d -o name,rota | grep -v "ROTA" | awk '{print $2}')

if [ "$SSD" -eq 0 ]; then
    echo "[PASS] SSD/NVMe detected"
else
    echo "[FAIL] Storage is HDD (rota=1)"
fi

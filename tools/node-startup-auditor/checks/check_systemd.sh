#!/bin/bash

SERVICE="/etc/systemd/system/polkadot.service"

[ -f "$SERVICE" ] \
    && echo "[PASS] systemd unit exists" \
    || { echo "[FAIL] systemd service not found"; exit 1; }

grep -q "Restart=always" $SERVICE \
    && echo "[PASS] Restart policy OK" \
    || echo "[WARN] Restart policy should be Restart=always"

grep -q "LimitNOFILE=1000000" $SERVICE \
    || echo "[WARN] LimitNOFILE should be >= 1000000"

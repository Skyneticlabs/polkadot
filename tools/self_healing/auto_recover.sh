#!/usr/bin/env bash

# -----------------------------------------
# Auto-Recovery Script for Polkadot Node
# -----------------------------------------

NODE_SERVICE="polkadot.service"   # systemd unit name
LOG_FILE="/var/log/self_healing.log"
HEALTH_SCRIPT="$(dirname "$0")/health_check.sh"
MAX_RESTARTS=5
RESTART_COUNT_FILE="/tmp/node_restart_count"

# Create restart count file if missing
[[ ! -f $RESTART_COUNT_FILE ]] && echo 0 > $RESTART_COUNT_FILE

timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

log() {
  echo "$(timestamp)  $1" | tee -a "$LOG_FILE"
}

# Run health check
bash "$HEALTH_SCRIPT"
STATUS=$?

if (( STATUS == 0 )); then
  log "Node is healthy — no action required."
  exit 0
fi

log "Health check failed (code $STATUS), initiating recovery..."

# Restart counter
COUNT=$(cat $RESTART_COUNT_FILE)
if (( COUNT >= MAX_RESTARTS )); then
  log "❌ Max restart limit reached ($MAX_RESTARTS). Manual intervention required."
  exit 1
fi

# Recovery actions depending on failure
case $STATUS in
  2)
    log "RPC failure detected — restarting node..."
    ;;
  3)
    log "Block stall detected — restarting node..."
    ;;
  4)
    log "Peer collapse detected — restarting node..."
    ;;
  5)
    log "High RPC latency — restarting node..."
    ;;
  *)
    log "Unknown issue — restarting node as fallback..."
    ;;
esac

systemctl restart "$NODE_SERVICE"
sleep 5

# Update restart counter
echo $((COUNT + 1)) > $RESTART_COUNT_FILE
log "Node restarted successfully. (Restart #$((COUNT + 1)))"

exit 0

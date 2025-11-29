#!/usr/bin/env bash

# -----------------------------------------
# Polkadot / Substrate Node Health Check
# -----------------------------------------

RPC_URL="http://127.0.0.1:9933"
MIN_PEERS=5
BLOCK_STALL_THRESHOLD=3
TMP_DIR="/tmp/node_health"
mkdir -p "$TMP_DIR"

# Get latest block
LATEST_BLOCK=$(curl -s -m 2 -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"chain_getHeader","params":[],"id":1}' \
  $RPC_URL | jq -r '.result.number' | sed 's/0x//')

if [[ -z "$LATEST_BLOCK" || "$LATEST_BLOCK" == "null" ]]; then
  echo "RPC_ERROR: Could not read block height"
  exit 2
fi

# Convert hex
LATEST_BLOCK_DEC=$((16#$LATEST_BLOCK))

# Save and compare previous block
PREV_FILE="$TMP_DIR/prev_block"
PREV_BLOCK=0
[[ -f $PREV_FILE ]] && PREV_BLOCK=$(cat $PREV_FILE)
echo $LATEST_BLOCK_DEC > $PREV_FILE

# Detect block stall
if (( LATEST_BLOCK_DEC <= PREV_BLOCK + BLOCK_STALL_THRESHOLD )); then
  echo "BLOCK_STALL: Node block height is not progressing"
  exit 3
fi

# Check peer count
PEERS=$(curl -s -m 2 $RPC_URL | jq '.result.peers | length')
if (( PEERS < MIN_PEERS )); then
  echo "LOW_PEERS: Peer count too low ($PEERS)"
  exit 4
fi

# Check RPC latency
START=$(date +%s%3N)
curl -s -m 2 $RPC_URL > /dev/null
END=$(date +%s%3N)
RTT=$((END - START))

if (( RTT > 1500 )); then
  echo "RPC_SLOW: RPC latency too high (${RTT}ms)"
  exit 5
fi

echo "OK: Node healthy | block=$LATEST_BLOCK_DEC peers=$PEERS rtt=${RTT}ms"
exit 0

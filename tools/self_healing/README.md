# 🛠 Self-Healing Node Scripts

Automated recovery toolkit for Polkadot/Substrate nodes.

**Self-Healing Node Scripts** continuously monitor node health, detect critical failures, and automatically restore normal operation with safe, deterministic recovery actions.  
Designed for validators and full-node operators who require high uptime and predictable behavior during chain congestion or networking issues.

---

## What It Detects

### **Frozen block height**
Identifies when the node stops producing or importing blocks.

### **Syncing stalls**
Detects stalled synchronization or halted block progression.

### **RPC degradation**
Flags timeouts, latency spikes, and unresponsive endpoints.

### **Peer-set collapse**
Catches low peer counts or sudden drops in connectivity.

### **DB lock issues**
Recognizes common RocksDB lockups and state corruption symptoms.

---

## Why This Matters

Stable validators depend on:

- consistent block import  
- healthy peer-set  
- responsive RPC  
- automatic recovery from minor failures  
- protection against node stalls during congestion  

These scripts reduce downtime and help maintain smooth, predictable operations.

---

## Features

- Automated health checks  
- Intelligent auto-recovery  
- systemd integration  
- Restart loop protection  
- Structured logging  
- Cron-compatible  
- Zero external dependencies (bash + curl + jq)

---

## 🔧 Installation

### Clone the repository:

```bash
git clone https://github.com/Skyneticlabs/polkadot
cd polkadot/tools/self_healing
```
### Make scripts executable:
```bash
chmod +x *.sh
```
## ▶️ Usage

### Run a manual node health check:
```bash
./health_check.sh
```

Outputs current block, peer count, latency, and health status.

### Run the auto-recovery routine:
```bash
./auto_recover.sh
```

Automatically performs:
- health check
- failure classification
- safe systemd node restart
- restart count tracking
- logging to /var/log/self_healing.log

### Enable full automation with cron:
```bash
crontab -e
```

### Add:
```bash
*/5 * * * * /usr/bin/bash /path/to/self_healing/auto_recover.sh >> /var/log/self_healing.log 2>&1
```
Runs recovery every 5 minutes.

## 📜 Scripts
#### health_check.sh

Performs:
- block progression analysis
- RPC status checks
- peer count verification
- latency measurement
- stall detection
Returns exit codes used by the recovery script.

#### auto_recover.sh

Handles:
- service restarts
- RPC failures
- stalled blocks
- peer collapse conditions
- restart limit enforcement
- timestamped logging

## 📤 Output Example
```bash
OK: Node healthy | block=18532012 peers=31 rtt=42ms
```
On failure:
```bash
BLOCK_STALL: Node block height is not progressing
```
Auto-recovery log entry:
```bash
2025-11-28 14:22:18  Block stall detected — restarting node...
```

## 📌 File Location
```bash
/tools/self_healing/
```

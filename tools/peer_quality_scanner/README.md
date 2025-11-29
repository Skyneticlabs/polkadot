# 🔍 Polkadot Peer Quality Scanner

High-fidelity peer quality analyzer for stable Polkadot nodes.

**Polkadot Peer Quality Scanner** is a lightweight diagnostic tool that evaluates the quality, stability, and predictability of peers connected to your node.  
It helps operators build a cleaner, more deterministic peer-set — a key factor for validator stability.

---

##  What It Measures

### **Peer stability**
Detects peers with frequent disconnects, unstable sessions, or excessive churn.

### **Block height deviation**
Finds peers lagging behind the chain or jumping ahead — both harmful for sync quality.

### **Latency variance**
Measures RTT distribution and flags peers with unpredictable latency spikes.

---

##  Why This Matters

A high-quality peer-set directly improves:

- sync reliability  
- block import smoothness  
- networking predictability  
- validation stability  
- resilience during chain congestion  

Polkadot networking is extremely sensitive to unstable or out-of-sync peers — this scanner helps operators avoid them.

---

##  Features

- CLI mode & JSON output  
- Live metrics for dashboards  
- Peer scoring & automatic classification  
- Configurable thresholds  
- Supports validator & full node setups  

---

## 🔧 Installation

### Clone the repository:

```bash
git clone https://github.com/Skyneticlabs/polkadot
cd polkadot/tools/peer_quality_scanner
```

### Install dependencies:

```bash
pip install requests
```

### Make the script executable:

```bash
chmod +x peer_quality_scanner.py
```

## ▶️ Usage

### Run the scanner:

```bash
./peer_quality_scanner.py
```
### Or explicitly with Python:

```bash
python3 peer_quality_scanner.py
```
### By default, it uses:

```bash
RPC_URL = http://127.0.0.1:9933
```
### To test a remote node:

```bash
RPC_URL="http://YOUR_NODE_IP:9933" python3 peer_quality_scanner.py
```

## 📤 Output Example

```bash
12D3KooWQv...  | score=89.3 | heightΔ=2 | rtt=34.2 ms
12D3KooWXd...  | score=41.7 | heightΔ=152 | rtt=210.5 ms
...
```
### JSON output:

```bash
[
  {
    "peer_id": "12D3KooW...",
    "best_number": 18551234,
    "height_deviation": 2,
    "latency_rtt_ms": 34.2,
    "score": 89.3,
    "stable": true
  }
]
```

## 📌 File Location
```bash
/tools/peer_quality_scanner/peer_quality_scanner.py
```

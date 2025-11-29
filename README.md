# SkyneticLabs 🔸 Polkadot Node Reliability Toolkit

A collection of tools, audits, and automation scripts designed to improve the
stability, resilience, and operational safety of Polkadot validator and full nodes.

Our focus is practical, operator-oriented reliability: peer quality, startup audits,
self-healing infrastructure, verified snapshots, latency analytics, and DN-specific tooling.

---

##  Overview

Skynetic Labs maintains several open-source tools and public services used by node
operators across the Polkadot ecosystem, including:

- **Peer Quality Scanner** — stable peer-set building  
- **Node Startup Auditor** — pre-launch configuration verification  
- **Self-Healing Node Scripts** — automatic recovery for stuck or degraded nodes  
- **Mainnet Snapshot Hub** — verified archives for fast and safe node initialization  
- **Public RPC/WS endpoints** — reliable data sources for validation and debugging  
- **DN-oriented Tools** — latency matrices, replay analyzers, integrity probes  

Our mission is to reduce operational errors, increase uptime, and provide pragmatic,
field-tested utilities for Polkadot operators.

---

#  Tools & Utilities

## 1. Polkadot Peer Quality Scanner  
_Analyze peer stability, height deviation, and latency variance_

A CLI tool and metrics collector that evaluates peer-set quality and helps node
operators maintain predictable, high-quality connections.

✔ Detect unstable peers  
✔ Compare block height deviation  
✔ Measure latency variance  
✔ Build a deterministic, clean peer-set

**Repo:** https://github.com/Skyneticlabs/polkadot  
**Tool location:** [`tools/peer_quality_scanner`](https://github.com/Skyneticlabs/polkadot/tree/main/tools/peer_quality_scanner)

---

## 2. Node Startup Auditor  
_Pre-launch system audit for new node deployments_

A checklist-driven auditor that inspects:

- `systemd` unit correctness  
- kernel parameters  
- memory limits  
- storage configuration  
- file descriptor limits  
- recommended runtime settings  

Prevents common deployment mistakes and provides **pass/fail** before the node starts.

**Docs:**  
https://skyneticlabs.gitbook.io/docs/services/mainnet-networks/polkadot

---

## 3. Mainnet Snapshot Hub  
_Verified archives for fast bootstrap & disaster recovery_

We maintain public verified snapshots:

- archive  
- pruned  
- fast-restore bundles  

Ensures safe initialization without corrupted or outdated data sources.

**Link:**  
https://mainnet-snapshot.skyneticlabs.com/mainnet/

---

## 4. Self-Healing Node Scripts  
_Automated recovery for stuck nodes, RPC failures, or peer loss_

Our automation scripts detect and repair:

- frozen block height  
- syncing stalls  
- RPC degradation  
- peer-set collapse  
- DB lock issues  

Designed for safe production environments with minimal operator intervention.

**Repo:** https://github.com/Skyneticlabs/polkadot
**Tool location:** [`tools/self_healing`](https://github.com/Skyneticlabs/polkadot/tree/main/tools/self_healing)

---

## 5. Public RPC / WS Endpoints  
_Rate-limited, stable public infrastructure_

Useful for:

- cross-checking node height  
- debugging issues  
- verifying app-hash consistency  
- providing safe reference endpoints during incident response

**Docs:**  
https://skyneticlabs.gitbook.io/docs/services/mainnet-networks/polkadot

---

# 🟦 DN-Focused Tools

## DN Operator Latency Matrix  
Global RTT map across regions and ASNs.  
Helps operators choose optimal node placement and understand interregional propagation.

---

## Consensus Replay Footprint Analyzer  
Stress-tests hardware under replay-heavy workloads:

- CPU saturation  
- NVMe performance  
- DB lock contention  
- replay throughput  

Gives realistic expectations of node behavior under heavy chain events.

---

## DN Chain Integrity Probe  
Validator-focused integrity verifier:

- app-hash checks  
- height comparison  
- independent RPC cross-verification  
- early DB drift detection  

Designed for continuous validator safety monitoring.

---

# 🚀 Future Plans

- Web dashboard for Peer Quality Scanner  
- Multi-chain support (Kusama, AssetHub, Collectives)  
- Extended DN Integrity Suite with alerting  
- Self-Healing v2 with templated recovery flows  
- Distributed latency measurement mesh  
- Automatic replay benchmarking pipeline  

---

# 🤝 Contributions

We welcome PRs, issues, and discussions from ecosystem operators and developers.  
If you're using our tools or want to collaborate — feel free to open an issue or contact us.

---


Made with 🔸 by **Skynetic Labs**  
Dedicated to improving reliability across the Polkadot Network.

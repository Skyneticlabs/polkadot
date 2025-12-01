# Polkadot Node Startup Auditor

A lightweight checklist-based auditor for validating system configuration before starting a Polkadot or Kusama node.

This tool prevents common deployment mistakes and provides a clear PASS/FAIL output before the node starts.

---

## Features

✔ systemd unit inspection  
✔ kernel parameter validation  
✔ memory & swap checks  
✔ storage and filesystem validation (SSD/NVMe required)  
✔ file descriptor limits  
✔ runtime validation (binary, version)  
✔ machine-readable report (`report/auditor.log`)  

---

## Repository Structure

```
node-startup-auditor/
│
├── auditor.sh               
├── checks/
│   ├── check_systemd.sh
│   ├── check_kernel.sh
│   ├── check_memory.sh
│   ├── check_storage.sh
│   ├── check_limits.sh
│   └── check_runtime.sh
│
└── report/                   # Logs
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/Skyneticlabs/polkadot.git
cd polkadot/tools/node-startup-auditor
chmod +x auditor.sh
```

---

## Usage

Run auditor:

```bash
sudo ./auditor.sh
```

A full report will be saved here:

```
report/auditor.log
```

---

## Example Output

```
[PASS] systemd unit exists
[PASS] Restart policy OK
[WARN] LimitNOFILE below recommended (should be >= 1000000)
[FAIL] /var/lib/polkadot is not on SSD/NVMe
[PASS] RAM OK (64GB)
[PASS] Swap disabled

Final Result: FAIL
```

---

## Requirements

| Component | Minimum | Recommended |
|----------|----------|-------------|
| CPU | 4 cores | 8+ cores |
| RAM | 16GB | 32–64GB |
| Storage | 500GB SSD | 1TB NVMe |
| Filesystem | ext4/xfs | ext4 |
| LimitNOFILE | 500k | 1M+ |
| Swap | allowed | disabled |

---

## CI/CD Integration

### GitHub Actions

```yaml
- name: Run Polkadot Node Startup Auditor
  run: sudo ./auditor.sh
```

### Ansible

```yaml
- name: Run auditor
  script: auditor.sh
```

### Terraform

```hcl
provisioner "remote-exec" {
  script = "auditor.sh"
}
```

---

## Contributions

Pull requests improving the checks or adding new modules are welcome.

---

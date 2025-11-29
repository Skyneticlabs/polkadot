#!/usr/bin/env python3
import requests
import json
import subprocess

RPC_URL = "http://127.0.0.1:9933"   # Your node RPC endpoint


def rpc(method, params=[]):
    """Perform RPC call."""
    try:
        r = requests.post(
            RPC_URL,
            json={"jsonrpc": "2.0", "id": 1, "method": method, "params": params},
            timeout=3
        )
        return r.json().get("result")
    except Exception:
        return None


def ping(host):
    """Ping peer host and return avg RTT."""
    try:
        out = subprocess.check_output(
            ["ping", "-c", "3", host],
            stderr=subprocess.STDOUT,
            universal_newlines=True
        )
        for line in out.split("\n"):
            if "avg" in line or "rtt" in line:
                return float(line.split("/")[4])
    except Exception:
        return None


def local_height():
    """Get local node height."""
    h = rpc("chain_getHeader")
    return int(h["number"], 16) if h else None


def analyze_peer(peer, best):
    """Analyze one peer."""
    result = {
        "peer_id": peer.get("peerId"),
        "endpoint": peer.get("endpoint"),
        "best_number": peer.get("bestNumber"),
        "height_deviation": None,
        "latency_rtt_ms": None,
        "score": 0,
        "stable": True,
    }

    # Height deviation
    if peer.get("bestNumber"):
        ph = int(peer["bestNumber"])
        result["height_deviation"] = abs(best - ph)
    else:
        result["height_deviation"] = 9999

    # Latency
    if result["endpoint"]:
        host = result["endpoint"].replace("/ip4/", "").split("/")[0]
        result["latency_rtt_ms"] = ping(host)

    # Stability rules
    if result["height_deviation"] > 128:
        result["stable"] = False
    if result["latency_rtt_ms"] and result["latency_rtt_ms"] > 200:
        result["stable"] = False

    # Scoring
    score = 100
    score -= result["height_deviation"] * 0.2
    if result["latency_rtt_ms"]:
        score -= result["latency_rtt_ms"] * 0.1
    if not result["stable"]:
        score -= 20

    result["score"] = round(max(score, 0), 2)
    return result


def main():
    print("🔍 Fetching peers...")
    peers = rpc("system_peers")
    best = local_height()

    if not peers or not best:
        print("❌ Cannot fetch peers or height. Check RPC_URL.")
        return

    results = []

    for peer in peers:
        r = analyze_peer(peer, best)
        results.append(r)
        print(
            f"{r['peer_id']} | score={r['score']} | heightΔ={r['height_deviation']} | rtt={r['latency_rtt_ms']} ms"
        )

    print("\n=== JSON Output ===")
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()

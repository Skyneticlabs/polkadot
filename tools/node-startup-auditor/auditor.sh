#!/bin/bash
set -e

REPORT="report/auditor.log"
mkdir -p report
: > $REPORT

log() {
    echo "$1" | tee -a $REPORT
}

header() {
    echo "" | tee -a $REPORT
    echo "### $1 ###" | tee -a $REPORT
}

run_check() {
    bash checks/$1.sh | tee -a $REPORT
}

header "Polkadot Node Startup Auditor"

run_check check_systemd
run_check check_kernel
run_check check_memory
run_check check_storage
run_check check_limits
run_check check_runtime

echo "" | tee -a $REPORT
echo "Audit finished. Report saved to $REPORT"

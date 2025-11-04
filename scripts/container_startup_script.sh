#!/bin/bash
set -euo pipefail

export TERM="xterm-256color"

if [ -f /tmp/cert.pem ]; then
    CERT_DIR="/usr/local/share/ca-certificates"
    cp /tmp/cert.pem "$CERT_DIR/custom-cert.crt"
    update-ca-certificates
fi




#!/usr/bin/env bash
set -euo pipefail

# SeaBee must be shut down and its protections unloaded before uninstalling.
rm -r /etc/seabee
rm /usr/sbin/seabeectl
rm /usr/sbin/seabee
rm /etc/systemd/system/seabee.service
systemctl daemon-reload
echo "Seabee has been uninstalled."

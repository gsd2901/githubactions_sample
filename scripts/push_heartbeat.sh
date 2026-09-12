#!/usr/bin/env bash
# Runs on a timer via launchd. Appends a timestamp to heartbeat/heartbeat.log,
# commits, and pushes -- which triggers the "Heartbeat Comment" GitHub Action.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

LOG_DIR="$REPO_DIR/heartbeat"
mkdir -p "$LOG_DIR"
LOGFILE="$LOG_DIR/heartbeat.log"

TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
echo "${TS}  heartbeat from $(hostname)" >> "$LOGFILE"

git add "$LOGFILE"

if git diff --cached --quiet; then
  echo "$(date -u +"%Y-%m-%dT%H:%M:%SZ") nothing to commit, skipping" 
  exit 0
fi

git commit -m "heartbeat: ${TS}" --quiet
git pull --rebase --autostash origin main --quiet || true
git push origin main --quiet

echo "${TS} pushed heartbeat"

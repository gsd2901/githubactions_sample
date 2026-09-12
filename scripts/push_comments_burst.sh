#!/usr/bin/env bash
# Pushes the 6 NAAC-style test comments in order, 15s apart, within ~2 minutes.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

FILES=(
  comments/01_checklist.md
  comments/02_catalog_pr.md
  comments/03_config_preview.md
  comments/04_lab_postcheck.md
  comments/05_prod_postcheck.md
  comments/06_infoblox_usage.md
)
INTERVAL=15
START_TS=$(date +%s)
TOTAL=${#FILES[@]}

for i in "${!FILES[@]}"; do
  f="${FILES[$i]}"
  n=$((i + 1))

  ELAPSED=$(( $(date +%s) - START_TS ))
  if [ "$ELAPSED" -ge 115 ]; then
    echo "Hit the 2-minute budget after $((n - 1)) comments, stopping."
    break
  fi

  cp "$f" comments/current.md
  git add comments/current.md

  if git diff --cached --quiet; then
    echo "comment $n/$TOTAL identical to last push, skipping"
  else
    git commit -m "push comment $n/$TOTAL: $(basename "$f")" --quiet
    git pull --rebase --autostash origin main --quiet || true
    git push origin main --quiet
    echo "$(date -u +"%Y-%m-%dT%H:%M:%SZ") pushed comment $n/$TOTAL ($f)"
  fi

  if [ "$n" -lt "$TOTAL" ]; then
    sleep "$INTERVAL"
  fi
done

echo "Done in $(( $(date +%s) - START_TS ))s"

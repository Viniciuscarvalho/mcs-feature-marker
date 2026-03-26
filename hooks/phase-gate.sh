#!/bin/bash
# phase-gate.sh — UserPromptSubmit hook
# Checks for active feature-marker checkpoints and reminds Claude to
# stay on track with the current phase.

set -euo pipefail

PROJECT_DIR="${PWD}"
STATE_DIR="${PROJECT_DIR}/.claude/feature-state"

# Only run if feature-state directory exists
[ -d "$STATE_DIR" ] || exit 0

# Find the most recent checkpoint
LATEST_CHECKPOINT=$(find "$STATE_DIR" -name "checkpoint.json" -maxdepth 2 2>/dev/null | head -1)
[ -n "$LATEST_CHECKPOINT" ] || exit 0

# Read checkpoint info
FEATURE_DIR=$(dirname "$LATEST_CHECKPOINT")
FEATURE_NAME=$(basename "$FEATURE_DIR")

PHASE=$(python3 -c "
import json, sys
try:
    d = json.load(open('$LATEST_CHECKPOINT'))
    phase = d.get('current_phase', 0)
    status = d.get('phase_status', 'unknown')
    if status == 'in_progress':
        names = {0: 'Inputs Gate', 1: 'Analysis', 2: 'Implementation', 3: 'Tests', 4: 'Commit & PR'}
        print(f'{names.get(phase, \"Phase \" + str(phase))} (in progress)')
    else:
        print('')
except:
    print('')
" 2>/dev/null || echo "")

# Only remind if there's an active (in-progress) phase
if [ -n "$PHASE" ]; then
  cat <<EOF

📍 Active feature: $FEATURE_NAME — $PHASE
   Use /resume to continue or /feature $FEATURE_NAME to restart.

EOF
fi

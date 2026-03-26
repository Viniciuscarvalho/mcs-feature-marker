#!/bin/bash
# session-context.sh — SessionStart hook
# Detects tech stack, git platform, checks CLAUDE.md, and prints feature-marker context.

set -euo pipefail

PROJECT_DIR="${PWD}"

# ── Detect tech stack ─────────────────────────────────────────────────────────
detect_stack() {
  local stacks=()

  # iOS / Swift
  if [ -f "$PROJECT_DIR/Package.swift" ] || find "$PROJECT_DIR" -maxdepth 2 -name "*.xcodeproj" 2>/dev/null | grep -q .; then
    stacks+=("iOS/Swift")
  fi

  # Node.js / TypeScript
  if [ -f "$PROJECT_DIR/package.json" ]; then
    local pm="npm"
    [ -f "$PROJECT_DIR/pnpm-lock.yaml" ] && pm="pnpm"
    [ -f "$PROJECT_DIR/yarn.lock" ] && pm="yarn"
    [ -f "$PROJECT_DIR/bun.lockb" ] && pm="bun"

    local subtype="Node.js"
    [ -f "$PROJECT_DIR/next.config.js" ] || [ -f "$PROJECT_DIR/next.config.ts" ] || [ -f "$PROJECT_DIR/next.config.mjs" ] && subtype="Next.js"
    stacks+=("${subtype} (${pm})")
  fi

  # Rust
  [ -f "$PROJECT_DIR/Cargo.toml" ] && stacks+=("Rust")

  # Go
  [ -f "$PROJECT_DIR/go.mod" ] && stacks+=("Go")

  # Python
  if [ -f "$PROJECT_DIR/pyproject.toml" ] || [ -f "$PROJECT_DIR/requirements.txt" ] || [ -f "$PROJECT_DIR/setup.py" ]; then
    stacks+=("Python")
  fi

  # Ruby
  [ -f "$PROJECT_DIR/Gemfile" ] && stacks+=("Ruby")

  # .NET
  if find "$PROJECT_DIR" -maxdepth 2 -name "*.csproj" -o -name "*.sln" 2>/dev/null | head -1 | grep -q .; then
    stacks+=(".NET/C#")
  fi

  # JVM
  [ -f "$PROJECT_DIR/build.gradle" ] || [ -f "$PROJECT_DIR/build.gradle.kts" ] && stacks+=("Kotlin/JVM")
  [ -f "$PROJECT_DIR/pom.xml" ] && stacks+=("Java/Maven")

  # Other
  [ -f "$PROJECT_DIR/composer.json" ] && stacks+=("PHP")
  [ -f "$PROJECT_DIR/pubspec.yaml" ] && stacks+=("Dart/Flutter")

  if [ ${#stacks[@]} -eq 0 ]; then
    echo "Unknown"
  elif [ ${#stacks[@]} -eq 1 ]; then
    echo "${stacks[0]}"
  else
    local IFS=" + "
    echo "${stacks[*]}"
  fi
}

# ── Detect git platform ──────────────────────────────────────────────────────
detect_git_platform() {
  local remote_url
  remote_url=$(git remote get-url origin 2>/dev/null || echo "")

  if [ -z "$remote_url" ]; then
    echo "No remote"
    return
  fi

  case "$remote_url" in
    *github.com*)       echo "GitHub" ;;
    *dev.azure.com*|*visualstudio.com*) echo "Azure DevOps" ;;
    *gitlab.com*)       echo "GitLab" ;;
    *bitbucket.org*)    echo "Bitbucket" ;;
    *)                  echo "Generic" ;;
  esac
}

# ── Check CLAUDE.md ──────────────────────────────────────────────────────────
check_claude_md() {
  if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    echo "loaded (project root)"
  elif [ -f "$PROJECT_DIR/.claude/CLAUDE.md" ]; then
    echo "loaded (.claude/)"
  elif [ -f "$PROJECT_DIR/CLAUDE.local.md" ]; then
    echo "loaded (CLAUDE.local.md)"
  else
    echo "not found — using stack defaults"
  fi
}

# ── Check for active checkpoint ──────────────────────────────────────────────
check_checkpoint() {
  local state_dir="${PROJECT_DIR}/.claude/feature-state"
  if [ -d "$state_dir" ]; then
    local latest
    latest=$(find "$state_dir" -name "checkpoint.json" -maxdepth 2 2>/dev/null | head -1)
    if [ -n "$latest" ]; then
      local feature_dir
      feature_dir=$(dirname "$latest")
      local feature_name
      feature_name=$(basename "$feature_dir")
      local phase
      phase=$(python3 -c "import json; d=json.load(open('$latest')); print(f'Phase {d.get(\"current_phase\",\"?\")}')" 2>/dev/null || echo "unknown")
      echo "${feature_name} at ${phase}"
      return
    fi
  fi
  echo "none"
}

# ── Git context ───────────────────────────────────────────────────────────────
git_branch() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git branch --show-current 2>/dev/null || echo "detached"
  else
    echo "not a git repo"
  fi
}

# ── Print context ─────────────────────────────────────────────────────────────
STACK=$(detect_stack)
PLATFORM=$(detect_git_platform)
BRANCH=$(git_branch)
CLAUDE_STATUS=$(check_claude_md)
CHECKPOINT=$(check_checkpoint)

cat <<EOF

🏗️ Feature Marker — Session Start
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Stack:      $STACK
Git:        $PLATFORM | Branch: $BRANCH
CLAUDE.md:  $CLAUDE_STATUS
Checkpoint: $CHECKPOINT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

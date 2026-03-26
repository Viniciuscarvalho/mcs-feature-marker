# mcs-feature-marker

MCS techpack for [Feature Marker](https://github.com/Viniciuscarvalho/Feature-marker) — automates feature development from requirements to pull request.

## What It Does

End-to-end feature development orchestrator with a 5-phase workflow:

1. **Inputs Gate** — validates/generates PRD, Tech Spec, and Tasks
2. **Analysis & Planning** — reads docs, creates implementation plan
3. **Implementation** — executes tasks with progress tracking
4. **Tests & Validation** — runs platform-appropriate test suites
5. **Commit & PR** — professional commits + auto-creates pull request

## Stack Support

Auto-detects your project's tech stack and adapts the entire workflow:

| Stack      | Test                    | Lint            | Build             |
| ---------- | ----------------------- | --------------- | ----------------- |
| iOS/Swift  | `swift test --parallel` | `swiftlint`     | `xcodebuild`      |
| Node.js/TS | `jest` / `vitest`       | `{pm} run lint` | `{pm} run build`  |
| Rust       | `cargo test`            | `cargo clippy`  | `cargo build`     |
| Python     | `pytest -v`             | `ruff check .`  | `python -m build` |
| Go         | `go test ./...`         | `go vet ./...`  | `go build ./...`  |

## Installation

```bash
# Install MCS (if not already)
brew install mcs-cli/tap/mcs

# Add the techpack
mcs pack add Viniciuscarvalho/mcs-feature-marker

# Go to your project and sync
cd ~/Developer/your-project
mcs sync
```

## Setup Prompts

During `mcs sync`, you'll be asked:

1. **Execution mode** — `full` (default), `tasks-only`, `spec-driven`, `test-only`
2. **Documents path** — where feature docs are stored (default: `./tasks`)
3. **Review style** — `standard` or `strict` (multi-agent review)
4. **Auto-install** — auto-install missing dependencies (default: `yes`)

## Commands

| Command           | Description                                |
| ----------------- | ------------------------------------------ |
| `/feature <slug>` | Start or resume a feature workflow         |
| `/spec <slug>`    | Spec-driven mode with multi-agent review   |
| `/resume`         | Resume from most recent checkpoint         |
| `/review`         | Stack-aware code review checklist          |
| `/commit`         | Professional commit with pre-commit checks |

## Execution Modes

- **Full Workflow** — generate missing artifacts + all 5 phases
- **Tasks Only** — skip generation, use existing docs
- **Spec-Driven** — multi-agent spec review + worktree isolation
- **Test Only** — run tests phase exclusively
- **Ralph Loop** — autonomous self-correcting execution

## Features

- **Checkpoint & Resume** — save/restore progress at any phase
- **CLAUDE.md Integration** — reads project conventions as source of truth
- **Multi-Agent Spec Review** — 6 built-in reviewer personas + 5 custom personas
- **Platform Detection** — auto-detects GitHub, Azure DevOps, GitLab, Bitbucket
- **Smart File Generation** — only generates what's missing, never overwrites

## Composability

Works alongside other MCS techpacks:

```bash
mcs pack add Viniciuscarvalho/mcs-pair-programming   # Pair programming
mcs pack add Viniciuscarvalho/mcs-feature-marker      # Feature workflow
mcs sync
```

Both techpacks complement each other — pair programming for real-time guidance, feature-marker for structured workflows.

## Project Structure

```
mcs-feature-marker/
├── techpack.yaml                          # MCS manifest
├── skills/feature-marker/
│   ├── SKILL.md                           # Core skill definition
│   └── references/
│       ├── stack-checklists.md            # Per-stack review gates
│       ├── stack-patterns/                # Stack-specific patterns
│       │   ├── swift.md
│       │   ├── react.md
│       │   └── python.md
│       └── spec-workflow/personas/        # Custom reviewer personas
│           ├── firebase-cost-reviewer.md
│           ├── api-security-reviewer.md
│           ├── ios-performance-reviewer.md
│           ├── payment-flow-reviewer.md
│           └── data-migration-reviewer.md
├── hooks/
│   ├── session-context.sh                 # Stack + platform detection on start
│   └── phase-gate.sh                      # Checkpoint reminder
├── commands/
│   ├── feature.md                         # /feature command
│   ├── spec.md                            # /spec command
│   ├── resume.md                          # /resume command
│   ├── review.md                          # /review command
│   └── commit.md                          # /commit command
├── config/
│   └── settings.json                      # Plan mode + thinking
└── templates/
    └── feature-marker.md                  # CLAUDE.local.md template
```

## Configuration

Override behavior per-project via `.feature-marker.json`:

```json
{
  "docs_path": "./tasks",
  "state_path": ".claude/feature-state",
  "test_command": "npm run test:ci",
  "platform": "ios",
  "skip_pr": false
}
```

## Relationship to Feature Marker

This techpack is the **MCS distribution** of Feature Marker. The original [Feature Marker repo](https://github.com/Viniciuscarvalho/Feature-marker) continues to be maintained independently with its full CLI, TUI, and macOS menubar apps. This techpack provides the same core workflow adapted to the MCS format for plug-and-play integration.

## License

MIT

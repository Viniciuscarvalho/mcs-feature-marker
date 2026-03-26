# /feature — Start or Resume Feature Workflow

Start a new feature workflow or resume an existing one from checkpoint.

## Usage

```
/feature <slug>                    # Start with default mode (full)
/feature <slug> --mode full        # Full workflow
/feature <slug> --mode tasks-only  # Tasks only (skip generation)
/feature <slug> --mode test-only   # Run tests only
/feature <slug> --mode spec-driven # Multi-agent spec review
```

## Behavior

When invoked:

1. **Check for existing checkpoint** in `.claude/feature-state/<slug>/`:
   - If found → show progress and ask: Resume or Start Fresh?
   - If not found → start new workflow

2. **Detect execution mode** from argument or prompt user:
   - `full` (default) — generate missing files + all 5 phases
   - `tasks-only` — use existing files, skip generation
   - `spec-driven` — multi-agent review + worktree isolation
   - `test-only` — run Phase 3 exclusively

3. **Run the 5-phase workflow**:
   - Phase 0: Inputs Gate — validate/generate PRD, TechSpec, Tasks
   - Phase 1: Analysis & Planning
   - Phase 2: Implementation
   - Phase 3: Tests & Validation
   - Phase 4: Commit & PR

4. **Checkpoint after each phase** — work can be resumed if interrupted.

## Important

- Feature documents are stored in `{docs_path}/prd-<slug>/`
- State is persisted in `.claude/feature-state/<slug>/`
- Existing files are never overwritten
- User's existing tools/skills always have priority over auto-installed ones

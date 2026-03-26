# /spec — Spec-Driven Development Mode

Run the spec-driven workflow with multi-agent review and worktree isolation.

## Usage

```
/spec <slug>                    # Start spec-driven workflow
/spec <slug> --personas         # Setup/install reviewer personas first
```

## Behavior

When invoked:

1. **Check for existing spec or PRD** in `{docs_path}/prd-<slug>/`:
   - If no PRD → invoke `/idea-explorer` for collaborative refinement
   - If PRD exists → use as input for spec generation

2. **Generate spec with multi-agent review**:
   - Invoke `/spec-orchestrator`
   - 2-6 reviewer personas evaluate the spec
   - Iterative feedback/revision cycle
   - Auto-approval at consensus threshold (default: 80%)

3. **Create isolated worktree**:
   - New branch for safe development
   - Spec copied to worktree

4. **Convert spec to Feature-Marker format**:
   - Extract sections from approved spec
   - Generate `prd.md`, `techspec.md`, `tasks.md`

5. **Execute standard phases** (Implementation → Tests → Commit & PR)

## Built-in Reviewer Personas

- **Pragmatic Architect** — design & maintainability
- **Paranoid Engineer** — edge cases & failure modes
- **Operator** — operational concerns & monitoring
- **Simplifier** — challenges unnecessary complexity
- **User Advocate** — user experience
- **Product Strategist** — product alignment

## Custom Personas

Install additional personas with `--personas`:

- Firebase Cost Reviewer
- iOS Performance Reviewer
- API Security Reviewer
- Payment Flow Reviewer
- Data Migration Reviewer

Custom personas are stored in `.claude/spec-workflow/personas/`.

## Configuration

Configure via `.claude/spec-workflow/config.yaml`:

```yaml
review:
  maxIterations: 3
  autoApproveThreshold: 0.8
execution:
  batchSize: 5
```

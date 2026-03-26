# /resume — Resume Feature from Checkpoint

Resume a paused or interrupted feature workflow from the last saved checkpoint.

## Usage

```
/resume                # Resume most recent feature
/resume <slug>         # Resume specific feature
```

## Behavior

When invoked:

1. **Find checkpoints** in `.claude/feature-state/`:
   - If `<slug>` provided → look for that specific feature
   - If no argument → find most recently updated checkpoint

2. **Display current state**:

   ```
   📍 Feature: prd-user-authentication
      Phase: 2 (Implementation) — Task 3/8
      Last updated: 2026-01-19T10:30:00Z

      Resume from this checkpoint? [Y/n]
   ```

3. **On resume**:
   - Load checkpoint state
   - Restore platform context
   - Continue from current phase + task index
   - Re-read CLAUDE.md for any convention updates

4. **On start fresh**:
   - Archive old checkpoint
   - Begin new workflow from Phase 0

## Important

- Checkpoints are saved automatically after each task/phase completion
- If checkpoint is corrupted, offer to reset or repair
- Platform context is re-validated on resume (stack may have changed)

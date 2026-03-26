# /review — Stack-Aware Code Review

Run the full code review checklist against current changes, adapted to the detected tech stack.

## Behavior

When invoked:

1. **Identify changed files** — use `git diff --name-only` (staged + unstaged).
2. **Detect the stack** — from changed files and project markers.
3. **Load CLAUDE.md** — read project conventions.
4. **Run the universal checklist** (10 items) against the diff.
5. **Run the stack-specific checklist** for the detected language.
6. **Run CLAUDE.md-specific checks** — any custom rules defined in the project.
7. **Report findings** using the signal system.

## Output Format

```
🔍 Code Review — [N files changed]

Universal:
  🟢 Naming: consistent with project conventions
  🟢 Error handling: all errors handled
  🔴 Edge case: `processItems` doesn't handle empty array
  🟡 Complexity: `calculateTotal` could extract tax logic

Stack (Swift/iOS):
  🟢 No force unwraps
  🔴 Retain cycle: closure in `fetchData` captures self strongly
  🟢 Accessibility labels present

CLAUDE.md:
  ⚡ Line 23: uses `if let` but CLAUDE.md requires `guard let` for early returns
  🟢 Architecture: follows MVVM pattern

Result: 2 issues to fix, 1 suggestion
```

## Signal Words

| Signal            | Meaning                             |
| ----------------- | ----------------------------------- |
| 🟢 **Pass**       | Item satisfied                      |
| 🟡 **Suggestion** | Optional improvement, non-blocking  |
| 🔴 **Issue**      | Must be fixed before commit         |
| ⚡ **CLAUDE.md**  | Convention violation from CLAUDE.md |

## Important

- Only flag items relevant to actual changes, not the entire codebase
- One line per item — be thorough but concise
- After listing issues, offer to help fix them
- If no issues found, confirm with a clean summary

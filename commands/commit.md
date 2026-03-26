# /commit — Professional Commit Workflow

Create well-formatted commits with platform-aware pre-commit checks and conventional commit messages.

## Usage

```
/commit              # Run pre-commit checks + commit
/commit --no-verify  # Skip pre-commit checks
```

## Behavior

1. **Detect project platform** and run pre-commit checks:

   | Platform  | Lint                               | Build                                     |
   | --------- | ---------------------------------- | ----------------------------------------- |
   | iOS/Swift | `swiftlint` (if installed)         | `xcodebuild` (if XcodeBuildMCP available) |
   | Node.js   | `{pm} run lint` (if script exists) | `{pm} run build` (if script exists)       |
   | Rust      | `cargo clippy -- -D warnings`      | `cargo build`                             |
   | Python    | `ruff check .` / `flake8`          | `python -m build` (if pyproject.toml)     |
   | Go        | `go vet ./...`                     | `go build ./...`                          |

2. **Check staged files** — if none staged, auto-stage all modified files.
3. **Analyze diff** for logical changes.
4. **Split if needed** — suggest separate commits for distinct concerns.
5. **Create commit** with emoji conventional commit format:
   - `feat`: New feature
   - `fix`: Bug fix
   - `docs`: Documentation
   - `refactor`: Code refactoring
   - `test`: Tests
   - `chore`: Tooling/config
   - `perf`: Performance

## Examples

```
✨ feat: add user authentication system
🐛 fix: resolve memory leak in rendering process
📝 docs: update API documentation with new endpoints
♻️ refactor: simplify error handling logic
```

## Pre-Commit Override

Override via `.feature-marker.json`:

```json
{
  "commit": {
    "pre_commit": {
      "lint": "swiftlint --strict",
      "build": null,
      "test": null
    }
  }
}
```

## Important

- Only run checks if the tool/script exists — never fail on missing optional tools
- Each check reports its result — never fail silently
- If checks fail, ask if user wants to proceed or fix first
- Do NOT add Co-Authored-By footer to commits

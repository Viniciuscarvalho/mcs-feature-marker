# Stack-Specific Review Checklists

Per-stack review gates loaded automatically based on detected tech stack.

---

## iOS / Swift

1. **No force unwraps** (`!`) — use `guard let` or `if let`
2. **Retain cycles** — check closures for `[weak self]` / `[unowned self]`
3. **SwiftUI best practices** — proper `@State`, `@Binding`, `@ObservedObject` usage
4. **Accessibility** — all interactive elements have accessibility labels
5. **Concurrency** — proper `@MainActor`, `Task`, `async/await` usage
6. **Error handling** — use `do/catch`, avoid `try!`
7. **Memory management** — no large allocations in hot paths
8. **API deprecations** — no deprecated iOS APIs
9. **Test framework** — Swift Testing (`@Test`, `@Suite`, `#expect`) preferred over XCTest
10. **SwiftLint compliance** — all rules passing

---

## Node.js / TypeScript

1. **Type safety** — no `any` types, proper generics
2. **Hook rules** — React hooks follow rules-of-hooks (if React)
3. **Component size** — components under 200 lines
4. **Bundle size** — no unnecessary large imports
5. **Error handling** — all promises have `.catch()` or try/catch
6. **Security** — no `dangerouslySetInnerHTML`, proper input sanitization
7. **Testing** — each module has corresponding `.test.ts` file
8. **Environment** — secrets in env vars, not hardcoded
9. **Dependencies** — no unused packages, no known vulnerabilities
10. **Accessibility** — ARIA labels, semantic HTML, keyboard navigation

---

## Rust

1. **No `unwrap()`** — use `?` operator or explicit error handling
2. **Clippy clean** — `cargo clippy -- -D warnings` passes
3. **Lifetimes** — explicit where needed, avoid unnecessary
4. **Unsafe blocks** — justified and documented
5. **Error types** — custom error types with `thiserror` or similar
6. **Memory** — no unnecessary clones or allocations
7. **Concurrency** — proper `Send`/`Sync` bounds, no data races
8. **Documentation** — public items have `///` doc comments
9. **Tests** — `#[cfg(test)]` modules for unit tests
10. **Dependencies** — minimal, audited with `cargo audit`

---

## Python

1. **Type hints** — all function signatures have type annotations
2. **Exception handling** — specific exceptions, no bare `except:`
3. **Async safety** — proper `async/await`, no blocking in async context
4. **Testing** — pytest style, parametrized where appropriate
5. **Linting** — ruff/flake8 clean
6. **Security** — no `eval()`, proper input validation
7. **Documentation** — docstrings for public functions/classes
8. **Dependencies** — pinned versions, no unnecessary packages
9. **Imports** — organized (stdlib → third-party → local)
10. **Data classes** — use `dataclass` or `pydantic` for structured data

---

## Go

1. **Error handling** — all errors checked, no `_` for errors
2. **Context propagation** — `context.Context` passed through call chain
3. **Goroutine leaks** — all goroutines have exit conditions
4. **Interfaces** — small, focused interfaces at consumer site
5. **Naming** — follows Go conventions (exported = PascalCase, unexported = camelCase)
6. **Testing** — table-driven tests, proper test helpers
7. **Concurrency** — proper channel usage, no shared mutable state
8. **Documentation** — package and exported function comments
9. **Dependencies** — minimal `go.sum`, `go vet` clean
10. **Error types** — `errors.Is`/`errors.As` for error checking

---

## Ruby

1. **N+1 queries** — use `includes`/`eager_load` for associations
2. **Frozen strings** — `# frozen_string_literal: true` in all files
3. **RuboCop** — all rules passing
4. **Security** — no SQL injection, proper parameter sanitization
5. **Testing** — RSpec with proper context/describe nesting
6. **Performance** — no unnecessary object allocations in loops
7. **Naming** — snake_case methods, PascalCase classes
8. **Documentation** — YARD doc comments for public methods
9. **Error handling** — specific rescue clauses
10. **Dependencies** — Gemfile.lock committed, no unused gems

---

## .NET / C#

1. **Nullable references** — nullable reference types enabled, no `null!`
2. **Async/await** — proper async patterns, `ConfigureAwait` where needed
3. **IDisposable** — `using` statements for disposable resources
4. **LINQ** — efficient queries, no unnecessary materialization
5. **Dependency injection** — services registered properly
6. **Testing** — xUnit/NUnit with proper assertions
7. **Security** — no hardcoded secrets, proper auth middleware
8. **Naming** — PascalCase methods, camelCase parameters
9. **Documentation** — XML doc comments for public APIs
10. **Error handling** — specific exception types, global error handling

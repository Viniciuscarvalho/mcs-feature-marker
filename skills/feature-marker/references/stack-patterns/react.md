# Node.js / TypeScript / React Stack Patterns

## Detection Signals

- `package.json` → Node.js project
- `next.config.js` / `next.config.ts` → Next.js
- `react-native` in dependencies → React Native
- `nest-cli.json` → NestJS

## Package Manager Detection

- `pnpm-lock.yaml` → pnpm
- `yarn.lock` → yarn
- `bun.lockb` → bun
- `package-lock.json` or fallback → npm

## Test Commands

- **Jest**: `jest --findRelatedTests`
- **Vitest**: `vitest run`
- **Lint**: `{pm} run lint`
- **Build**: `{pm} run build`

## Key Patterns

- Strict TypeScript — no `any` types
- React hooks follow rules-of-hooks
- Components under 200 lines
- Proper error boundaries
- Server Components (Next.js App Router)
- Proper `use client` / `use server` directives

## Test Patterns

```typescript
describe("FeatureName", () => {
  it("should handle expected behavior", () => {
    const result = myFunction(input);
    expect(result).toBe(expected);
  });

  it("should throw on invalid input", () => {
    expect(() => myFunction(null)).toThrow();
  });
});
```

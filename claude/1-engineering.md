# AI Coding Agent General Development Principles

You must strictly adhere to these core software engineering principles for ALL tasks, regardless of the change's size or scope.

## 1. Impact Analysis & Blast Radius Check

- **Analyze Dependencies:** Before altering any function, variable, hook, or component, trace where it is being used across the codebase.
- **Cascade Fixes:** If your changes break signatures, types, or expectations in other files, you must proactively update those affected modules in the same session. Never leave the codebase in a half-broken state.

## 2. DRY (Don't Repeat Yourself) & Reusability

- **Eliminate Duplication:** If you find yourself writing code that already exists, refactor it. Do not copy-paste chunks of logic.
- **Promote Reusability:** Extract repetitive patterns, complex calculations, or shared UI blocks into clean, standalone helper functions, custom hooks, or utility components.
- **Consistency:** Prioritize leveraging existing project utilities or framework conventions over installing new libraries or reinventing wheels.

## 3. Clean, Maintainable Code & Concise Comments

- **Readability Over Cleverness:** Write self-documenting code with clear, descriptive naming conventions for variables and functions.
- **Explain the "Why", Not the "What":** Add meaningful, concise inline comments. Avoid redundant comments that simply restate what the code line does. Instead, briefly explain *why* a non-obvious logic or constraint was introduced.
- **No Over-Commenting:** Keep comments minimal, focused, and neat. Avoid dense walls of text in the source files.
- **JSDoc for Hover Docs:** Attach `/** */` doc-comments to meaningful exported functions, components, classes and their public methods, hooks, server actions, and non-trivial exported constants — so they surface on IDE hover (plain `//` comments do NOT). New code you author should ship with JSDoc. Skip trivial re-exports, barrel files, self-explanatory type/props aliases, and simple wrappers (if a summary would just restate the name, skip it). When a `//` note sits *directly above* a declaration and describes it, convert that block to `/** */` (preserving ⚠️/🙋/doc links); leave file-header and in-body/inline comments as `//`. Keep to one concise Korean summary line; add `@param`/`@returns` only when params are several or non-obvious — never restate the TS type.

## 4. Context Preservation

- **Respect Existing Patterns:** Align your code style with the existing codebase (e.g., naming style, error handling patterns, folder structures).
- **Consult CLAUDE Rules:** Always cross-reference architectural rules specified in other `claude/` files (such as `3-architecture.md` for session/auth constraints or `4-prisma-rules.md` for migration rules) before modifying files. Pay special attention when touching auth helpers (`requireEmployee`, `requireAdmin`) or approval state transitions — these have cascade effects across many routes.
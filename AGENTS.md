# AGENTS.md

## What is <project>?

<!-- TODO: One or two paragraphs: what the project does, who it's for and how it runs. -->

This file sits next to `README.md`. The README is for users; this file is for contributors and
agents working inside the repo.

## Repository layout

<!-- TODO: Replace with the real tree once the project has one. -->

```
.
├── main.go         entry point
├── .githooks/      commit-msg hook that checks the commit style
└── .github/        CI, Dependabot and repository settings
```

## Build, test & lint

Use the Makefile targets (`make help` lists them).

| Command | Purpose |
|---|---|
| `make setup` | Download dependencies and install the commit-msg hook. Run once per clone. |
| `make build` | Build the binary into `bin/`. |
| `make test` / `make test-race` | Go tests, with coverage. |
| `make lint` | golangci-lint with `--fix`. |
| `make vuln` | govulncheck. |
| `make all` | Format, lint, test and check for vulnerabilities. |

## Configuration

<!-- TODO: List the environment variables, or point at .env.example. -->

---

# Go Coding Guidelines

## Before you write Go

1. Name the package the change belongs to before opening a file.
2. Give any new package a `doc.go` holding its package comment.
3. Write Go for the version in `go.mod`.

These mirror [ainsley.dev/guidelines/go](https://ainsley.dev/guidelines/go/); treat them as the
canonical style. All text and comments use British English.

## General

- Formatting is `gofumpt`, via `golangci-lint run --fix`.
- Files are snake_case; integration tests end with `_integration_test.go`.
- Imports go standard library, third-party, then internal.
- Keep interfaces small, and document expectations such as thread safety.
- Prefer returning concrete types unless an interface is needed for testing or swapping.
- Use one `type ( ... )` block for related declarations, with no blank lines between them.

## Modern Go

Write Go for the version in `go.mod`, not the oldest one that compiles. The linter's `modernize`
check enforces most of this. Use:

- `slices` and `maps`: `slices.Contains`, `slices.Sort`, `slices.Sorted(maps.Keys(m))`, not
  hand-written loops.
- `min`, `max` and `cmp.Or(value, fallback)` for defaults, not `if x == "" { x = … }`.
- `for range n`, and `wg.Go(func() { … })` instead of `wg.Add(1)` with `defer wg.Done()`.
- `strings.Cut`/`CutPrefix`/`SplitSeq`, `errors.AsType[T]`, and `new(expr)` for pointers to
  values.
- `any`, never `interface{}`; `t.Context()` in tests.

## Comments

- Document every exported type, function and constant.
- Every comment ends with a full stop.
- Inside functions, only keep comments that explain *why*.

## Constructors

Constructors are `New` / `NewX`, validate dependencies with `github.com/ainsleydev/webkit/pkg/enforce`
(`enforce.NotNil`, `enforce.NotEqual`, …) and return pointers. `context.Context` comes first for
anything that does I/O.

## Control flow

Prefer maps of functions over switch statements when dispatching on a key. Type switches, ranges
and 2–3 case switches are fine.

## Errors

- Always handle errors. If you ignore one, say why in a comment.
- Wrap with `errors.Wrap` from `github.com/pkg/errors`.
- Use `fmt.Errorf("…%w", …)` when the message needs formatting.
- Never combine `errors.Wrap` with `fmt.Sprintf`.

## Logging

`log/slog` with capitalised messages: `slog.InfoContext(ctx, "Synced post", "slug", slug)`. Log
errors as `"error", err`.

## Testing

- **Shape:** test tables (`map[string]struct{}` named `tt`, looping
  `for name, test := range tt`, fields `input`/`want`/`wantErr`), or `t.Run` subtests when cases
  need setup or more than three inputs.
- **Parallel:** `t.Parallel()` everywhere, except tests that touch the file system or a database
  file. Say so in a note above the test.
- **Conventions:** `t.Context()`, `assert`/`require`, `got` for the result, no `if` or `else` in
  tables.
- **Naming:** test names like `"Second sync uploads nothing"`.
- **Organisation:** one test function per exported function, with a `setup(t)` helper for shared
  setup.
- **Fakes:** use fakes or real in-memory types over mocks; only fake system boundaries.

# <project>: development notes

Read [AGENTS.md](AGENTS.md) for the project overview and the Go guidelines.

## Testing & linting

Always run these before committing:

```
go test ./...
golangci-lint run ./... --fix --config=.golangci.yaml
```

The formatter is `gofumpt` (stricter than `gofmt`), and `--fix` applies it. If CI fails with
"File is not properly formatted (gofumpt)", run the lint command locally and commit the result.

## Commit style

Every commit and every pull request title uses conventional commits:

```
<type>: <description>
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

**Rules:**
- Capitalise the first letter of the description.
- Write it in the imperative, and keep it concise: `feat: Add user authentication`,
  `fix: Resolve memory leak in cache`, `docs: Update API documentation`.
- A scope is optional: `chore(deps): Bump golangci-lint`.
- Pull requests are squash-merged, so the title becomes the commit on `main`: give it the same
  format.

`.githooks/commit-msg` checks this. `make setup` installs it for a clone, and Claude Code sessions
install it automatically (`.claude/settings.json`). CI runs the same check on every commit and
pull request title, so a message that slips past locally still fails the build.

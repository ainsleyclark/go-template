# go-template

Repository scaffolding for Go projects, taken from what GoDaily and newsroom share: CI, linting,
Dependabot, repository settings, agent instructions and a commit-style check. It holds no
application code beyond a placeholder `main.go`, so it fits any package layout.

## Using it

1. On GitHub, click **Use this template → Create a new repository**.
2. Clone it and run `make setup` (downloads modules and installs the commit-msg hook).
3. Work through the checklist below, then delete this README section.

### Checklist

- [ ] `go.mod`: change the module path from `github.com/ainsleyclark/go-template`.
- [ ] `main.go`: replace the placeholder.
- [ ] `AGENTS.md` and `CLAUDE.md`: replace `<project>` and fill in the `TODO` sections.
- [ ] `.github/CODEOWNERS`: check the owners.
- [ ] `.github/dependabot.yml`: add other ecosystems (npm, Docker) and directories if you need them.
- [ ] `.github/workflows/pr.yaml`: add project-specific checks (generated code is current, e2e).
- [ ] `LICENSE`: check the licence and the year.
- [ ] `README.md`: replace with the project's own.

## What's included

| Path | Purpose |
|---|---|
| `.github/workflows/pr.yaml` | `go vet` and build, golangci-lint, race tests with coverage, govulncheck. |
| `.github/workflows/commits.yaml` | Fails a pull request whose title or commits don't follow the commit style. |
| `.githooks/commit-msg` | The commit-style check, as a git hook. CI runs the same script. |
| `.github/dependabot.yml` | Weekly grouped updates for Go modules and GitHub Actions. |
| `.github/settings.yml` | Repository settings for the [Settings app](https://github.com/apps/settings): squash only, delete merged branches, protect `main`. |
| `.github/CODEOWNERS` | Default reviewers. |
| `.golangci.yaml` | golangci-lint v2 config, with `gofumpt` and `modernize`. |
| `.editorconfig`, `.gitignore`, `.gitguardian.yml` | Editor, git and secret-scanning defaults. |
| `.claude/settings.json` | Installs the commit-msg hook at the start of every Claude Code session. |
| `AGENTS.md`, `CLAUDE.md` | Agent instructions: project overview stub, Go guidelines, commit style. |
| `Makefile` | `setup`, `build`, `test`, `lint`, `vuln`, `all`; `make help` lists them. |

## Commit style

Conventional commits with a capitalised, imperative description, for commits and pull request
titles alike: `feat: Add user authentication`. Types: `feat`, `fix`, `docs`, `style`, `refactor`,
`perf`, `test`, `chore`. See [CLAUDE.md](CLAUDE.md).

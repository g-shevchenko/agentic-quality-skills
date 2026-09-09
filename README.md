# Agentic Quality Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Skills](https://img.shields.io/badge/Skills-7-brightgreen?style=for-the-badge)](#skills)
[![Agents](https://img.shields.io/badge/Works%20with-Claude%20Code%20·%20Codex%20·%20Cursor%20·%20Windsurf%20·%20Devin-blue?style=for-the-badge)](#compatibility)
[![Last Update](https://img.shields.io/github/last-commit/g-shevchenko/agentic-quality-skills?label=Last%20update&style=for-the-badge)](https://github.com/g-shevchenko/agentic-quality-skills/commits)

Production-grade quality skills for AI coding agents: red-first TDD, quality
gates, golden benchmarks, measured uplift loops, test immutability, verify-red
checkpoints, property-based testing, and frontier-model gating.

Created from production operating patterns, rewritten as a self-contained
public package.

## Table of Contents

- [Quick Start](#quick-start)
- [Skills](#skills)
- [Compatibility](#compatibility)
- [Composes With](#composes-with)
- [Install](#install)
- [Verify Before Install](#verify-before-install)
- [Local Orchestration](#local-orchestration)
- [Repository Structure](#repository-structure)
- [Privacy And Security](#privacy-and-security)
- [Contributing](#contributing)
- [License](#license)

## Quick Start

```bash
git clone https://github.com/g-shevchenko/agentic-quality-skills.git
cd agentic-quality-skills
bash scripts/install.sh
```

Then in your agent chat:

```text
use agentic quality stack
```

That's it. The skills are now available to your agent.

## Skills

| Skill | Purpose | Trigger phrase |
|---|---|---|
| `test-driven-development` | Red-first TDD — failing test first, verify failure reason, lock assertions, route to frontier models | `use test driven development` |
| `agentic-quality-gates` | Classify task risk, define deterministic acceptance gates, catch red flags, decide autonomous vs ask human | `use agentic quality gates` |
| `golden-benchmark-uplift-loop` | Blind validation, deterministic graders, before/after measurement, small-sample caveats | `use golden benchmark uplift loop` |
| `test-immutability-lock` | Anti test-overfitting — existing assertions may NOT be relaxed/deleted/weakened, only ADD new ones | `use test immutability lock` |
| `verify-red-checkpoint` | TDD Iron Law — capture verify-red proof (assertion failure, not Import/Syntax/NameError) before implementation | `use verify red checkpoint` |
| `property-based-testing` | 3 property archetypes (invariant, inverse, idempotence), 23-37% pass@1 lift for LLM code | `use property based testing` |
| `frontier-only-tdd-gate` | Strict TDD only with frontier models (Sonnet/Opus/o3+). Haiku drops 30-69pp pass@1 | `use frontier only tdd gate` |

### Skill categories

**TDD discipline (4):** test-driven-development, verify-red-checkpoint, test-immutability-lock, frontier-only-tdd-gate

**Quality gates (1):** agentic-quality-gates

**Benchmarks & evals (1):** golden-benchmark-uplift-loop

**Testing strategy (1):** property-based-testing

## Compatibility

| Agent | Support | Install path |
|---|---|---|
| Claude Code | ✅ | `$HOME/.claude/skills` |
| OpenAI Codex | ✅ | `$HOME/.codex/skills` (default) |
| Cursor | ✅ | `$HOME/.cursor/skills` |
| Windsurf | ✅ | `$HOME/.codeium/windsurf/skills` |
| Devin | ✅ | via skill invocation |
| Gemini CLI | ✅ | via skill invocation |
| Antigravity | ✅ | via skill invocation |

Skills follow the [Anthropic Skills open standard](https://github.com/anthropics/skills) (December 2025).

## Composes With

- [agentic-engineering-skills](https://github.com/g-shevchenko/agentic-engineering-skills) — agent MVP blueprint, handoffs, overnight queues, architecture refactoring
- [mcp-token-savers](https://github.com/g-shevchenko/mcp-token-savers) — 21 local MCP servers
- [utility-skills](https://github.com/g-shevchenko/utility-skills) — Figma, SEO, PDF, YouTube, Zoom, remote Mac, talk decks, n8n

The `property-based-testing` skill composes with `pbt-runner-mcp` in [mcp-token-savers](https://github.com/g-shevchenko/mcp-token-savers).

## Install

```bash
# Default (Codex)
bash scripts/install.sh

# Claude Code
bash scripts/install.sh --target "$HOME/.claude/skills"

# Cursor
bash scripts/install.sh --target "$HOME/.cursor/skills"

# Windsurf
bash scripts/install.sh --target "$HOME/.codeium/windsurf/skills"

# Dry run (preview without writing)
bash scripts/install.sh --dry-run
```

The installer:
- Copies skills to the target directory (default: `$HOME/.codex/skills`)
- Optionally writes a managed block to `AGENTS.md` in the current workspace
- Refuses unsafe targets (`/`, `$HOME`, `.`)
- Creates a backup before replacing an existing skill

## Verify Before Install

Clone and inspect first:

```bash
git clone https://github.com/g-shevchenko/agentic-quality-skills.git
cd agentic-quality-skills
bash scripts/doctor.sh
bash scripts/audit-public-surface.sh
```

- `doctor.sh` — verifies all skills have required files and frontmatter
- `audit-public-surface.sh` — scans for secrets, private paths, and placeholder markers

See [VERIFY_BEFORE_INSTALL.md](VERIFY_BEFORE_INSTALL.md) and [SECURITY.md](SECURITY.md) for details.

## Local Orchestration

The broad local command is:

```text
use agentic quality stack
```

It orchestrates:

1. `test-driven-development` when code behavior changes.
2. `agentic-quality-gates` when the task has risk, side effects, architecture choices, or public release impact.
3. `golden-benchmark-uplift-loop` when improving prompts, skills, scorers, evals, calibration, or benchmark quality.

The package also includes a larger dictionary, so users can say natural phrases such as `verify red`, `lock tests`, `blind validation`, `golden regression`, `red flags`, `uplift loop`, `acceptance gate`, or the Russian equivalents in `docs/TRIGGER_DICTIONARY.ru-en.yaml`.

To add your own local phrase, add it to the managed `AGENTS.md` block or to your existing orchestrator docs. See `docs/COMMANDS.md`.

## Repository Structure

```
agentic-quality-skills/
├── skills/
│   ├── test-driven-development/        # Red-first TDD
│   ├── agentic-quality-gates/           # Risk classification + acceptance gates
│   ├── golden-benchmark-uplift-loop/    # Blind validation + uplift loops
│   ├── test-immutability-lock/          # Anti test-overfitting
│   ├── verify-red-checkpoint/           # TDD Iron Law
│   ├── property-based-testing/          # 3 property archetypes, 23-37% pass@1
│   └── frontier-only-tdd-gate/          # Frontier-model gating for strict TDD
├── scripts/
│   ├── install.sh                       # Copy skills to target directory
│   ├── doctor.sh                        # Verify repo structure
│   └── audit-public-surface.sh          # Scan for secrets/private markers
├── docs/
│   ├── TRIGGER_DICTIONARY.ru-en.yaml    # Natural-language trigger phrases
│   └── COMMANDS.md                      # Command guide
├── agent-docs/
│   └── AGENTS.managed-block.md          # Managed block for AGENTS.md
├── trust/
│   └── agentic-quality-skills.trust.json
├── LICENSE
├── SECURITY.md
├── VERIFY_BEFORE_INSTALL.md
└── README.md
```

## Privacy And Security

The installer copies files locally and may write a managed docs block to `AGENTS.md` in the current directory. It does not ask for API keys, read secrets, contact external services, or run package managers. It refuses unsafe targets such as `/`, `$HOME`, or `.`.

See [VERIFY_BEFORE_INSTALL.md](VERIFY_BEFORE_INSTALL.md), [SECURITY.md](SECURITY.md), and `trust/agentic-quality-skills.trust.json`.

## Contributing

Contributions are welcome. Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/your-skill`)
3. Add your skill under `skills/` with a `SKILL.md` (YAML frontmatter + Markdown)
4. Run `bash scripts/doctor.sh` and `bash scripts/audit-public-surface.sh`
5. Open a pull request

### Skill format

Each skill is a directory with at minimum:

```yaml
---
name: your-skill-name
description: Use when [trigger condition]. [What the skill does].
---
```

Followed by Markdown instructions. Optionally bundled with scripts, references, and eval fixtures.

## License

MIT — see [LICENSE](LICENSE).

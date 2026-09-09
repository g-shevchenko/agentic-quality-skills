# Agentic Quality Skills

Production-grade quality skills for AI coding agents: red-first TDD, quality gates,
golden benchmarks, measured uplift loops, test immutability, verify-red checkpoints,
property-based testing, and frontier-model gating.

Created from Humanswith.ai operating patterns, rewritten as a self-contained public package.

Background article: [Agentic quality skills for TDD, gates, golden benchmarks, and uplift loops](https://gregshevchenko.com/notes/agentic-quality-skills/).

## Verify Before Install

Clone and inspect first:

```bash
git clone https://github.com/g-shevchenko/agentic-quality-skills.git
cd agentic-quality-skills
bash scripts/doctor.sh
bash scripts/audit-public-surface.sh
```

Then install locally:

```bash
bash scripts/install.sh
```

The installer prints the commands to use after installation, including:

```text
use agentic quality stack
```

Fast path after inspection:

```bash
bash scripts/install.sh --target "$HOME/.codex/skills"
```

## What Gets Installed

- `skills/test-driven-development`
- `skills/agentic-quality-gates`
- `skills/golden-benchmark-uplift-loop`
- `skills/test-immutability-lock`
- `skills/verify-red-checkpoint`
- `skills/property-based-testing`
- `skills/frontier-only-tdd-gate`
- trigger dictionary: `docs/TRIGGER_DICTIONARY.ru-en.yaml`
- command guide: `docs/COMMANDS.md`
- an optional managed block in the current workspace `AGENTS.md`

The default target is `$HOME/.codex/skills`. Use `--target <dir>` for Claude Code, Cursor, Windsurf, or another agent runtime.

## Local Orchestration Command

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

## Skills

### `test-driven-development`

Use when implementing or fixing behavior with tests. Requires a failing test first, verifies the failure reason, locks existing assertions against weakening, and routes strict TDD implementers to frontier-class models.

### `agentic-quality-gates`

Use before non-trivial agentic work: classify task risk, define deterministic acceptance gates, catch red flags, avoid prompt-only fixes, and decide when to continue autonomously versus asking a human.

### `golden-benchmark-uplift-loop`

Use when improving a prompt, skill, scorer, eval, or calibration. Requires blind validation when the author has seen the answer key, deterministic graders, before/after measurement, and explicit caveats for small sample sizes.

### `test-immutability-lock`

Anti test-overfitting — existing test assertions may NOT be relaxed, deleted, weakened, or skipped. You may only ADD new assertions. Prevents the common AI failure mode where the model "fixes" a failing test by weakening it.

### `verify-red-checkpoint`

TDD Iron Law — capture verify-red proof (assertion failure, not Import/Syntax/NameError) before any implementation code. No production code without a failing test first.

### `property-based-testing`

Use when testing functions with wide input space (parsers, normalizers, scorers, schedulers, sort/filter/transform). Three property archetypes — invariant, inverse, idempotence — outperform example-based tests for LLM-generated code by 23-37% pass@1. Composes with `pbt-runner-mcp` (see [mcp-token-savers](https://github.com/g-shevchenko/mcp-token-savers)).

### `frontier-only-tdd-gate`

Strict TDD only with frontier-class models (Sonnet/Opus/o3+). Haiku-class models drop 30-69pp pass@1 under strict TDD. Use relaxed mode for weaker models.

## Privacy And Security

The installer copies files locally and may write a managed docs block to `AGENTS.md` in the current directory. It does not ask for API keys, read secrets, contact external services, or run package managers. It refuses unsafe targets such as `/`, `$HOME`, or `.`.

See `VERIFY_BEFORE_INSTALL.md`, `SECURITY.md`, and `trust/agentic-quality-skills.trust.json`.

## License

MIT.

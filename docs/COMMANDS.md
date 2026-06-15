# Commands And Orchestration

After installation, the broad command is:

```text
use agentic quality stack
```

Use it when you want the agent to select the relevant skills from this package:

- `test-driven-development`
- `agentic-quality-gates`
- `golden-benchmark-uplift-loop`

## Direct Commands

```text
use test driven development
```

Use for code changes, bug fixes, behavior changes, failing tests, red/green loops, and test immutability.

```text
use agentic quality gates
```

Use for non-trivial implementation, side effects, architecture gates, release gates, public-surface checks, and red flags.

```text
use golden benchmark uplift loop
```

Use for prompt, skill, scorer, eval, calibration, golden dataset, or benchmark improvement.

## Natural Triggers

You do not need to remember exact commands. The trigger dictionary includes examples such as:

- `verify red`
- `lock tests`
- `no test relaxation`
- `quality gate`
- `red flags`
- `acceptance gate`
- `blind validation`
- `golden regression`
- `uplift loop`

Russian equivalents are in `docs/TRIGGER_DICTIONARY.ru-en.yaml`.

## Add Your Own Phrase

After install, you can add a local alias to your workspace `AGENTS.md`, for example:

```markdown
When I say "use engineering quality mode", route to:
- test-driven-development
- agentic-quality-gates
- golden-benchmark-uplift-loop
```

If you already have a broader orchestrator, add `use agentic quality stack` as one route in that orchestrator rather than replacing your existing workflow.

# Gates And Red Flags

## Architecture Gate

For non-trivial agentic work, define:

- LLM-owned responsibility: the smallest model-owned task.
- Code-owned responsibility: deterministic validation, state, retries, execution, and proof.
- Inputs and outputs: schemas or typed contracts.
- Validators: deterministic checks before semantic judges.
- Golden cases: regressions that must not recur.
- Runtime state: stateless, pending, accepted, failed, retried, or terminal.
- Proof gate: commands or artifacts needed before accepted.
- Human gate: what requires approval.

## Red Flags

Stop or add a gate when you see:

- "The prompt should probably handle it" for a recurring bug.
- "Looks right" without a command, diff, test, trace, screenshot, or artifact.
- A side effect without idempotency or rollback.
- A long-running job without timeout or terminal failure state.
- A tool that can write externally but has no draft/commit split.
- A public release that references private files, private repos, local paths, or placeholders.
- A benchmark that uses a different model/tool path than production.
- An agent judging its own prompt, skill, scorer, or golden output.
- A test edited during a fix loop to make it pass.
- A decision punted to a human without a recommendation and evidence.

## Acceptance Gate Examples

Code change:

- targeted test passes;
- broader suite or typecheck passes;
- no weakened tests;
- final response includes commands.

Agent workflow:

- schema validates;
- retry and timeout policy exists;
- idempotency is defined;
- trace includes enough information for diagnosis;
- at least one golden covers the bug class.

Public release:

- clone-first verification works;
- no secrets or private references;
- install dry-run works;
- security/trust docs exist;
- public URLs resolve.

## Decision Handoff Format

```markdown
Recommendation: A, because ...
Why not B: ...
Evidence: ...
Risk: ...
Needed answer: confirm A or choose B.
```

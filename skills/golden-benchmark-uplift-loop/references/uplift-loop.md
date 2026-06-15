# Uplift Loop

## Blind Validation Template

```markdown
Objective: <what quality should improve>
Contamination status: author has / has not seen answer key
Golden access policy: blind executor cannot read <paths>
Runner: <command>
Before: <score or failures>
Change: <general guard, not hand-fit>
After: <score or failures>
Sample-size caveat: n=<n>; validates this case, not broad generality
```

## What The Author May Do

Allowed when contaminated:

- define the general principle;
- write or repair deterministic graders;
- add schema/validator checks;
- document the expected proof process.

Not allowed:

- grade output by eye;
- expose expected answers to the blind executor;
- tune wording only until one known golden passes;
- claim general improvement from n=1.

## Deterministic First

Prefer deterministic checks before semantic judges:

- JSON schema validation;
- required field presence;
- forbidden marker scan;
- exact fixture comparison;
- property-based test;
- scorer threshold with a fixed rubric;
- reproducible CLI runner.

Use semantic judges only after structural checks pass.

## Benchmark Routing

Benchmarks should use the same model/tool path as production unless the benchmark explicitly tests an isolated lower-level primitive. Otherwise the benchmark measures a different system.

## Uplift Loop

1. Baseline: run the current prompt/skill/scorer.
2. Find failure class: name the general principle.
3. Add guard: validator, schema, golden, or instruction.
4. Blind run: fresh executor without answer key.
5. Grade: deterministic runner.
6. Iterate once if needed.
7. Report honest before/after and residual risk.

## Red Flags

- "I know the answer, and the output looks right."
- "The golden passes" when the same author wrote both the golden and output.
- "This prompt is better" without a runner.
- Benchmark data uses one model path, production uses another.
- The fix names a specific fixture instead of a general class.

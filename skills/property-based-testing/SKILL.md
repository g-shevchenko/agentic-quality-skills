---
name: property-based-testing
description: Use when testing functions with wide input space (parsers, normalizers, scorers, schedulers, sort/filter/transform). Three property archetypes — invariant, inverse, idempotence — outperform example-based tests for LLM-generated code by 23-37% pass@1 (PGS arxiv:2506.18315) and find 56% valid bug rate on real PyPI (Anthropic Agentic PBT arxiv:2510.09907). Composes with pbt-runner-mcp (see mcp-token-savers repo).
---

# Property-Based Testing (PBT) for LLM-Generated Code

A composable testing methodology that uses **invariants** instead of enumerated examples. Outperforms example-based testing for code with wide input spaces.

## When to invoke

- Testing a function with a wide input space (parsers, normalizers, scorers, schedulers, sort/filter/transform)
- Bug-finding on existing code (PBT discovers edge cases that examples miss)
- After writing an LLM-generated function, before declaring it "tested"
- When 5-10 example tests aren't enough to cover the input space
- Trigger phrases (EN): `property test`, `invariant test`, `PBT`, `hypothesis`, `fast-check`, `inverse property`, `idempotence`, `wide input`, `falsify`
- Trigger phrases (RU): `свойство-тест`, `инвариант`, `пбт`, `обратное свойство`, `идемпотентность`

## When NOT to invoke

- Functions with narrow input space (e.g. 3 enum values) — examples are clearer
- UI/visual components — properties don't fit
- Functions with stateful side effects (DB writes, network) — PBT struggles with deterministic shrinking
- Configuration parsing — examples are more readable + documentation

## The Three Archetypes

### 1. Invariant — "output property holds for all inputs"

The output satisfies a structural property regardless of what comes in.

Examples:
- `sorted(xs)` is non-decreasing for all `xs`
- `len(filter(p, xs)) <= len(xs)` for any predicate `p`
- `normalize_email(x)` contains exactly one `@` (when input is a valid email)

```python
from hypothesis import given, strategies as st

@given(st.lists(st.integers()))
def test_sorted_is_non_decreasing(xs):
    result = my_sort(xs)
    for i in range(len(result) - 1):
        assert result[i] <= result[i + 1]
```

### 2. Inverse — `f(g(x)) == x`

Two functions are inverses of each other for all valid inputs.

Examples:
- `decode(encode(x)) == x`
- `parse(serialize(x)) == x`
- `decompress(compress(data)) == data`

```python
@given(st.text())
def test_encode_decode_round_trip(s):
    assert decode(encode(s)) == s
```

### 3. Idempotence — `f(f(x)) == f(x)`

Applying the function twice yields the same result as applying it once.

Examples:
- `normalize(normalize(x)) == normalize(x)`
- `dedupe(dedupe(xs)) == dedupe(xs)`
- `sort(sort(xs)) == sort(xs)`

```python
@given(st.text())
def test_normalize_is_idempotent(s):
    assert normalize_whitespace(normalize_whitespace(s)) == normalize_whitespace(s)
```

## Routing decision

After writing or reviewing a function, ask:

1. Is the input space wide (more than ~10 meaningful equivalence classes)?
2. Does the function have a clean property (invariant / inverse / idempotence)?
3. Would 5+ example tests miss obvious edge cases?

If YES to **any 2** → use PBT. If NO to all → use example tests + `verify-red-checkpoint`.

## Workflow

1. Identify the archetype (invariant / inverse / idempotence)
2. Call `pbt-runner-mcp.suggest_strategies(language, input_description)` to get the strategy code
3. Write the property check
4. Call `pbt-runner-mcp.run_property` with the strategies + check + archetype
5. If `outcome: "falsified"` → fix the code (NOT the property); the `counterexample` IS the red state
6. If `outcome: "passed"` → optionally `pbt-runner-mcp.record_property_run` for audit history

## Anti-patterns

- **Writing the property to match the code** — same blind-spot collusion as one-agent self-debug. Write the property from the SPEC, not from the implementation.
- **Skipping shrinking** — fast-check + hypothesis already do this, but if you write your own runner without shrinking, you lose the minimal-counterexample value.
- **Using PBT for narrow inputs** — slower than 3 example tests and harder to read.
- **Asserting equality of the function under test with itself** — `assert f(x) == f(x)` is always true (modulo non-determinism). The property must reference an INDEPENDENT structural truth.

## Composition

- `pbt-runner-mcp (see mcp-token-savers repo)` — the MCP that runs hypothesis/fast-check; this skill is the routing + discipline layer
- `verify-red-checkpoint` — sister skill: a falsified property IS the red state; capture the counterexample as the expected-failure pattern
- `test-driven-development` — parent discipline (PBT is PBT-flavored TDD)
- `task-test-author.md` agent — prefers PBT for wide-input functions
- `frontier-only-tdd-gate` — applies (PBT property authoring requires Sonnet/Opus/o3+ for instruction-following)

## Sources

- PGS (arxiv:2506.18315, 2026) — +23-37% relative pass@1 over example-based TDD on HumanEval / MBPP / LiveCodeBench
- Anthropic Agentic Property-Based Testing (arxiv:2510.09907, Oct 2025, Carlini + Hatfield-Dodds creator of Hypothesis) — 56% valid bug rate on real PyPI packages; reported 5 bugs to NumPy + cloud SDKs; 3 patches merged
- Research: `TDD research notes` § §3.1 Property-Based Testing
- Adoption: `TDD gap analysis notes` § Bucket 2.5
- Companion MCP: `pbt-runner-mcp (see mcp-token-savers repo)` (PR #877 + public PR #48)

---
name: test-immutability-lock
description: Use when modifying test files OR fixing a failing test. Existing assertions may NOT be relaxed, deleted, or weakened — only ADD new test cases or assertions. Closes the test-overfitting failure mode named by IBM (arxiv:2511.16858, first empirical study) + TDFlow audit (0.9% test-hacking rate when discipline enforced vs unmeasured-higher without).
---

# Test Immutability Lock

The discipline of NEVER weakening an existing test assertion. Closes the "test hacking" failure mode where AI fixers relax tests instead of fixing the underlying code.

## When to invoke

- Any Edit to `tests/`, `test/`, `**/*.test.*`, `**/*_test.*`, `**/test_*.py`, `**/*_test.go`
- Any fix-loop iteration where existing tests are failing
- Whenever an agent says "the test was wrong" / "the test was too strict" / "loosen the assertion"
- Trigger phrases: `lock tests`, `залочь тесты`, `test immutability`, `no test relaxation`, `test-overfitting guard`

## The Discipline

You may **ADD**:
- New test cases (new `test('...', () => {...})` blocks)
- New assertions inside existing tests
- New describe blocks
- New fixture data (in setup files, not by modifying existing fixtures)

You may **NOT**:
- Remove existing `expect`, `assert`, `assertEqual`, `should` calls
- Loosen comparisons: `===` → `==`, `assertEqual` → `assertIn`, `eq` → `gte`
- Increase tolerances: `tol=0.01` → `tol=0.1`
- Add `.skip()`, `xfail`, `@pytest.mark.skip`, `it.skip`, `test.skip`
- Comment out test cases
- Delete test cases
- Change expected values (e.g. `expect(result).toBe('A')` → `toBe('B')`)
- Wrap assertions in conditionals that bypass them
- Reorder assertions in a way that makes later ones unreachable

## When a test legitimately must change

If you genuinely believe an existing test's expected behavior is wrong (e.g. spec changed, off-by-one in test fixture, racy assertion):

1. **STOP** the current fix/implementation
2. Escalate to `task-spec-freezer.md` with the proposed change + rationale
3. Get explicit approval (Greg or fresh-context verifier)
4. Update the test in a SEPARATE commit clearly marked `spec change: ...` (NOT `fix: ...`)

Never modify tests inline during a fix-loop iteration.

## Why

IBM Test Overfitting (arxiv:2511.16858, Nov 2025) — first empirical study of the phenomenon:

> "Relying too much on tests for issue resolution can lead to code that technically passes observed tests but actually misses important cases or even breaks functionality."

TDFlow (arxiv:2510.23761, EACL 2026) audit: **7/800 = 0.9% test hacking** when this discipline is enforced (vs unmeasured-higher without). The discipline reduces silent regressions in agent-driven fix loops.

## Red flags — STOP and escalate

- "I'll just loosen this assertion since the test is fragile"
- "The test was a bit too strict — let me change it"
- "Adding `.skip()` for now so other tests can run"
- "Removing this assertion since the new behavior is OK"
- "Changing `expect(x).toBe(y)` to `toContain(y)` to make it less brittle"
- "The expected value should actually be Z, not Y" (without spec change)

All of these mean: STOP. The TEST is correct unless a spec change is approved. Fix the CODE.

## Composes with

- `test-driven-development` skill (parent discipline)
- `verify-red-checkpoint` skill (sister discipline — verify red before write impl)
- `restricted-tool-subagent` skill (capability separation that supports this)
- `task-fixer.md` agent (already body-forbids test mods)
- `task-implementer.md` agent (already body-forbids test mods)
- `the project rule (see your repo rules)` (codified enforcement rule)

## Sources

- IBM Test Overfitting (arxiv:2511.16858, Nov 2025) — first empirical study
- TDFlow (arxiv:2510.23761, EACL 2026) — 0.9% test-hacking rate with discipline
- Research: `TDD research notes` § Caveat C2
- Adoption: `TDD gap analysis notes` § Bucket 2 #2.2

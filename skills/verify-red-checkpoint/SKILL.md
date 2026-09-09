---
name: verify-red-checkpoint
description: Use after writing a test, before any implementation code. Run the test, capture the failing output, confirm failure type matches expectation. Composable primitive for TDD discipline (Iron Law from obra/superpowers + Anthropic Best Practices + IBM TDD-Bench fail-to-pass metric).
---

# Verify-Red Checkpoint

A composable primitive for TDD discipline: the failing-test verification step.

## When to invoke

- After writing a new test (before any implementation code)
- After a bug-fix RED step (regression test before patch)
- Before unblocking `task-implementer` in a proof-loop
- Whenever Greg or another agent says "verify red", «проверь red», "iron law", "fail-to-pass"

## Discipline (4 steps)

1. **Run the test** — `npm test path/to/file.test.ts` or `pytest path/to/file::test_name -v`
2. **Capture the output verbatim** — paste the full failing output into the conversation OR into `.agent/tasks/<TASK_ID>/verify_red.md`
3. **Confirm failure TYPE** — must be an assertion failure (or expected exception). MUST NOT be:
   - `ImportError` / `ModuleNotFoundError` (test file is broken)
   - `SyntaxError` (test file is broken)
   - `NameError` (test references undefined symbol — broken)
   - `TypeError` on infrastructure (often a test setup issue, not the feature)
4. **Confirm failure MESSAGE matches expectation** — if the test asserts "rejects empty email", the failure message should mention email validation (`Expected 'Email required', got undefined`), NOT random unrelated state

## The Iron Law (verbatim, source: obra/superpowers, Anthropic-endorsed)

- A test that **passes** on first run is INVALID. Rewrite it. You're testing existing behavior.
- A test that **errors** (broken setup) is INVALID. Fix the test setup, not the missing implementation.
- A test that **fails with the expected assertion message** is VALID. Proceed to implementation.

## When to STOP

- Test passes immediately → rewrite test (you're testing existing behavior)
- Test fails for wrong reason (e.g. typo in import) → fix test setup, re-verify
- Cannot articulate "what should fail and why" before running → spec is unclear, return to `task-spec-freezer`

## Schema for `.agent/tasks/<TASK_ID>/verify_red.md`

For each AC, append a block:

```markdown
## AC1: <criterion text>

**Test file**: `tests/foo.test.ts`
**Test name**: `should reject empty email`
**Run command**: `npm test tests/foo.test.ts`

**Output** (verbatim, full):
\`\`\`
FAIL  tests/foo.test.ts > rejects empty email
  Expected: 'Email required'
  Received: undefined
\`\`\`

**Failure type**: assertion failure ✅ (not ImportError/SyntaxError)
**Expected message match**: "Email required" appears in output ✅
**Status**: VERIFIED RED — ready for task-implementer
```

## Sources

- obra/superpowers `test-driven-development/SKILL.md` (Iron Law verbatim — Anthropic-endorsed via claude.com/plugins/superpowers)
- Anthropic Best Practices for Claude Code (verification loop = substrate of TDD)
- IBM TDD-Bench Verified (arxiv:2412.02883): fail-to-pass is the canonical metric for measuring "does the test actually capture the missing behavior"
- Research: `TDD research notes` § Diamond #3

## Composes with

- `test-driven-development` skill (parent discipline)
- `task-test-author.md` agent (mandatory checkpoint before handoff to implementer)
- `restricted-tool-subagent` skill (enforces test-author cannot also implement)
- `the project rule (see your repo rules)` (deterministic enforcement rule)
- `.claude/hooks/tdd-edit-guard.sh` (PreToolUse hook blocking impl-first edits)

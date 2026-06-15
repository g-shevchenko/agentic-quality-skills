---
name: test-driven-development
description: Use when implementing a behavior change, fixing a bug, writing tests, or when the user says use test driven development, use TDD, test first, failing test first, verify red, iron law, fail-to-pass, lock tests, test immutability, no test relaxation, or frontier-only TDD. Requires a verified failing test before implementation, forbids weakening existing tests, and routes strict TDD implementers to frontier-class models.
---

# Test Driven Development

Use this skill to keep agent-written code honest: prove the missing behavior with a failing test, then implement the smallest code change that turns the test green.

## Workflow

1. Clarify the behavior being changed in one acceptance criterion.
2. Write or select the test that should fail before the fix.
3. Run the test before implementation.
4. Verify RED:
   - the test fails;
   - the failure is an assertion or expected exception;
   - the failure message matches the missing behavior;
   - the failure is not a broken import, syntax error, missing symbol, or setup error.
5. Implement the smallest production change.
6. Re-run the targeted test, then the nearest relevant suite.
7. Report the red proof and green proof.

For detailed rules, read `references/tdd-rules.md`.

## Test Immutability

Existing tests are locked. Add tests and assertions; do not weaken, delete, skip, loosen, or rewrite existing expected behavior during a fix loop.

If an existing test appears genuinely wrong, stop and treat it as a spec change. Get approval or a fresh verifier before changing it.

## Model Routing

Strict TDD is not a cheap-model task. If an implementer must follow a verified failing test contract, use a frontier-class model. Weaker models can be used for read-only verification, formatting, or non-TDD utility work.

## Done Criteria

Do not say the work is done unless the answer includes:

- test file and test name;
- command that proved RED;
- command that proved GREEN;
- any exception used, if strict TDD was not appropriate.

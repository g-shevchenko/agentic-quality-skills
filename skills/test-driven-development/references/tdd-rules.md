# TDD Rules

## Verify-Red Checkpoint

A test is valid only when it fails for the expected reason before implementation.

Valid RED:

- assertion failure;
- expected exception;
- message or diff points at the missing behavior.

Invalid RED:

- test passes on first run;
- import/module error;
- syntax error;
- undefined symbol;
- fixture setup failure unrelated to the behavior;
- a vague failure that cannot be tied to the acceptance criterion.

Use this proof shape:

```markdown
Acceptance criterion: <behavior>
Test file: <path>
Test name: <name>
Run command: <command>
Failure type: assertion failure
Expected message match: <why it matches>
Status: VERIFIED RED
```

## Test Immutability Lock

Allowed:

- add a new test case;
- add stricter assertions;
- add fixtures needed by a new case;
- add characterization tests for existing behavior.

Forbidden during a fix loop:

- delete assertions;
- change expected values;
- replace exact equality with weaker containment;
- increase tolerances;
- add `skip`, `xfail`, `.only`, conditionals, or early returns that bypass assertions;
- comment out tests;
- move assertions so they no longer execute.

## Legitimate Exceptions

Use an exception only when explicit and auditable:

- docs-only change;
- config-only change;
- pure refactor with existing tests green before and after;
- generated code;
- first test bootstrap in an untested package;
- approved spec change.

State the exception in the final answer.

## Frontier-Only Strict TDD

Strict TDD requires precise instruction following. Use frontier-class implementers for:

- writing the failing test;
- implementing against the verified test contract;
- debugging conflicting test signals.

Smaller/cheaper models are acceptable for:

- read-only test result summarization;
- formatting;
- simple grep/file discovery;
- non-TDD utility tasks.

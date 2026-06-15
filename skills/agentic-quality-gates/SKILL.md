---
name: agentic-quality-gates
description: Use before non-trivial agentic, coding, workflow, tool, automation, release, or public-surface work, and when the user says quality gate, acceptance gate, red flags, risk gate, architecture gate, decision handoff, side-effecting workflow, contracts first prompts last, prompt-only fix, human gate, or release gate. Classifies risk, defines deterministic acceptance gates, catches red flags, and decides whether to proceed autonomously or ask a human.
---

# Agentic Quality Gates

Use this skill to avoid "sounds done" work. It turns vague agentic work into explicit ownership, gates, and proof.

## Quick Triage

Before implementation, classify:

```text
Task class: not_agentic | llm_boundary | agent_workflow | side_effecting_workflow | runtime_infra | eval_only
Reason: <specific reason>
Protocol path: skip_full_gate | full_architecture_gate
```

Use `full_architecture_gate` when the task changes LLM behavior, prompts with behavioral effect, tools, workflows, automation, evals, side effects, or recurring bug handling.

Read `references/gates-and-red-flags.md` for the full checklist.

## Contracts First, Prompts Last

The model may classify, draft, extract, rank, or judge inside a boundary. Deterministic code owns execution, state, validation, retries, rollback, side effects, and acceptance.

Prompt-only fixes for recurring bugs are incomplete unless paired with a validator, schema, test, golden case, or proof gate.

## Decision Handoff

Proceed autonomously when the decision is reversible, low risk, evidence-backed, and testable.

Ask a human when the decision is destructive, public, credential-related, expensive, legally sensitive, security-sensitive, or under-evidenced.

When asking, provide one recommendation, one real alternative, evidence, risk, and the exact answer needed.

## Done Criteria

Report:

- task class;
- acceptance gate;
- red flags checked;
- proof command or artifact;
- human decision required, if any.

---
name: frontier-only-tdd-gate
description: Use when dispatching a TDD-mode subagent or choosing a model class for an implementer role. Strict TDD (verify-red + immutability lock + tests-first) is a frontier-only intervention — Haiku-class and weaker models drop 30-69pp pass@1 under strict TDD per WebApp1K (arxiv:2505.09027, ICLR-track, 1000 tasks × 19 models). Overrides "use cheap model for mechanical tasks" advice in subagent-driven-development when TDD is mandated.
---

# Frontier-Only TDD Gate

Routing rule: strict TDD discipline is a **frontier-only intervention**. Weaker models suffer measurably under strict test contracts.

## When to invoke

- Dispatching a `task-implementer.md` subagent in BUILD mode under TDD harness
- Choosing a model class for a sub-task that includes failing-test gates
- Composing with `subagent-driven-development` skill's "Model Selection" guidance
- Trigger phrases: `frontier tdd`, `model class check`, `tdd routing`, `frontier-only tdd`, `relaxed tdd for haiku`

## Routing table

| Task class | TDD mode | Recommended model class | Rationale |
|---|---|---|---|
| `task-implementer` in TDD harness | strict | **Claude Sonnet 4.x / Opus / GPT-5 / o3+** | WebApp1K: pass@1 0.88-0.95 |
| `task-test-author` in TDD harness | strict | **Sonnet 4.x / Opus** | needs to reason about expected failures |
| `task-verifier` (read-only) | strict | Haiku-class OK | simple judgment task |
| Mechanical / utility / dispatch (no test gate) | relaxed | Haiku-class / Cerebras / Gemini Flash | no strict test contract |
| Non-TDD code generation (one-shot, no test gate) | relaxed | Haiku-class OK | low risk per WebApp1K |

## The Data (WebApp1K, arxiv:2505.09027, ICLR-track, 1000 tasks × 19 models)

Single-feature TDD pass@1:

| Model | TDD pass@1 | NL-prompted (TLD) pass@1 | TDD impact |
|---|---|---|---|
| o1-preview | **0.952** | n/a | strong |
| Claude 3.5 Sonnet | **0.881** | n/a | strong |
| Llama-3.1-405b | 0.302 | **0.885** | **TDD HURTS by 58pp** |
| Llama-3-70b | 0.332 | 0.640 | TDD HURTS by 31pp |
| Llama-3.1-70b | 0.103 | 0.790 | **TDD HURTS by 69pp** |

Authors' explanation:

> "Our findings highlight instruction following and in-context learning as critical capabilities for TDD success, surpassing the importance of general coding proficiency or pretraining knowledge."

## Override of `subagent-driven-development` "Model Selection"

`~/.claude/skills/superpowers/skills/subagent-driven-development/SKILL.md` says:

> "Mechanical implementation tasks: use a fast, cheap model"

This advice is correct for **non-TDD** tasks (refactors, format conversions, boilerplate). But it INVERTS when strict TDD is mandated. The implementer working against a failing test gate is NOT a "mechanical task" in WebApp1K's sense — it must precisely interpret the test contract, which is exactly what cheap models are weakest at.

Compose rule:
- `subagent-driven-development` + non-TDD task → follow cheap-model advice
- `subagent-driven-development` + `verify-red-checkpoint` + `task-implementer` → THIS RULE overrides; **frontier-class mandated**
- If unsure → frontier-class. The cost difference is far smaller than the throughput cost of failed TDD attempts.

## Relaxed-mode TDD for non-frontier (when forced)

If you must use a weaker model under any TDD circumstance:
- Skip `verify-red-checkpoint` skill
- Skip `test-immutability-lock` skill for the model's own tests
- Treat tests as one-shot guidance rather than strict contract
- Write tests alongside code rather than tests-first
- Document this as "test-augmented generation" — NOT TDD

## When the rule blocks weak-model routing

Sample agent reasoning:

```
User: "Run this fix through Cerebras to save tokens."
Agent: "The fix has a failing-test gate (task-implementer in TDD harness).
Per `.claude/skills/frontier-only-tdd-gate/SKILL.md` + WebApp1K, Cerebras-llama
would drop pass@1 by 30-69pp under strict TDD. Recommend Sonnet/Opus
for this implementer; Cerebras OK for non-TDD utility downstream."
```

## Composes with

- `subagent-driven-development` skill (this skill overrides its Model Selection advice for TDD tasks)
- `task-implementer.md` agent (the implementer role this gate governs)
- `verify-red-checkpoint` skill (the discipline this protects)
- `test-immutability-lock` skill (sister discipline)
- `restricted-tool-subagent` skill (capability separation matrix)
- `the project rule (see your repo rules)` (codified rule)

## Sources

- WebApp1K / "Tests as Prompt" (arxiv:2505.09027, ICLR-track, 1000 tasks × 19 models)
- Research: `TDD research notes` § Caveat C1
- Adoption: `TDD gap analysis notes` § Bucket 2 #2.3

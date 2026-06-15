---
name: golden-benchmark-uplift-loop
description: Use when improving a prompt, skill, eval, benchmark, scorer, calibration, judge, golden dataset, or agent workflow quality, and when the user says golden benchmark, golden dataset, golden regression, blind validation, unbiased evaluator, answer key contamination, uplift loop, before/after measurement, scorer calibration, prompt eval, or skill eval. Requires blind validation when the author has seen the answer key, deterministic grading, before/after measurement, and honest sample-size caveats.
---

# Golden Benchmark Uplift Loop

Use this skill when quality must improve measurably, not just feel better.

## Core Rule

If you wrote or saw the expected answer, prior passing output, golden labels, scorer threshold, or answer key, you are contaminated. Do not grade your own output by eye.

Instead:

1. Write a general, principled guard or improvement.
2. Use a deterministic grader or runner.
3. Have a fresh executor produce output without seeing the answer key.
4. Grade with the runner.
5. Improve.
6. Re-run blind with a fresh executor.
7. Report before/after results and the sample-size caveat.

Read `references/uplift-loop.md` for templates and benchmark rules.

## Golden Case Discipline

A golden is useful only when it captures a real behavior boundary:

- valid case;
- malformed case;
- ambiguous case;
- missing evidence case;
- injection/adversarial case;
- regression case from a real failure.

Do not overfit instructions to one golden. Add a general rule that would have prevented the bug class.

## Done Criteria

Report:

- what was measured;
- who/what was blind to the answer key;
- runner command;
- before result;
- after result;
- sample size and residual risk.

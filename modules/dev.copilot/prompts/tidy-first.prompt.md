---
description: "Plan a sequence of preparatory refactors (tidyings) to make a specific objective easier to implement."
agent: plan
argument-hint: "Describe the objective you want to achieve after tidying"
---

## Objective

The objective has been provided. Do not implement it, use it solely to focus the tidying plan: identify the structural friction in the codebase that would make this change hard, and plan small refactors to remove that friction.

> "Make the change easy, then make the easy change." — Kent Beck

## Process

1. **Restate the objective**
   - Confirm your understanding of what the objective requires the code to do.
   - Identify which parts of the codebase it will touch.
   - If the scope is ambiguous, ask targeted clarifying questions before proceeding.

2. **Identify friction**
   - Read the relevant code.
   - Name the structural properties that make the objective hard right now (e.g. mixed concerns, missing seams, duplicated logic, unclear naming, poor cohesion).

3. **Propose a tidy plan**
   - List an ordered sequence of small, safe, structural steps.
   - Each tidy must:
     - Have a name. Use Beck's vocabulary where it fits: _guard clause_, _extract helper_, _inline variable_, _normalize symmetries_, _move declaration near use_, _explain with a variable_, _chunk statements_, _extract method_, _delete dead code_, _cohesion order_.
     - Concisely state what changes and why it serves the objective. Do not over-explain. I will ask for more details if needed.
     - Be behaviour-preserving. All tests must pass after each step.
     - Be independently verifiable, small enough to review and validate in isolation.
   - Order the tidies so each one makes the next easier.
   - Stop at the point where the objective itself becomes straightforward to implement. Do not over-tidy.

4. **State the outcome**
   - Describe the structure after all tidies are applied.
   - Confirm specifically how this makes the objective the easy change.

## Guidance

- Do not implement the objective.
- Do not perform speculative or broad cleanup unrelated to the objective. Every tidy must be justified by the objective.
- If a proposed tidy is large or touches many callsites, split it into smaller steps.
- Prefer fewer, targeted tidies over exhaustive refactoring.
- If a proposed tidy cannot be made safely without also changing behaviour, flag it explicitly rather than including or omitting it silently.

## Output format

**Objective (restated):** ...

**Friction points:**
- ...

**Tidy plan:**
1. [Tidy name] — what changes and why
2. ...

**After tidying:** ...

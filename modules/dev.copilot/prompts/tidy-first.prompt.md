---
description: "Plan a sequence of preparatory refactors to make a specific objective easier to implement."
agent: Plan
argument-hint: "Describe the objective you want to achieve after tidying"
---

Identify and plan a sequence of small, safe, structural refactors to make the stated objective easier to implement. Do not implement the objective itself, only plan the tidying steps.

> "Make the change easy, then make the easy change." — Kent Beck

Focus this plan on making the change easy, instead of implementing the change.

## Process

1. Identify which parts of the codebase the change will touch.
  - If the scope is ambiguous, ask targeted clarifying questions before proceeding.
2. Identify friction.
  - Read the relevant code.
  - Name the structural properties that make the objective hard right now (e.g. mixed concerns, missing seams, duplicated logic, unclear naming, poor cohesion, inappropriate coupling).
3. Propose a tidy plan
  - List an ordered sequence of small, safe, structural refactors.
  - Each step must:
    - Have a clear objective and justification.
    - Be behaviour-preserving. All tests must pass after each step.
    - Be independently verifiable, small enough to review and validate in isolation.
  - Stop at the point where the objective itself becomes straightforward to implement.
4. Present the tidy plan to the user for review and approval before proceeding.
  - If the user requests changes, update the plan and repeat step 4.

## Guidance

- Do not plan to implement the objective, only to make the objective easier.
- Keep the refactors focused on making the objective easier.
- Prefer fewer, targeted tidies over exhaustive refactoring.

---
name: refine-instructions
description: Collaborative refinement of agent instructions. Use to refine, tidy, dedupe, shrink or audit agent instructions/behaviour. Proposes edits for approval; never edits unsupervised.
disable-model-invocation: true
---

# Instruction Refiner

Goal: fix the behaviour behind each frustration with the fewest, clearest
instructions. Shorter is a side effect, not the aim. Pause after each step.

## 1. Understand the pain

Gather input:

- Rules the user recently added (ask, or check git history). Treat each as an
  explicit signal of intent: the frustration it targets.
- Optional: ask once for other recent frustrations or odd agent behaviour.
- Ask for clarification only where the intent is unclear. Restate each pain
  point in one line and confirm.

## 2. Diagnose

Read all instruction files that load together (root, scoped, skills) as one
combined context, and list what you read. For each pain point, look for the
cause in existing rules: conflicting, ambiguous, buried, misplaced, stale, or
duplicated. Also note other redundancy or conflicts you come across. Report
findings, citing file and rule.

## 3. Propose

For each change: action (clarify | merge | delete | add | move), the text before
and after, the cause it addresses, and the behaviour affected. Prefer fixing or
removing the cause over adding a rule. If a new rule conflicts with an older
one, the newer wins by default; confirm before deleting the older one. Wait for
approval.

## 4. Apply

Make only approved edits. Show the diff.

## Rules

- Never delete or weaken a rule without stating what it protects.
- If a rule's purpose is unknown, ask.
- Prefer the smallest edit. Keep the user's wording where it works.

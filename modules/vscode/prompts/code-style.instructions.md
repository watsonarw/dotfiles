---
applyTo: '**'
---
# Code Style Instructions

## Simplicity Over Cleverness
- Write the simplest solution that works. Avoid unnecessary complexity, abstractions, or premature optimization.
- Minimize nested conditionals and deeply nested structures. Use early returns to reduce nesting.
- Prefer explicit code over implicit magic. Make behavior obvious from reading the code.

## Self-Explanatory Code
- Use intention-revealing names for variables, functions, and classes that explain WHY, not just what.
- Avoid abbreviations and acronyms unless they are widely understood.
- Never add obvious comments that just restate what the code does. Trust that well-named code speaks for itself. The only comments that should exist are those that explain **why** something is done a certain way, not **what** is being done.
- Someone who has never seen the code before should be able to understand what it does quickly and easily.

## Keep it Simple
- Write small, focused functions that do one thing well (Unix philosophy).
- Keep functions as small as practical. Extract complex logic into well-named helper functions.
- All statements in a function should be at the same level of abstraction. If you need to mix levels, extract into separate functions.

## Domain-Driven Language
- Use the language of the problem domain in code, not technical jargon. Where it makes sense, use user-centric language.
- Structure code around business concepts, not technical frameworks.
- Group related functionality together rather than separating by technical layer.

## Coupling & Cohesion
- Avoid excessive coupling between modules. Prefer composition over inheritance.
- Don't create unnecessary abstractions or interfaces until you need them.
- DRY is nice, but inappropriate coupling is worse. Follow the rule of three—don't abstract until you've seen the same pattern three times and know what to abstract.

## Testability & Predictability
- Write deterministic code with minimal side effects.
- Make functions pure when possible - same inputs produce same outputs.
- Design for easy testing. Avoid hard-to-mock dependencies and global state.
- Code should behave exactly as its name and signature suggest.

## CUPID Properties
- Composable: plays well with others
- Unix philosophy: does one thing well
- Predictable: does what you expect
- Idiomatic: feels natural
- Domain-based: the code models the problem domain in language and structure

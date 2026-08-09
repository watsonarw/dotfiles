---
agent: agent
---

Follow a TDD approach to implementation.

1. State a clear and concise description of the feature or function being implemented.
2. Break down the feature or function into its _observable behaviours_
  - Include happy paths, alternate paths, error scenarios, and edge cases.
  - If any of the behaviours is not clear from the request, ask for clarification.
  - List out the behaviours of the feature or function as a TODO list. These will become the tests that will drive the implementation.
4. Run the full test suite to ensure all tests are passing as a baseline.
  - If any tests are failing, stop, state the failing tests, and clarify the expected behaviour before fixing.
  - Do not proceed unless all existing tests are passing.
5. Do the TDD loop:
   1. Write a failing test for the next behaviour to be implemented.
   2. Run the full test suite to ensure the new test is failing.
   3. Write the absolute smallest amount of code necessary to make the new test pass.
   4. Run the full test suite to ensure all tests are passing.
   5. Assess the current implementation, and if necessary refactor to improve clarity or maintainability, or to reduce complexity, repetition or other code smells. Do not change the behaviour during refactoring!
   6. Run the full test suite to ensure all tests are passing after refactoring.
   7. Assess the current tests, and if necessary refactor to improve clarity or maintainability, or to reduce complexity, repetition or other code smells. Do not change the behaviour during refactoring!
   8. Run the full test suite to ensure all tests are passing after refactoring.
   9. Repeat until all behaviours have been implemented and all tests are passing.

## Guidance

- IMPORTANT: When refactoring, do not change both the implementation and the tests at the same time. Refactor one, then run the tests, then refactor the other, then run the tests.
- Reflect and look for potential refactors every time the tests are green. Do not refactor while the tests are red.
- Before running tests, clearly state the result you expect to see. If after running the tests, the result is not as expected, stop and consult with the user before proceeding.
- Always write the minimum amount of code necessary to make a failing test pass. Do not write code that is not required to make the test pass. Keep the implementation as simple as possible, do not over-engineer.
- If as you are writing code, you realise that your list of behaviours is incomplete, get to a point where all tests are green, stop and propose adding a behaviour to the list.
- Always work from the list of behaviours, do not implement any behaviour that is not on the list, and make sure you check off each behaviour as it is implemented and tested. Continue until the list is complete and all tests are passing.

## Human Gated Mode
You may be asked to work in a human gated mode. In this mode:

- Stop every time the tests are green, and state the next behaviour you intend to test and implement. I will review the current code, suggest or make refactors, or suggest additional behaviours to be implemented.  Only proceed to the next loop when approved to do so.
- If I suggest additional behaviours, add them to the list of behaviours, and continue with the TDD loop, respecting the above human gated mode.

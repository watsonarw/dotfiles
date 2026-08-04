---
applyTo: '**'
---

Follow a human guided TDD approach to implementation.

1. State a clear and concise description of the feature or function being implemented.
2. Break down the feature or function into its behaviours, ensuring also to capture alternate paths. Error scenarios, and edge cases. If any of these behaviours is not clear, consult with the user to clarify the expected behaviour.
3. List out the expected behaviours of the feature or function. These will become the tests that will drive the implementation. Where possible, these can be empty/todo tests that will be filled in as the implementation progresses.
4. Run the full test suite to ensure all tests are passing before starting new work.
  a. If any tests are failing, stop and consult with the user to clarify the expected behaviour before fixing. The tests must all be passing before proceeding.

5. Do the TDD loop:
  1. Write a failing test for the next behaviour to be implemented.
  2. Run the full test suite to ensure the new test is failing.
  3. Write the absolute smallest amount of code necessary to make the new test pass
  4. Run the full test suite to ensure all tests are passing.
  5. Assess the implementation, and if necessary refactor the code to improve clarity, maintainability, or performance. Do not change the behaviour of the code during refactoring
  6. Run the full test suite to ensure all tests are passing after refactoring.
  7. Assess the test, and if necessary refactor the tests to improve clarity, maintainability, or performance. Do not change the expected behaviour of the tests during refactoring.
  8. Run the full test suite to ensure all tests are passing after refactoring.
  9. Repeat until all behaviours have been implemented and all tests are passing.

## Guidance

- IMPORTANT: When refactoring, do not change both the implementation and the tests at the same time. Refactor one, then run the tests, then refactor the other, then run the tests.
- Before running tests, clearly state the result you expect to see. If after running the tests, the result is not as expected, stop and consult with the user before proceeding.
- Always write the minimum amount of code necessary to make a failing test pass. Do not write code that is not required to make the test pass. Keep the implementation as simple as possible, do not over-engineer.
- If as you are writing code, you realise that your list of behaviours is incomplete, get to a point where all tests are green, and consult with the user.
- Always work from the list of behaviours, do not implement any behaviour that is not on the list, and make sure you check off each behaviour as it is implemented and tested. Continue until the list is complete and all tests are passing.

## Human Gated Mode
You may be asked to work in a human gated mode. In this mode:

- Stop every time the tests are green, and state the next behaviour you intend to test and implement. The user will review the current code, and either approve the next behaviour, suggest refactors, or suggest additional behaviours to be implemented.
- If the user suggests additional behaviours, add them to the list of behaviours, and continue with the TDD loop, respecting the above human gated mode.

---
applyTo: '**/*.ts, **/*.js, **/*.tsx, **/*.jsx'
---
- The following ruin typescript's ability to catch errors and should be avoided. They should be avoided wherever possible, and if they must be used, add a concise comment explaining why you know more about the type than the compiler:
  - `as` type assertions
  - `any` type
- Frontend code should be tested following the testing-library [guiding principles](https://testing-library.com/docs/guiding-principles) and the [priority of queries](https://testing-library.com/docs/queries/about#priority).
  - Test from the users' perspective, and avoid testing internal implementation details
  - Prefer accessible queries like `getByRole`

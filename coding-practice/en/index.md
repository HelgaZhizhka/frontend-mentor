# Code Review and Clean Code Practices

Practical guides for writing high-quality code, code reviews, and best development practices.

## 📚 Materials

### [Part 1: Clean Code Fundamentals](Clean-Code-Fundamental-Part1.md)

Basic principles of writing clean, readable, and maintainable code.

#### Sections:
- [**Why clean code matters?**](Clean-Code-Fundamental-Part1.md#why-clean-code-matters)
- [**1. Naming Conventions**](Clean-Code-Fundamental-Part1.md#1-naming-conventions)
  - [1.1 General principles](Clean-Code-Fundamental-Part1.md#11-general-principles)
  - [1.2 Variables](Clean-Code-Fundamental-Part1.md#12-variables)
  - [1.3 Functions](Clean-Code-Fundamental-Part1.md#13-functions)
  - [1.4 Classes and components](Clean-Code-Fundamental-Part1.md#14-classes-and-components)
  - [1.5 Boolean variables](Clean-Code-Fundamental-Part1.md#15-boolean-variables)
  - [1.6 Naming anti-patterns](Clean-Code-Fundamental-Part1.md#16-naming-anti-patterns)
- [**2. Functions and methods**](Clean-Code-Fundamental-Part1.md#2-functions-and-methods)
  - [2.1 Function size](Clean-Code-Fundamental-Part1.md#21-function-size)
  - [2.2 Function parameters](Clean-Code-Fundamental-Part1.md#22-function-parameters)
  - [2.3 Side Effects](Clean-Code-Fundamental-Part1.md#23-side-effects)
  - [2.4 Single Responsibility for functions](Clean-Code-Fundamental-Part1.md#24-single-responsibility-for-functions)
  - [2.5 Return values](Clean-Code-Fundamental-Part1.md#25-return-values)
  - [2.6 Arrow functions vs regular functions](Clean-Code-Fundamental-Part1.md#26-arrow-functions-vs-regular-functions)
- [**3. Comments and documentation**](Clean-Code-Fundamental-Part1.md#3-comments-and-documentation)
  - [3.1 When comments are NOT needed](Clean-Code-Fundamental-Part1.md#31-when-comments-are-not-needed)
  - [3.2 When comments are useful](Clean-Code-Fundamental-Part1.md#32-when-comments-are-useful)
  - [3.3 JSDoc](Clean-Code-Fundamental-Part1.md#33-jsdoc)
  - [3.4 TODO/FIXME](Clean-Code-Fundamental-Part1.md#34-todofixme)
  - [3.5 Comments "why", not "what"](Clean-Code-Fundamental-Part1.md#35-comments-why-not-what)
- [**4. Error handling**](Clean-Code-Fundamental-Part1.md#4-error-handling)
  - [4.1 Try-Catch rules](Clean-Code-Fundamental-Part1.md#41-try-catch-rules)
  - [4.2 Fail Fast principle](Clean-Code-Fundamental-Part1.md#42-fail-fast-principle)
  - [4.3 Defensive Programming](Clean-Code-Fundamental-Part1.md#43-defensive-programming)
- [**5. Code Smells and refactoring**](Clean-Code-Fundamental-Part1.md#5-code-smells-and-refactoring)
  - [5.1 Duplicated Code](Clean-Code-Fundamental-Part1.md#51-duplicated-code)
  - [5.2 Long Method](Clean-Code-Fundamental-Part1.md#52-long-method)
  - [5.3 Large Class](Clean-Code-Fundamental-Part1.md#53-large-class)
  - [5.4 Long Parameter List](Clean-Code-Fundamental-Part1.md#54-long-parameter-list)
  - [5.5 Magic Numbers and Magic Strings](Clean-Code-Fundamental-Part1.md#55-magic-numbers-and-magic-strings)
  - [5.6 Dead Code](Clean-Code-Fundamental-Part1.md#56-dead-code)
  - [5.7 Deep Nesting](Clean-Code-Fundamental-Part1.md#57-deep-nesting)
  - [5.8 Primitive Obsession](Clean-Code-Fundamental-Part1.md#58-primitive-obsession)
  - [5.9 Switch Statements](Clean-Code-Fundamental-Part1.md#59-switch-statements)
  - [5.10 Shotgun Surgery](Clean-Code-Fundamental-Part1.md#510-shotgun-surgery)
- [**6. Code organization**](Clean-Code-Fundamental-Part1.md#6-code-organization)
  - [6.1 Formatting](Clean-Code-Fundamental-Part1.md#61-formatting)
  - [6.2 Code order](Clean-Code-Fundamental-Part1.md#62-code-order)
  - [6.3 Import order](Clean-Code-Fundamental-Part1.md#63-import-order)
- [**7. Data handling**](Clean-Code-Fundamental-Part1.md#7-data-handling)
  - [7.1 Immutability](Clean-Code-Fundamental-Part1.md#71-immutability)
  - [7.2 Arrays](Clean-Code-Fundamental-Part1.md#72-arrays)
  - [7.3 Objects](Clean-Code-Fundamental-Part1.md#73-objects)
  - [7.4 Null and Undefined](Clean-Code-Fundamental-Part1.md#74-null-and-undefined)
- [**8. Asynchronous code**](Clean-Code-Fundamental-Part1.md#8-asynchronous-code)
  - [8.1 Promises](Clean-Code-Fundamental-Part1.md#81-promises)
  - [8.2 Async/Await](Clean-Code-Fundamental-Part1.md#82-async-await)
  - [8.3 Anti-patterns](Clean-Code-Fundamental-Part1.md#83-anti-patterns)
- [**9. Performance**](Clean-Code-Fundamental-Part1.md#9-performance)
  - [9.1 Premature optimization](Clean-Code-Fundamental-Part1.md#91-premature-optimization)
  - [9.2 When to optimize](Clean-Code-Fundamental-Part1.md#92-when-to-optimize)
  - [9.3 Simple optimizations](Clean-Code-Fundamental-Part1.md#93-simple-optimizations)
- [**10. Code testability**](Clean-Code-Fundamental-Part1.md#10-code-testability)
  - [10.1 What makes code testable](Clean-Code-Fundamental-Part1.md#101-what-makes-code-testable)
  - [10.2 Signs of untestable code](Clean-Code-Fundamental-Part1.md#102-signs-of-untestable-code)
  - [10.3 Refactoring for tests](Clean-Code-Fundamental-Part1.md#103-refactoring-for-tests)
- [**11. Additional practices**](Clean-Code-Fundamental-Part1.md#11-additional-practices)
  - [11.1 Avoid global variables](Clean-Code-Fundamental-Part1.md#111-avoid-global-variables)
  - [11.2 Avoid parameter mutation](Clean-Code-Fundamental-Part1.md#112-avoid-parameter-mutation)
  - [11.3 Arrow functions for methods](Clean-Code-Fundamental-Part1.md#113-arrow-functions-for-methods)
  - [11.4 Prefer objects over switch-case](Clean-Code-Fundamental-Part1.md#114-prefer-objects-over-switch-case)
  - [11.5 Use const by default](Clean-Code-Fundamental-Part1.md#115-use-const-by-default)
  - [11.6 Be careful with setTimeout and setInterval](Clean-Code-Fundamental-Part1.md#116-be-careful-with-settimeout-and-setinterval)

### [Part 2: Refactoring and Code Organization](Clean-Code-Fundamental-Part2.md)

Refactoring techniques, code smells, and better code organization.

#### Sections:
- [**1. Code Smells**](Clean-Code-Fundamental-Part2.md#1-code-smells)
  - [1.1 Duplicated Code](Clean-Code-Fundamental-Part2.md#11-duplicated-code)
  - [1.2 Long Method](Clean-Code-Fundamental-Part2.md#12-long-method)
  - [1.3 Large Class](Clean-Code-Fundamental-Part2.md#13-large-class)
  - [1.4 Long Parameter List](Clean-Code-Fundamental-Part2.md#14-long-parameter-list)
  - [1.5 Magic Numbers and Magic Strings](Clean-Code-Fundamental-Part2.md#15-magic-numbers-and-magic-strings)
  - [1.6 Dead Code](Clean-Code-Fundamental-Part2.md#16-dead-code)
  - [1.7 Primitive Obsession](Clean-Code-Fundamental-Part2.md#17-primitive-obsession)
  - [1.8 Switch Statements](Clean-Code-Fundamental-Part2.md#18-switch-statements)
  - [1.9 Shotgun Surgery](Clean-Code-Fundamental-Part2.md#19-shotgun-surgery)
- [**2. Code organization**](Clean-Code-Fundamental-Part2.md#2-code-organization)
  - [2.1 Formatting](Clean-Code-Fundamental-Part2.md#21-formatting)
  - [2.2 Code order](Clean-Code-Fundamental-Part2.md#22-code-order)
  - [2.3 Import order](Clean-Code-Fundamental-Part2.md#23-import-order)

### [Part 3: Advanced Clean Code Practices](Clean-Code-Fundamental-Part3.md)

Deep dive into clean code concepts: data handling, asynchronous code, and performance.

#### Sections:
- [**1. Data handling**](Clean-Code-Fundamental-Part3.md#1-data-handling)
  - [1.1 Avoid global variables](Clean-Code-Fundamental-Part3.md#11-avoid-global-variables)
  - [1.2 Use const by default](Clean-Code-Fundamental-Part3.md#12-use-const-by-default)
  - [1.3 Avoid parameter mutation](Clean-Code-Fundamental-Part3.md#13-avoid-parameter-mutation)
  - [1.4 Immutability](Clean-Code-Fundamental-Part3.md#14-immutability)
  - [1.5 Arrays](Clean-Code-Fundamental-Part3.md#15-arrays)
  - [1.6 Objects](Clean-Code-Fundamental-Part3.md#16-objects)
  - [1.7 Null and Undefined](Clean-Code-Fundamental-Part3.md#17-null-and-undefined)
- [**2. Asynchronous code**](Clean-Code-Fundamental-Part3.md#2-asynchronous-code)
  - [2.1 Promises](Clean-Code-Fundamental-Part3.md#21-promises)
  - [2.2 Async/Await](Clean-Code-Fundamental-Part3.md#22-async-await)
  - [2.3 Anti-patterns](Clean-Code-Fundamental-Part3.md#23-anti-patterns)

### [Part 4: Performance and Code Testability](Clean-Code-Fundamental-Part4.md)

Performance considerations and code testability.

#### Sections:
- [**Performance and testing**](Clean-Code-Fundamental-Part4.md#performance-and-testing)
  - [**1. Premature optimization**](Clean-Code-Fundamental-Part4.md#1-premature-optimization)
  - [**1.1 When to optimize**](Clean-Code-Fundamental-Part4.md#11-when-to-optimize)
  - [**1.2 Simple optimizations**](Clean-Code-Fundamental-Part4.md#12-simple-optimizations)
  - [**2. Code testability**](Clean-Code-Fundamental-Part4.md#2-code-testability)
    - [2.1 What makes code testable](Clean-Code-Fundamental-Part4.md#21-what-makes-code-testable)
    - [2.2 Signs of untestable code](Clean-Code-Fundamental-Part4.md#22-signs-of-untestable-code)
    - [2.3 Refactoring for tests](Clean-Code-Fundamental-Part4.md#23-refactoring-for-tests)

### [Part 5: Architectural Patterns and Principles](Clean-Code-Fundamentals-Part5.md)

SOLID principles - the foundation of application architecture.

#### Sections:
- [**1. SOLID Principles**](Clean-Code-Fundamentals-Part5.md#1-solid-principles)
  - [1.1 S - Single Responsibility Principle](Clean-Code-Fundamentals-Part5.md#11-s---single-responsibility-principle)
  - [1.2 O - Open/Closed Principle](Clean-Code-Fundamentals-Part5.md#12-o---openclosed-principle)
  - [1.3 L - Liskov Substitution Principle](Clean-Code-Fundamentals-Part5.md#13-l---liskov-substitution-principle)
  - [1.4 I - Interface Segregation Principle](Clean-Code-Fundamentals-Part5.md#14-i---interface-segregation-principle)
  - [1.5 D - Dependency Inversion Principle](Clean-Code-Fundamentals-Part5.md#15-d---dependency-inversion-principle)
- [**2. KISS (Keep It Simple, Stupid)**](Clean-Code-Fundamentals-Part5.md#2-kiss-keep-it-simple-stupid)
- [**3. DRY (Don't Repeat Yourself)**](Clean-Code-Fundamentals-Part5.md#3-dry-dont-repeat-yourself)
- [**4. YAGNI (You Aren't Gonna Need It)**](Clean-Code-Fundamentals-Part5.md#4-yagni-you-arent-gonna-need-it)
- [**5. Separation of Concerns**](Clean-Code-Fundamentals-Part5.md#5-separation-of-concerns)
- [**6. Composition over Inheritance**](Clean-Code-Fundamentals-Part5.md#6-composition-over-inheritance)
- [**7. Fail Fast**](Clean-Code-Fundamentals-Part5.md#7-fail-fast)

### [Part 6: Additional Practices](Clean-Code-Fundamentals-Part6.md)

Remaining recommendations and anti-patterns.

#### Sections:
- [**1. Arrow functions for methods**](Clean-Code-Fundamentals-Part6.md#1-arrow-functions-for-methods)
- [**2. Be careful with setTimeout and setInterval**](Clean-Code-Fundamentals-Part6.md#2-be-careful-with-settimeout-and-setinterval)

### [React Best Practices](React.md)

Best practices for React development.

#### Sections:
- [**1. Project structure and imports**](React.md#1-project-structure-and-imports)
  - [1.1 Using aliases for imports](React.md#11-using-aliases-for-imports)
  - [1.2 Import order](React.md#12-import-order)
  - [1.3 Component structure and imports: best practices](React.md#13-component-structure-and-imports-best-practices)
  - [1.4 File and folder naming](React.md#14-file-and-folder-naming)
- [**2. React Components**](React.md#2-react-components)
  - [2.1 Arrow functions for components](React.md#21-arrow-functions-for-components)
  - [2.2 Component typing](React.md#22-component-typing)
  - [2.3 Using `React.memo()`](React.md#23-using-reactmemo)
  - [2.4 Splitting large components](React.md#24-splitting-large-components)
  - [2.5 Event handlers](React.md#25-event-handlers)
  - [2.6 Code shortening with destructuring](React.md#26-code-shortening-with-destructuring)
- [**3. React Hooks**](React.md#3-react-hooks)
  - [3.1 `useCallback`](React.md#31-usecallback)
  - [3.2 Extracting logic into custom hooks](React.md#32-extracting-logic-into-custom-hooks)
  - [3.3 `AbortController` in `useEffect`](React.md#33-abortcontroller-in-useeffect)
- [**4. Optimization and Performance**](React.md#4-optimization-and-performance)
  - [4.1 Conditional rendering](React.md#41-conditional-rendering)
  - [4.2 Library import optimization](React.md#42-library-import-optimization)
  - [4.3 Moving complex calculations to variables](React.md#43-moving-complex-calculations-to-variables)
- [**5. Form handling**](React.md#5-form-handling)
  - [5.1 `autoComplete` attribute](React.md#51-autocomplete-attribute)
  - [5.2 Validation and error handling](React.md#52-validation-and-error-handling)
- [**6. Theme handling**](React.md#6-theme-handling)
  - [6.1 Global CSS variables instead of `useTheme`](React.md#61-global-css-variables-instead-of-usetheme)
- [**7. Next.js Best Practices**](React.md#7-nextjs-best-practices)
  - [7.1 Using `Link` instead of custom navigation](React.md#71-using-link-instead-of-custom-navigation)
- [**8. React Anti-patterns**](React.md#8-react-anti-patterns)
  - [8.1 Do NOT use `dangerouslySetInnerHTML`](React.md#81-do-not-use-dangerouslysetinnerhtml)
  - [8.2 Always add `key` in `map()`](React.md#82-always-add-key-in-map)
  - [8.3 Remove `console.log()` before production](React.md#83-remove-consolelog-before-production)
  - [8.4 Remove comments before final PR](React.md#84-remove-comments-before-final-pr)

### [TypeScript Best Practices](TypeScript.md)

Best practices for TypeScript development.

#### Sections:
- [**1. Basic typing**](TypeScript.md#1-basic-typing)
  - [1.1 Forbid `any`](TypeScript.md#11-forbid-any)
  - [1.2 Use `unknown` instead of `any`](TypeScript.md#12-use-unknown-instead-of-any)
  - [1.3 Forbid `{}` and `object`](TypeScript.md#13-forbid--and-object)
  - [1.4 Explicit return types for functions](TypeScript.md#14-explicit-return-types-for-functions)
- [**2. `type` vs `interface`**](TypeScript.md#2-type-vs-interface)
  - [2.1 When to use `type`](TypeScript.md#21-when-to-use-type)
  - [2.2 When to use `interface`](TypeScript.md#22-when-to-use-interface)
- [**3. Enum vs const objects**](TypeScript.md#3-enum-vs-const-objects)
  - [3.1 Why `enum` is bad](TypeScript.md#31-why-enum-is-bad)
  - [3.2 Using `as const`](TypeScript.md#32-using-as-const)
- [**4. Type Guards and Type Assertions**](TypeScript.md#4-type-guards-and-type-assertions)
  - [4.1 Type Assertion (`as`)](TypeScript.md#41-type-assertion-as)
  - [4.2 Type Guards (`typeof`, `instanceof`, `is`)](TypeScript.md#42-type-guards-typeof-instanceof-is)
- [**5. Constants and Magic Values**](TypeScript.md#5-constants-and-magic-values)
  - [5.1 Extracting numeric values](TypeScript.md#51-extracting-numeric-values)
  - [5.2 Extracting strings to constants](TypeScript.md#52-extracting-strings-to-constants)
  - [5.3 Using `as const` for objects](TypeScript.md#53-using-as-const-for-objects)
- [**6. TypeScript Configuration**](TypeScript.md#6-typescript-configuration)
  - [6.1 Strict rules in `tsconfig.json`](TypeScript.md#61-strict-rules-in-tsconfigjson)
  - [6.2 ESLint rules](TypeScript.md#62-eslint-rules)

### [Code Review Checklist: Clean Code](Check-List.md)

A practical checklist for conducting code reviews according to clean code principles.

## 🎯 How to use the materials

1. **Study by topics** — each chapter is dedicated to a specific practice
2. **Look at examples** — each section has "bad-good" examples
3. **Apply in practice** — try refactoring your own code
4. **Use during code reviews** — check these rules when reviewing PRs

## 📖 Additional resources

- [Clean Code: A Handbook of Agile Software Craftsmanship](https://www.oreilly.com/library/view/clean-code-a/9780136083238/) — Robert Martin
- [Refactoring: Improving the Design of Existing Code](https://martinfowler.com/books/refactoring.html) — Martin Fowler
- [The Pragmatic Programmer](https://pragprog.com/titles/tpp20/the-pragmatic-programmer-20th-anniversary-edition/) — Andrew Hunt and David Thomas

## 🔄 Material support

Materials are regularly updated. Suggestions for improvement are welcome!

---
*Last update: November 2025*

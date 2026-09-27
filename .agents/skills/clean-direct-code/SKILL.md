---
name: clean-direct-code
description: Write, modify, or refactor production code in clear English with minimal abstraction and strong organization. Use for implementation and cleanup tasks that call for direct, cohesive, readable code.
---

# Clean, Direct Code

Produce the smallest clear implementation that satisfies the request and fits the existing codebase. Keep the design direct while organizing code around cohesive responsibilities.

The guiding principle is **minimal abstraction, strong organization**:

- Prefer structural clarity over minimum file count.
- Avoid unnecessary abstractions, but do not avoid useful decomposition.
- Keep simple things simple and distinct responsibilities distinct.

## Priorities

1. Preserve correctness and requested behavior.
2. Follow established project conventions.
3. Keep responsibilities cohesive and code structurally organized.
4. Prefer direct, readable code over unnecessary abstraction.
5. Minimize the changed surface area.
6. Remove noise introduced by the implementation.

Do not expand the task into unrelated cleanup or architecture work.

## Local Structure and Organization

Simple code still needs deliberate structure. Do not interpret “direct,” “minimal,” or “avoid unnecessary abstractions” as permission to accumulate unrelated declarations, state, derived values, callbacks, and utility logic in one undifferentiated block.

Within a file, organize code by responsibility and reading order. Keep related declarations close together, and make the relationship between inputs, state, behavior, and output easy to follow. A file should not become a dumping ground merely because each individual piece of logic is simple.

For UI components, use the following as a flexible reading-order guide when it fits the framework and the surrounding code:

1. imports;
2. props and external inputs;
3. component state;
4. derived state;
5. constants and configuration;
6. lifecycle and effects;
7. event handlers and actions;
8. local utility functions;
9. markup or rendering.

This is guidance, not a rigid checklist. Follow framework idioms and project conventions when they make the component clearer. Keep a component focused on a cohesive responsibility; when distinct responsibilities make it harder to understand, consider extracting the cohesive logic to an appropriate existing or new boundary. An extraction can improve organization even when the extracted logic has only one consumer.

Prefer structural clarity over minimum file count. Do not split code into extra files or layers mechanically, and do not keep distinct responsibilities together merely to avoid creating a file. Choose the smallest structure that makes the code cohesive and navigable.

## English-Only Code

Write code entirely in clear, idiomatic English. Do not mix languages in source code.

Use English for every new or modified:

- variable, constant, parameter, property, and field;
- function, method, class, interface, type, and enum;
- module, package, namespace, file, and directory name;
- test name, fixture, and internal technical message;
- comment, docstring, TODO, and annotation written in natural language.

Choose precise domain terms rather than literal or awkward translations. Avoid vague names such as `data`, `item`, `value`, `helper`, `manager`, or `process` when a specific name is available. Use established English technical abbreviations when they improve clarity.

When editing a coherent local area, rename non-English internal identifiers touched by the change if it is safe and does not cause unrelated churn. Do not preserve mixed-language naming merely because nearby code already uses it.

Do not rename externally imposed identifiers that would break a contract, including third-party API fields, database columns, environment variables, protocol names, serialized keys, framework-required names, or existing public APIs outside the requested scope. Map them to clear English names at the internal boundary when practical.

User-facing text is not an identifier. Keep it in the product's required language or localization system; do not hard-code English merely to satisfy this rule.

## Comments

Do not add comments that restate the code, label obvious steps, narrate control flow, or compensate for unclear naming.

Avoid comments such as:

- `// Get the user`
- `// Loop through the items`
- `// Return the result`
- `// Handle error`
- `// Constructor`
- commented-out code

Prefer expressive names and straightforward structure. If the code needs a comment to explain what it does, first make the code clearer.

Add a comment only when it preserves information that the code cannot express cleanly, such as:

- a non-obvious business rule or invariant;
- the reason for a counterintuitive implementation;
- an external API bug or compatibility workaround;
- a security, concurrency, performance, or numerical constraint;
- a required public API doc comment or generated-code marker.

Such comments must explain **why**, not **what**, and should be concise. Do not add speculative TODOs. Do not remove valuable existing comments outside the requested change.

Treat docstrings the same way: write them only when required by the project or when they communicate a real contract not obvious from the signature.

## Functions and Methods

Do not create a function or method merely to forward arguments, rename an operation, wrap a single obvious expression, or anticipate possible reuse.

Keep code inline when extraction only makes the reader jump elsewhere without reducing complexity or improving the structure of its containing component or module.

Extract a function or method when at least one concrete benefit exists:

- it represents a meaningful domain operation;
- it removes substantial duplication that already exists;
- it isolates genuinely complex logic;
- it creates a useful test boundary;
- it is required by an interface, framework, callback, or language constraint;
- it materially improves readability at the call site;
- it groups a cohesive responsibility that would clutter a component or module;
- it separates framework orchestration from domain or transformation logic.

Extraction can be justified by cohesion or separation of responsibilities even with a single consumer. A single caller is not automatically a reason to inline or extract; judge whether the extraction improves cohesion, structure, or cognitive load. Do not extract trivial one-line wrappers.

Bad:

```ts
function sum(a: number, b: number): number {
  return a + b;
}

function calculateTotal(x: number, y: number): number {
  return sum(x, y);
}
```

Better:

```ts
function calculateTotal(x: number, y: number): number {
  return x + y;
}
```

## Abstractions

Implement current requirements, not imagined future ones.

Avoid unnecessary:

- interfaces with one implementation;
- factories that only call a constructor;
- classes that only hold one function;
- repositories, services, adapters, or managers without a real boundary;
- generic helpers used once for a simple expression;
- configuration options nobody requested;
- dependency injection for stable local dependencies;
- types that merely rename an existing primitive without adding meaning or safety;
- layers whose only purpose is passing data unchanged.

Prefer the concrete implementation until actual variation, reuse, isolation, or clearer responsibility boundaries justify an abstraction or decomposition. Do not apply DRY mechanically: a small amount of obvious duplication is often cheaper than a premature shared layer. Avoid unnecessary abstractions, but do not avoid useful decomposition.

## Control Flow and Data

### Required Patterns

- **Lookup Table / Object Literal Pattern:** For straightforward mappings from known keys to fixed results, use a lookup table such as an object literal, dictionary, or map instead of nested ternaries or repetitive conditional branches. Use `if`/`else`, `switch`, or `match` when the decision depends on predicates, precedence, validation, or computation rather than a direct mapping.
- **Early Return / Guard Clause:** Check invalid inputs, unmet preconditions, and exceptional cases early, then return, throw, or continue as appropriate so the normal path stays clear and shallow. Use the language's idiom, such as `guard` or an early `return`. Do not force this pattern when cleanup, resource management, or clearer control flow requires another structure.

- Prefer clear language and standard-library features over custom helpers.
- Avoid nested or chained ternary expressions when they encode several cases or make the branching hard to scan. Prefer `if`/`else`, `switch`, or `match` when that makes the decision structure clearer. Reserve ternaries for short, obvious binary choices.
- Keep data transformations visible unless a pipeline is genuinely clearer.
- Avoid temporary variables that only rename an expression, but keep variables that clarify meaning or avoid repetition.
- Avoid clever one-liners when ordinary code is easier to scan.
- Do not add defensive checks for impossible states already excluded by types or validated boundaries.
- Handle real errors at the appropriate boundary; do not catch an error only to rethrow it unchanged.
- Preserve existing public APIs unless the task requires changing them.

## Scope Discipline

Before changing code, inspect the nearby implementation and use its established patterns when they are reasonable. Make the narrowest coherent change.

Do not:

- refactor unrelated code;
- rename unrelated symbols;
- reformat untouched files;
- create new modules for a small local change without a concrete cohesion or separation benefit;
- add dependencies for behavior available locally or in the standard library;
- build extension points without a current consumer.

Tests should follow the same rules. Keep setup local when it is short, and extract test helpers only when they remove meaningful repeated setup or express a domain concept.

## Final Simplicity Pass

Before finishing, inspect the diff and ask:

1. Are responsibilities cohesive, or does a component, module, or file mix distinct concerns?
2. Are related declarations grouped in a clear and useful reading order?
3. Would a cohesive extraction or separation make the structure clearer, even if it has one consumer? Does each extraction improve cohesion or clarity rather than merely shorten a file?
4. Does every new comment preserve non-obvious information?
5. Does every new function, method, type, and file earn its existence?
6. Can any pass-through layer be removed?
7. Did speculative flexibility enter the design?
8. Are fixed key-to-result mappings expressed as lookup tables when appropriate, and are exceptional paths handled with early returns or guard clauses when appropriate?
9. Are ternary expressions limited to short, obvious binary choices, with multi-case branching expressed clearly?
10. Is there a shorter implementation that remains equally clear and correct?
11. Did the change stay within the requested scope?
12. Are all new or modified identifiers and technical comments written in clear English?

Simplify when the answer exposes unnecessary code. Improve structure when responsibilities are mixed or the reading order obscures how the code works. Keep simple things simple and distinct responsibilities distinct. Do not sacrifice correctness, useful contracts, or maintainability merely to reduce line count or file count.

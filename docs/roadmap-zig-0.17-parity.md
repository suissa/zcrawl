# Zig 0.17 parity roadmap (zcrawl)

Goal: bring `zcrawl` on Zig 0.16 to functional parity with relevant capabilities documented in [icecrawl](https://github.com/suissa/icecrawl), without silently introducing Zig 0.17-only APIs.

Upstream references:
- https://github.com/suissa/zcrawl
- https://github.com/suissa/icecrawl
- https://github.com/suissa/icecrawl/blob/main/DOCUMENTATION.md

> GitHub Issues are currently disabled for this repository. The checklist below preserves the proposed issue backlog until Issues are enabled.

## P0 — Establish an evidence-based baseline

- [ ] **Parity matrix:** compare public APIs, semantics, tests and build requirements; record each capability as present, partial, missing or intentionally different.
- [ ] **CSS selector grammar:** audit child/adjacent/general sibling combinators, selector groups, attribute selectors, pseudo-classes, escaping and invalid syntax; implement missing supported grammar with tests.
- [ ] **Matching and scope semantics:** test RTL matching, node matching versus scoped queries, and behavior for relative selectors and combinators.
- [ ] **DOM navigation:** compare parent/children/first-last child/sibling APIs and optional storage metadata; document complexity and memory tradeoffs.

## P1 — Parsing and query semantics

- [ ] **Non-destructive parsing:** support read-only input without modifying source bytes; avoid a full-source copy where feasible and document input lifetime.
- [ ] **Text and entity decoding:** compare text-content/inner-text behavior, whitespace normalization, named/numeric entities, invalid references, NUL and malformed UTF-8.
- [ ] **Attribute API parity:** verify raw versus decoded values, valueless/empty attributes, duplicate attributes, malformed markup recovery and ownership of allocated results.
- [ ] **Selector API parity:** verify compile-time, runtime-compiled and cached-runtime selector paths, including identical semantics and deterministic errors.

## P1 — Conformance and regression coverage

- [ ] **HTML5 tokenizer/tree-construction fixtures:** integrate or refresh html5lib fixtures and clearly separate tokenizer tests from tree-construction tests.
- [ ] **Malformed HTML regression suite:** cover EOF in tokenizer states, malformed tags/attributes, comments, raw-text elements, duplicate attributes and recovery behavior.
- [ ] **Conformance report:** emit reproducible pass/fail/skipped counts and preserve minimized regression fixtures for every fixed bug.

## P2 — Performance and distribution

- [ ] **Reproducible benchmarks:** compare identical fixtures and build modes; measure parsing, query throughput, repeated/cached queries and memory/allocation costs.
- [ ] **Parse profiles and index widths:** compare configurable parse profiles and integer-width options; test overflow/input-too-large behavior and defaults.
- [ ] **Package/install validation:** verify `build.zig.zon`, module naming, `zig fetch`, and a clean consumer project using Zig 0.16.0.
- [ ] **Examples/docs/CI gates:** compile every public example and documentation snippet; run formatting, tests, package checks and fixture setup in CI.

## Definition of done

- Every parity claim points to code and a reproducible test.
- The documented baseline includes versions, commands, test totals and known divergences.
- All required tests pass on Zig 0.16.0.
- Performance claims use the same fixtures and comparable build settings.
- Any intentional difference from icecrawl is documented with its rationale.

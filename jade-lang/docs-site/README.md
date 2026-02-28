# Jade documentation site

Static documentation site for the Jade programming language. All content is derived from the interpreter (lexer, parser, eval, builtins). Code examples go from **basic to advanced**.

## Structure

- **index.html** — Homepage with Jade logo, hero gradient, features, and code showcase (basic → advanced)
- **assets/jade.png** — Jade logo (copy from `installers/windows/icon/jade.png` if missing)
- **docs/** — Documentation pages
  - **getting-started.html** — Install, run, REPL, check, build, first program
  - **syntax.html** — Functions, variables, operators, literals, keywords
  - **control-flow.html** — if, match, cond, when, unless, either, switch, for, while, try/catch, defer, guard
  - **types.html** — Primitives, collections, ranges, type names, indexing
  - **functions.html** — Declarations, typed/untyped params, lambdas, decorators
  - **reference.html** — **Single-page language reference**: Values (every type + examples, escape sequences), Output (out, colors, tables, progress, gradient), Code examples (basic → advanced), then CLI, grammar, operators, keywords
  - **builtins.html** — Built-in reference (core, math, stats, string, io, algo, dsa, bits, uf, trie, random, crypto, regex)
  - **values.html**, **output.html**, **code-examples.html** — Redirect to reference.html#values, #output, #code-examples

## Viewing locally

Open `index.html` in a browser, or serve the folder:

```bash
cd docs-site
python -m http.server 8000
```

Then visit http://localhost:8000

## Design

Premium dark theme: jade-green accent and gradients, DM Sans + JetBrains Mono, sticky header with logo, hero with gradient background and logo, tier labels (Basic / Intermediate / Advanced) for code, glass-style cards, consistent code blocks and sidebar nav across all docs.

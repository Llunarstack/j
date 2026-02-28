# Jade written in Jade

This folder is **the language coded in the language**: Jade scripts that run on the Jade interpreter and operate on Jade source (parsing, stats, tooling). No separate “bootstrap plan”—just Jade code that works on `.jdl` files.

## Run from repo root

```bash
jade bootstrap/stage0_hello.jdl
jade bootstrap/stage0_stats.jdl
```

- **stage0_hello.jdl** — Prints a short message that Jade is running.
- **stage0_stats.jdl** — Reads a `.jdl` file and reports line count and simple pattern counts (variable/function declarations).

## Adding scripts

Add new `.jdl` files here and extend this README. Keep scripts focused on processing Jade source or the repo.

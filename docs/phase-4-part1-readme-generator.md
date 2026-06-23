# StormForge — Phase 4 (Part 1): The Project Support System Begins — README Generator

**Date:** 2026-05-08  
**Phase:** 4 — Project Support System  
**Status:** In Progress (Part 1 of multiple)

---

## Objectives

- Make every generated project feel like a real tool starter kit, not just a folder with a script in it
- Build the first of four new generator functions: `generate_readme()`
- Add real, useful content to the README instead of an empty touched file

---

## What Phase 4 Is About

Phase 4 adds four new generator functions on top of the structure and code-generation work from Phases 1–3:

- `generate_readme()` — a real README with actual content
- `generate_install_script()` — a working `install.sh`
- `generate_config()` — a key=value config file
- `generate_gitignore()` — a `.gitignore` so the repo stays clean

It also adds `config/` to the directory structure that gets created on every new project.

Because this phase has four distinct pieces, it's being documented one function at a time across multiple days. This entry covers the first one: `generate_readme()`.

---

## The Function

`generate_readme()` replaces the old placeholder behavior. Previously, project creation just ran:

```bash
touch "$project_name/README.md"
```

That left every generated project with an empty file. `generate_readme()` writes real content instead.

The function:

- Takes the project name as `$1`
- Derives the script name using `to_script_name()` — the same translation pattern used in `generate_main_script()`
- Uses `cat > "$project_name/README.md" <<EOF` to write formatted content into the file

The README it generates includes:

- A heading with the actual project name (`# ProjectName`)
- A one-line description
- A **Usage** section with a code block showing how to run the script
- An **Install** section showing `bash install.sh`

In the `create)` block, the old `touch` line was removed and replaced with:

```bash
generate_readme "$project_name"
```

---

## The Bug I Hit

`generate_readme()` got accidentally placed *inside* the heredoc belonging to `generate_main_script()`.

`generate_main_script()`'s heredoc opens with:

```bash
cat > "$project_name/src/${script_name}.sh" <<EOF
```

Everything after that line is content being written into the generated script file — not live Bash running inside `stormforge.sh`. Once `generate_readme()` landed inside that block, two things broke at once:

1. `generate_readme()` itself used its own `<<EOF` to write the README content. Bash hit that closing `EOF` and read it as the end of the *outer* heredoc — cutting `generate_main_script()`'s heredoc short.
2. The leftover `main()` definition and `main "$@"` call — which were meant to be content written into the generated script — got interpreted as real, live Bash. When that stray `main()` executed, it tried to echo `${project_name}`, which had never been set at the global scope. With `set -u` active, that's an instant hard failure: `project_name: unbound variable`.

**The fix:** delete `generate_readme()` out of the heredoc entirely and place it as its own top-level function, after `generate_main_script()` properly closes.

---

## Key Things I Learned

**Heredoc boundary** — A heredoc captures everything between `<<EOF` and the closing `EOF`. The closing `EOF` must sit flush at column 0 — no leading spaces or tabs — or Bash won't recognize it as the terminator. Anything written inside a heredoc is just text destined for a file. It is not executable code, no matter how much it looks like a function definition.

**Nested EOF problem** — Using `<<EOF` inside another heredoc that also terminates on `EOF` is a collision. Bash closes on the first bare `EOF` it encounters, not the one you intended. Each heredoc's open/close pair has to be deliberate and non-overlapping.

**`set -u`** — This flag forces Bash to fail immediately the moment any variable is referenced without being set, rather than silently treating it as empty. An `unbound variable` error is a pointer straight to a scope problem: where was this variable supposed to be defined, and is it actually in scope where it's being used?

**Backtick escaping** — Inside an unquoted heredoc, backticks trigger command substitution. To write a literal backtick into the output file (for example, to produce a markdown code fence), it has to be escaped: `` \` `` outputs a literal backtick instead of attempting to execute something.

**Variable expansion in heredocs** — With an unquoted `<<EOF`, variables like `${project_name}` expand immediately when the heredoc runs, injecting StormForge's own values into the generated file. To write a literal `$variable` into the output file (so it stays a variable in the generated content rather than being expanded), it has to be escaped as `\$variable`.

---

## What's Still Left in Phase 4

- `generate_install_script()` — writes a working `install.sh` into the project
- `generate_config()` — drops a config file into `config/` with key=value defaults
- `generate_gitignore()` — writes a `.gitignore`
- Update the `mkdir` line to include `config/` in the directory structure

---

## One-Line Takeaway

Part 1 of Phase 4 wasn't just "add a README" — it was a hard lesson in heredoc boundaries: code written in the wrong scope doesn't just fail, it executes as something it was never meant to be.
